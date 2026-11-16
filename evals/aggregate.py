"""Provides two main services:
- Aggregates all three measurement types (test pass rate, static heuristics, and rubric scoring)
  into a single CSV, to be processed by figures.py.
- Determines certain statistics: success rate per problem per language pair,
  heuristic counts per heuristic per language pair, and rubric scores per item per language pair.
  These statistics are written to a JSON.

Requires {run_id}.csv (test cases), {run_id}_heuristics.json, and {run_id}_rubric.csv to exist
in the run ID folder. {run_id}.csv must match the format described in pipeline/collect.py;
{run_id}_heuristics.json must match the format described in pipeline/heuristics.py; and 
{run_id}_rubric.csv must match the format described in evals/RUBRICS.md.

Usage (from the repo root):
    python evals/aggregate.py --run-id base01
    
CSV columns: problem, src, tgt, src_paradigm, tgt_paradigm, compiled, pass_rate, heuristic_count,
rubric_score, loc_diff
"""

from pathlib import Path
from collections import Counter
import json
import argparse
import sys
import csv

ROOT = Path(__file__).resolve().parent.parent
CSV_FIELDS = ["problem", "src", "tgt", "src_paradigm", "tgt_paradigm", "compiled", "pass_rate",
          "heuristic_count", "rubric_score", "loc_diff"]
JSON_FIELDS = ["most_successful_problem", "most_failed_problem", "most_common_heuristic", 
               "least_common_heuristic", "highest_rubric_item", "lowest_rubric_item"]


def collect(run_dir: Path, csvs_dir: Path, run_id: str) -> tuple[dict, dict]:
    """
    Collects information from the CSV files in `csvs_dir`, and returns `(aggregate_csv_dict,
    extra_json_dict)`.
    """
    with (
        open(ROOT / "pipeline" / "matrix.json", mode="r") as matrix_data,
        open(csvs_dir / f"{run_id}.csv", mode="r") as test_results_data,
        open(csvs_dir / f"{run_id}_heuristics.json", mode="r") as heuristics_data,
        open(csvs_dir / f"{run_id}_rubric.csv", mode="r") as rubric_data
    ):
        matrix = json.load(matrix_data)
        test_results = csv.DictReader(test_results_data)
        heuristics = json.load(heuristics_data)
        rubric_results = csv.DictReader(rubric_data)

        rubric_json = {}
        for row in rubric_results:
            key = row.pop("problem") + row.pop("src") + row.pop("tgt")
            rubric_json[key] = row

        PAIRS = [(pair["src"], pair["tgt"]) for pair in matrix["pairs"]]

        rows = []
        extra_stats = {pair: {"problem": {}, "heuristics": {}, "rubric": {}} for pair in PAIRS}
        for test_row in test_results:
            # Fetch CSV information
            row = {k: test_row.get(k, "") for k in ("problem", "src", "tgt", "pass_rate")}
            row["compiled"] = test_row["all_crashed"] == "False"
            row["src_paradigm"] = matrix["languages"][row["src"]]["family"]
            row["tgt_paradigm"] = matrix["languages"][row["tgt"]]["family"]
            rubric_row = {k: int(v) for k, v in rubric_json[row["problem"] + row["src"] + row["tgt"]].items()}
            row["rubric_score"] = sum([v for k, v in rubric_row.items() if k.startswith("item")])
            heuristics_item = next((h for h in heuristics[row["problem"]] if h["src"] == row["src"] and h["tgt"] == row["tgt"]), None)
            row["heuristic_count"] = sum([v for v in list(heuristics_item["counts"].values())])

            with open(run_dir / "raw" / run_id / row["problem"] / f"{row['src']}_to_{row['tgt']}" / "meta.json") as meta_file:
                meta = json.load(meta_file)
                with (
                    open(ROOT / "benchmark" / row["problem"] / meta["target_file"]) as benchmark_file,
                    open(run_dir / "raw" / run_id / row["problem"] / f"{row['src']}_to_{row['tgt']}" / meta["target_file"]) as generated_file
                ):
                    generated_lines = [line.strip() for line in generated_file if line.strip()]
                    original_lines = [line.strip() for line in benchmark_file if line.strip()]
                    row["loc_diff"] = len(generated_lines) - len(original_lines)

            rows.append(row)

            # Fetch JSON information
            key = (row["src"], row["tgt"])
            extra_stats[key]["problem"][row["problem"]] = row["pass_rate"]
            extra_stats[key]["heuristics"] = dict(Counter(extra_stats[key]["heuristics"]) + Counter(heuristics_item["counts"]))
            extra_stats[key]["rubric"] = dict(Counter(extra_stats[key]["rubric"]) + Counter(rubric_row))

    # Convert keys from tuples to single strings
    extra_stats = {"_".join(map(str, k)): v for k, v in extra_stats.items()}

    return rows, extra_stats


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--results-dir", type=Path, default=ROOT / "results",
                    help="folder with raw files (default results)")
    ap.add_argument("--csvs-dir", type=Path,
                    help="folder with input CSV files (default results/<run_id>_analysis)")
    ap.add_argument("--out-csv", type=Path, help="CSV path (default results/<run_id>_analysis/<run_id>_aggregate.csv)")
    ap.add_argument("--out-extra", type=Path, help="extra information path (default results/<run_id>_analysis/<run_id>_extra.json)")
    args = ap.parse_args(argv)

    run_dir = args.results_dir
    if not run_dir.is_dir():
        raise SystemExit(f"no such run: {run_dir}")
    csvs_dir = args.csvs_dir or ROOT / "results" / f"{args.run_id}_analysis"
    rows, extra = collect(run_dir, csvs_dir, args.run_id)
    out_csv = args.out_csv or ROOT / "results" / f"{args.run_id}_analysis" / f"{args.run_id}_aggregate.csv"
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    with out_csv.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=CSV_FIELDS)
        writer.writeheader()
        writer.writerows(rows)

    out_extra = args.out_extra or ROOT / "results" / f"{args.run_id}_analysis" / f"{args.run_id}_extra.json"
    with out_extra.open("w", newline="") as f:
        json.dump(extra, f, indent=4)

    print(f"\nCSV: wrote {out_csv} ({len(rows)} rows)")
    print(f"extra: wrote {out_extra} ({len(extra)} items)")
    return 0


if __name__ == "__main__":
    sys.exit(main())

