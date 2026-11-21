"""Processes the Rosetta Code pairs and writes train.jsonl and validation.jsonl for finetuning.

Strips out pairs that match the benchmark problems or do not use one of the defined languages,
capping the total number of records at 4,980.

Usage (from the repo root):
    python pipeline/rosetta_write.py
"""

from datasets import load_dataset
from migrate import target_filename, to_java_class
from prompt import build_messages, load_template, to_java_class, to_package
from pathlib import Path
import random
import json
import pandas as pd
import re
import unicodedata
import sys

ROOT = Path(__file__).parent.parent

SEED = 3407
MAX_RECORDS = 4980

DATASET_REPO = "christopher/rosetta-code"
DATASET_REVISION = "main"

LANGUAGES = ["python", "javascript", "java", "scheme", "haskell", "prolog"]
BENCHMARK_TEXT = ["run-length encoding", "rle", "merge two sorted lists", "merge_sorted",
                  "deduplicate", "dedupe", "bst", "postfix to infix", "postfix to fully parenthesized infix",
                  "infix calculator", "calculator", "balanced brackets", "balanced parentheses",
                  "bank account", "bank", "tiny stack", "stack machine", "lru", "command pipeline",
                  "group by key", "n queens", "n-queens", "bfs", "shortest path length",
                  "permutations", "permutation", "tree traversal"]
DIRECTIONS = [
    (source, target)
    for source in LANGUAGES
    for target in LANGUAGES
    if source != target
]


def keep_record(record: dict) -> bool:
    """
    Returns true if this record should be kept (i.e. not a benchmark problem and of an appropriate language).
    """
    lang = record["language_name"].strip().lower()
    for text in BENCHMARK_TEXT:
        pattern = r"\b" + text + r"\b"
        match = re.search(pattern, record["task_name"].strip(), re.IGNORECASE)
        if match:
            return False
   
    return lang in LANGUAGES

def write_jsonl(records: list, path: Path) -> None:
    """
    Writes the given records to a JSONL at the given path.
    """
    with open(path, "w", encoding="utf-8") as file:
        for record in records:
            file.write(
                json.dumps(
                    record,
                    ensure_ascii=False
                )
                + "\n"
            )

def make_training_record(row, matrix):
    """
    Creates a training record to be written into a JSONL.

    Uses the prompt template defined in `prompts/v1.md`, the same one used for actual generation.
    """
    src = row["source_language"].strip().lower()
    tgt = row["target_language"].strip().lower()

    raw_problem_id = re.sub(r"[ -/:]", "_", row["task_name"].lower())
    problem_id = unicodedata.normalize('NFKD', raw_problem_id).encode('ascii', 'ignore').decode('ascii')
    package = to_package(["results", "raw", "run_id", f"p_{problem_id}", f"{src}_to_{tgt}"])
    fields = {
        "source_language": src,
        "target_language": tgt,
        "source_fence": matrix["languages"][src]["fence"],
        "target_fence": matrix["languages"][tgt]["fence"],
        "source_filename": f"{problem_id}.{matrix['languages'][src]['ext']}",
        "source_code": row["source_code"],
        "target_filename": target_filename(problem_id, tgt, matrix["languages"]),
        "java_package": package,
        "java_class": to_java_class(problem_id),
        "prolog_entry": problem_id,
    }

    template = load_template(ROOT / "pipeline" / "prompts" / "v1.md")
    system, user = build_messages(template, tgt, fields)

    return {
        "task_name": row["task_name"],
        "source_language": src,
        "target_language": tgt,
        "prompt": [
            {
                "role": "system",
                "content": system
            },
            {
                "role": "user",
                "content": user,
            },
        ],
        "completion": [
            {
                "role": "assistant",
                "content": f"```{fields['target_fence']}\n{row['target_code']}\n```",
            }
        ],
    }

def process_dataset(dataframe: pd.DataFrame) -> pd.DataFrame:
    """
    Converts the given dataframe into a dataframe of language pairs.
    """
    source_data = dataframe.rename(columns={
        "language_name": "source_language",
        "code": "source_code",
    })

    target_data = dataframe.rename(columns={
        "language_name": "target_language",
        "code": "target_code",
    })

    pairs = source_data.merge(
        target_data,
        on=["task_url", "task_name", "task_description"],
    )

    pairs = pairs[
        pairs["source_language"] != pairs["target_language"]
    ]

    return pairs

def split_records(task_ids: list, training_records: list) -> tuple[list, list]:
    """
    Splits the given training records into `(train_records, validation_records)`.

    10% of the records are chosen for validation, picked at random. The VALIDATION_SEED
    is static, so the records picked for validation are the same for each run.
    """
    random_generator = random.Random(SEED)
    random_generator.shuffle(task_ids)

    validation_count = int(len(task_ids) * 0.1)

    validation_tasks = set(task_ids[:validation_count])
    training_tasks = set(task_ids[validation_count:])

    train_records = [
        record
        for record in training_records
        if record["task_name"] in training_tasks
    ]

    validation_records = [
        record
        for record in training_records
        if record["task_name"] in validation_tasks
    ]

    return train_records, validation_records


def truncate_records(pairs: pd.DataFrame) -> pd.DataFrame:
    """
    Truncates the number of records to the amount defined in MAX_RECORDS.
    Selects records in round-robin style.
    """
    grouped_pairs = {}

    for direction in DIRECTIONS:
        source_language, target_language = direction

        group = pairs[
            (pairs["source_language"].astype(str).str.strip().str.lower() == source_language)
            & (pairs["target_language"].astype(str).str.strip().str.lower() == target_language)
        ].copy()

        group = group.sample(
            frac=1,
            random_state=SEED,
        ).reset_index(drop=True)

        grouped_pairs[direction] = group

    selected_groups = []
    pointers = {
        direction: 0
        for direction in DIRECTIONS
    }

    while len(selected_groups) < MAX_RECORDS:
        added_record = False

        for direction in DIRECTIONS:
            if len(selected_groups) >= MAX_RECORDS:
                break

            group = grouped_pairs[direction]
            pointer = pointers[direction]

            if pointer < len(group):
                selected_groups.append(
                    group.iloc[[pointer]]
                )
                pointers[direction] += 1
                added_record = True

        if not added_record:
            break

    new_pairs = pd.concat(
        selected_groups,
        ignore_index=True,
    )

    return new_pairs


def main(argv: list[str] | None = None) -> int:
    raw_dataset = load_dataset(
        DATASET_REPO,
        revision=DATASET_REVISION,
    )

    filtered_dataset = raw_dataset.filter(keep_record)
    dataframe = filtered_dataset["train"].to_pandas()

    pairs = truncate_records(process_dataset(dataframe))

    matrix = json.loads(Path(ROOT / "pipeline" / "matrix.json").read_text())

    training_records = [
        make_training_record(row, matrix)
        for _, row in pairs.iterrows()
    ]

    task_ids = sorted(
        set(dataframe["task_name"])
    )

    train_records, validation_records = split_records(task_ids, training_records)

    write_jsonl(train_records, ROOT / "pipeline" / "data" / "train.jsonl")
    write_jsonl(validation_records, ROOT / "pipeline" / "data" / "validation.jsonl")

    print(f"\nwrote train.jsonl ({len(train_records)} records)")
    print(f"wrote validation.jsonl ({len(validation_records)} records)")


if __name__ == "__main__":
    sys.exit(main())
