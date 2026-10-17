"""Migration batch runner: (problem, src, tgt) -> prompt -> model -> extracted code + sidecar JSON.

Usage (from the repo root):
  python pipeline/migrate.py --run-id run01 --problems-dir harness/tests --problem smoke_io \
      --pairs python:haskell,python:prolog --backend dry
  python pipeline/migrate.py --run-id run01 --problems-dir benchmark --priority 1 \
      --backend http --base-url http://localhost:11434 --model qwen2.5-coder:7b

Output: results/raw/<run_id>/<problem>/<src>_to_<tgt>/{<problem>.<ext>, tests.json, meta.json}
Each pair folder is runnable by the harness (`./run_harness.sh -f <folder>` plus the skip flags for the
other five languages). Resumable: a folder whose meta.json has status "ok" is skipped.
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from backends import make_backend  # noqa: E402
from prompt import build_messages, extract_code, load_template, to_java_class, to_package  # noqa: E402

HERE = Path(__file__).parent
ROOT = HERE.parent
RETRIES = 3


def load_json(path: Path) -> dict:
    return json.loads(path.read_text())


def select_pairs(matrix: dict, pairs_arg: str | None, priority: int | None) -> list[dict]:
    pairs = matrix["pairs"]
    if pairs_arg:
        wanted = {tuple(p.split(":")) for p in pairs_arg.split(",")}
        pairs = [p for p in pairs if (p["src"], p["tgt"]) in wanted]
        missing = wanted - {(p["src"], p["tgt"]) for p in pairs}
        if missing:
            raise SystemExit(f"pairs not in matrix.json: {sorted(missing)}")
    if priority is not None:
        pairs = [p for p in pairs if p["priority"] <= priority]
    return pairs


def find_source(problem_dir: Path, ext: str) -> Path | None:
    return next(iter(sorted(problem_dir.glob(f"*.{ext}"))), None)


def target_filename(problem_id: str, tgt: str, langs: dict) -> str:
    if tgt == "java":
        return f"{to_java_class(problem_id)}.java"
    return f"{problem_id}.{langs[tgt]['ext']}"


def prompt_fields(problem_id: str, src: str, tgt: str, source: Path, out_dir: Path, langs: dict) -> dict:
    return {
        "source_language": langs[src]["name"],
        "target_language": langs[tgt]["name"],
        "source_fence": langs[src]["fence"],
        "target_fence": langs[tgt]["fence"],
        "source_filename": source.name,
        "source_code": source.read_text(),
        "target_filename": target_filename(problem_id, tgt, langs),
        "java_package": to_package(list(out_dir.relative_to(ROOT).parts)),
        "java_class": to_java_class(problem_id),
        "prolog_entry": problem_id,
    }


def call_with_retries(backend, system: str, user: str):
    last = None
    for attempt in range(1, RETRIES + 1):
        try:
            return backend.generate(system, user), attempt, None
        except Exception as exc:  # transient HTTP / OOM errors; the last one is recorded in meta.json
            last = exc
            time.sleep(2 ** attempt)
    return None, RETRIES, f"{type(last).__name__}: {last}"


def run_one(problem_dir: Path, pair: dict, run_dir: Path, template, matrix: dict, backend, lock: dict) -> str:
    langs = matrix["languages"]
    problem_id, src, tgt = problem_dir.name, pair["src"], pair["tgt"]
    out_dir = run_dir / problem_id / f"{src}_to_{tgt}"
    meta_path = out_dir / "meta.json"
    if meta_path.exists() and load_json(meta_path).get("status") == "ok":
        return "skipped: done"

    source = find_source(problem_dir, langs[src]["ext"])
    meta = {
        "run_id": run_dir.name, "problem": problem_id, "src": src, "tgt": tgt,
        "group": pair["group"], "priority": pair["priority"],
        "backend": backend.name, "prompt_version": template.version, "prompt_sha256": template.sha256,
        "lock": {"base": lock["base"], "adapter": lock["adapter"], "decoding": lock["decoding"]},
        "timestamp": datetime.now(timezone.utc).isoformat(timespec="seconds"),
    }
    out_dir.mkdir(parents=True, exist_ok=True)
    if source is None:
        meta.update(status="skipped", reason="no_source")
        meta_path.write_text(json.dumps(meta, indent=2) + "\n")
        return "skipped: no_source"

    fields = prompt_fields(problem_id, src, tgt, source, out_dir, langs)
    system, user = build_messages(template, tgt, fields)
    started = time.time()
    reply, attempts, error = call_with_retries(backend, system, user)
    meta.update(source_file=source.name, target_file=fields["target_filename"], attempts=attempts,
                duration_s=round(time.time() - started, 1))
    if reply is None:
        meta.update(status="error", error=error)
        meta_path.write_text(json.dumps(meta, indent=2) + "\n")
        return f"error: {error}"

    code, how = extract_code(reply.text, langs[tgt]["fence"])
    (out_dir / fields["target_filename"]).write_text(code)
    tests = problem_dir / "tests.json"
    if tests.exists():
        shutil.copy(tests, out_dir / "tests.json")
    meta.update(status="ok", model=reply.model, usage=reply.usage, extraction=how, raw_response=reply.text)
    meta_path.write_text(json.dumps(meta, indent=2) + "\n")
    return f"ok ({how}, {meta['duration_s']}s)"


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--run-id", required=True, help="identifier-safe, e.g. run01 (becomes a Java package segment)")
    ap.add_argument("--problems-dir", type=Path, default=ROOT / "benchmark")
    ap.add_argument("--problem", action="append", help="problem folder name; repeatable; default = all folders with tests.json")
    ap.add_argument("--pairs", help="comma-separated src:tgt list; default = every pair in matrix.json")
    ap.add_argument("--priority", type=int, help="only pairs with priority <= N")
    ap.add_argument("--backend", choices=["dry", "http", "hf"], default="dry")
    ap.add_argument("--base-url", help="http backend: server root, e.g. http://localhost:11434")
    ap.add_argument("--model", help="http backend: model name on the server (default: base repo from model.lock.json)")
    ap.add_argument("--adapter", action="store_true", help="hf backend: load the adapter from model.lock.json")
    ap.add_argument("--load-4bit", action="store_true", help="hf backend: NF4 quantized base (needed on a 15 GB T4)")
    ap.add_argument("--template", type=Path, default=HERE / "prompts" / "v1.md")
    ap.add_argument("--results-dir", type=Path, default=ROOT / "results" / "raw")
    args = ap.parse_args(argv)

    if not re.fullmatch(r"[a-z][a-z0-9_]*", args.run_id):
        raise SystemExit("--run-id must match [a-z][a-z0-9_]* (it becomes part of the Java package name)")

    matrix = load_json(HERE / "matrix.json")
    lock = load_json(HERE / "model.lock.json")
    template = load_template(args.template)
    pairs = select_pairs(matrix, args.pairs, args.priority)
    problems = [args.problems_dir / p for p in args.problem] if args.problem else sorted(
        d for d in args.problems_dir.iterdir() if (d / "tests.json").exists())
    backend = make_backend(args.backend, lock, args.base_url, args.model, args.adapter, args.load_4bit)
    run_dir = args.results_dir / args.run_id

    print(f"{len(problems)} problems x {len(pairs)} pairs -> {run_dir}  [backend={backend.name}, prompt={template.version}]")
    failures = 0
    for problem_dir in problems:
        for pair in pairs:
            status = run_one(problem_dir, pair, run_dir, template, matrix, backend, lock)
            failures += status.startswith("error")
            print(f"  {problem_dir.name:24s} {pair['src']:>10s} -> {pair['tgt']:<10s} {status}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
