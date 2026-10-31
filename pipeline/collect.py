"""Score every pair folder of a run with the harness and write one CSV row per translation.

Usage (from the repo root, Docker running):
  python pipeline/collect.py --run-id base01            # reads results/raw/base01, writes results/base01.csv

Columns: run_id, problem, src, tgt, group, priority, status, extraction, total, passed, failed, crashed,
pass_rate, all_crashed (every test crashed: compile/load failure or missing entry point), duration_s,
prompt_tokens, completion_tokens, model. Skipped and errored translations keep their status with empty scores.
"""
from __future__ import annotations

import argparse
import csv
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
HARNESS = ROOT / "harness"
CATEGORY = {"python": "PYTHON", "javascript": "JAVASCRIPT", "java": "JAVA", "scheme": "SCHEME",
            "haskell": "HASKELL", "prolog": "PROLOG"}
FIELDS = ["run_id", "problem", "src", "tgt", "group", "priority", "status", "extraction", "total", "passed",
          "failed", "crashed", "pass_rate", "all_crashed", "duration_s", "prompt_tokens", "completion_tokens", "model"]


def harness_scores(pair_dir: Path, tgt: str) -> dict:
    """Run the harness on one pair folder and parse the target language's block of the report."""
    with tempfile.NamedTemporaryFile(suffix=".txt", delete=False) as tmp:
        report = Path(tmp.name)
    rel = pair_dir.resolve().relative_to(ROOT)
    subprocess.run(["./run_harness.sh", "-f", str(rel), "-r", str(report)], cwd=HARNESS,
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)
    text = report.read_text() if report.exists() else ""
    report.unlink(missing_ok=True)
    block = re.search(rf"^{CATEGORY[tgt]}\n(.*?)^Skipped: ", text, flags=re.M | re.S)
    if not block:
        return {}
    nums = {k: int(v) for k, v in re.findall(r"^(Passed|Failed|Crashed): (\d+)/", block.group(1), flags=re.M)}
    total = int(re.search(r"^Tests: (\d+)", block.group(1), flags=re.M).group(1))
    return {
        "total": total, "passed": nums.get("Passed", 0), "failed": nums.get("Failed", 0),
        "crashed": nums.get("Crashed", 0),
        "pass_rate": round(nums.get("Passed", 0) / total, 3) if total else "",
        "all_crashed": total > 0 and nums.get("Crashed", 0) == total,
    }


def collect(run_dir: Path) -> list[dict]:
    rows = []
    for meta_path in sorted(run_dir.glob("*/*/meta.json")):
        meta = json.loads(meta_path.read_text())
        row = {k: meta.get(k, "") for k in ("run_id", "problem", "src", "tgt", "group", "priority", "status",
                                               "extraction", "duration_s", "model")}
        usage = meta.get("usage") or {}
        row["prompt_tokens"] = usage.get("prompt_tokens", "")
        row["completion_tokens"] = usage.get("completion_tokens", "")
        if meta.get("status") == "ok":
            row.update(harness_scores(meta_path.parent, meta["tgt"]))
        rows.append(row)
        print(f"  {row['problem']:20s} {row['src']:>10s} -> {row['tgt']:<10s} "
              f"{row['status']:7s} {row.get('passed', '')}/{row.get('total', '')}")
    return rows


def summarize(rows: list[dict]) -> None:
    by_pair: dict[tuple, list[float]] = {}
    for r in rows:
        if r.get("pass_rate") != "" and r.get("status") == "ok":
            by_pair.setdefault((r["src"], r["tgt"], r["group"]), []).append(float(r["pass_rate"]))
    print("\nmean pass rate by pair:")
    for (src, tgt, group), rates in sorted(by_pair.items()):
        print(f"  {src:>10s} -> {tgt:<10s} {group:5s} n={len(rates):2d} mean={sum(rates) / len(rates):.2f}")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--results-dir", type=Path, default=ROOT / "results" / "raw",
                    help="must be inside the repo so the harness can reach it (default results/raw)")
    ap.add_argument("--out", type=Path, help="CSV path (default results/<run_id>.csv)")
    args = ap.parse_args(argv)

    run_dir = args.results_dir / args.run_id
    if not run_dir.is_dir():
        raise SystemExit(f"no such run: {run_dir}")
    rows = collect(run_dir)
    out = args.out or ROOT / "results" / f"{args.run_id}.csv"
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(rows)
    summarize(rows)
    print(f"\nwrote {out} ({len(rows)} rows)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
