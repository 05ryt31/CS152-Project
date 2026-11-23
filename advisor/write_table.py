"""Writes the results of the advisor run to a summary markdown table.

Usage:
    python advisor/write_table.py --run-id base01
"""

import sys
import argparse
import json

from pathlib import Path

ROOT = Path(__file__).parent.parent
TABLE_HEADER = """
# Summary

| Id | Paradigm | Language | Confidence |
|---|---|---|---|
"""


def write_summary(run_dir: Path, out_path: Path):
    """
    Obtains all folders in `run_dir` with a `meta.json` and `response.json` and writes a summary of the responses
    to `out_path`.
    """
    file_text = TABLE_HEADER
    for meta_path in sorted(run_dir.glob("*/meta.json")):
        meta = json.loads(meta_path.read_text())
        if meta.get("status") == "ok":
            response = json.loads(Path(meta_path / ".." / "response.json").read_text())
            file_text += f"| {meta['problem']} | {response['paradigm']} | {response['language']} | {response['confidence']} |\n"
    out_path.write_text(file_text)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--results-dir", default=ROOT / "results" / "advisor", 
                    help="location of advisor results (default results/advisor)")
    ap.add_argument("--run-id", required=True, default="base01", help="ID of the run (default base01)")
    ap.add_argument("--out", type=Path, 
                    help="path to out MD (default <results_dir>/<run_id>/SUMMARY.md)")
    args = ap.parse_args(argv)

    out_path = args.out or args.results_dir / args.run_id / "SUMMARY.md"

    run_dir = args.results_dir / args.run_id
    write_summary(run_dir, out_path)

    return 0


if __name__ == "__main__":
    sys.exit(main())

