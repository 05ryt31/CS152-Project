"""Count Rosetta Code coverage for the six benchmark languages.

Usage: uv run --with pandas --with pyarrow python pipeline/data/rosetta_stats.py <rosetta.parquet>
Parquet: https://huggingface.co/datasets/christopher/rosetta-code (data/train-*.parquet)
"""
import sys
from collections import Counter

import pandas as pd

LANGS = ["Python", "JavaScript", "Java", "Scheme", "Haskell", "Prolog"]


def main(path: str) -> None:
    df = pd.read_parquet(path)
    lang = df["language_name"].astype(str).str.strip().str.lower()
    tasks = {name: set(df.loc[lang == name.lower(), "task_name"]) for name in LANGS}

    print(f"rows: {len(df)}")
    for name in LANGS:
        print(f"{name:11s} tasks={len(tasks[name]):5d}")

    cover = Counter(sum(t in s for s in tasks.values()) for t in set().union(*tasks.values()))
    print("\ntasks by number of our languages:", dict(sorted(cover.items())))
    print(">=2 langs:", sum(v for k, v in cover.items() if k >= 2))

    print("\nordered pairs (rows=src, cols=tgt):")
    print(" " * 12 + "".join(f"{n:>11s}" for n in LANGS))
    for a in LANGS:
        row = [0 if a == b else len(tasks[a] & tasks[b]) for b in LANGS]
        print(f"{a:12s}" + "".join(f"{v:11d}" for v in row))
    for b in LANGS:
        print(f"-> {b:11s} {sum(len(tasks[a] & tasks[b]) for a in LANGS if a != b)}")


if __name__ == "__main__":
    main(sys.argv[1])
