"""Runs the advisor on all passed folders with a SPEC.md, and collects the results in a JSON.

Uses the prompts in `prompts/v1.md`.

Usage (from repo root):
    python -m advisor.advisor --run-id base01

Output: <run_id>/advising.json
"""

import sys
import argparse
import json
import time
from datetime import datetime, timezone
from pathlib import Path

from pipeline.backends import make_backend
from pipeline.migrate import load_json
from pipeline.prompt import load_ruleless_template, fill, extract_code

ROOT = Path(__file__).parent.parent
RETRIES = 3


def call_with_retries(backend, system: str, user: str):
    last = None
    for attempt in range(1, RETRIES + 1):
        try:
            return backend.generate(system, user), attempt, None
        except Exception as exc:  # transient HTTP / OOM errors; the last one is recorded in meta.json
            last = exc
            time.sleep(2 ** attempt)
    return None, RETRIES, f"{type(last).__name__}: {last}"


def run_one(problem_dir: Path, run_dir: Path, template, backend, lock: dict) -> str:
    problem_id = problem_dir.name
    out_dir = run_dir / problem_id
    meta_path = out_dir / "meta.json"
    if meta_path.exists() and load_json(meta_path).get("status") == "ok":
        return "skipped: done"

    meta = {
        "run_id": run_dir.name, "problem": problem_id,
        "backend": backend.name, "prompt_version": template.version, "prompt_sha256": template.sha256,
        "lock": {"base": lock["base"], "adapter": lock["adapter"], "decoding": lock["decoding"]},
        "timestamp": datetime.now(timezone.utc).isoformat(timespec="seconds"),
    }
    out_dir.mkdir(parents=True, exist_ok=True)

    fields = {"problem_description": (problem_dir / "SPEC.md").read_text()}
    system = template.system
    user = fill(template.user, fields)
    started = time.time()
    reply, attempts, error = call_with_retries(backend, system, user)
    meta.update(attempts=attempts, duration_s=round(time.time() - started, 1))
    if reply is None:
        meta.update(status="error", error=error)
        meta_path.write_text(json.dumps(meta, indent=2) + "\n")
        return f"error: {error}"

    response, how = extract_code(reply.text, "json")
    (out_dir / "response.json").write_text(response)
    meta.update(status="ok", model=reply.model, usage=reply.usage, raw_response=reply.text)
    meta_path.write_text(json.dumps(meta, indent=2) + "\n")
    return f"ok ({how}, {meta['duration_s']}s)"


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--problems-dir", type=Path, default=ROOT / "benchmark")
    ap.add_argument("--problem", action="append", help="specific problem folder name; repeatable; default = all folders in problems-dir with SPEC.md")
    ap.add_argument("--adapter", action="store_true", help="hf backend: load the adapter from model.lock.json")
    ap.add_argument("--backend", choices=["dry", "http", "hf"], default="dry")
    ap.add_argument("--base-url", help="http backend: server root, e.g. http://localhost:11434")
    ap.add_argument("--model", help="http backend: model name on the server (default: base repo from model.lock.json)")
    ap.add_argument("--load-4bit", action="store_true", help="hf backend: NF4 quantized base (needed on a 15 GB T4)")
    ap.add_argument("--template", type=Path, default=ROOT / "advisor" / "prompts" / "v1.md")
    ap.add_argument("--run-id", required=True, help="identifier-safe, e.g. run01 (becomes a Java package segment)")
    ap.add_argument("--results-dir", type=Path, default=ROOT / "results" / "advisor")
    args = ap.parse_args(argv)

    lock = load_json(ROOT / "pipeline" / "model.lock.json")
    template = load_ruleless_template(args.template)
    problems = [args.problems_dir / p for p in args.problem] if args.problem else sorted(
        d for d in args.problems_dir.iterdir() if (d / "SPEC.md").exists())
    backend = make_backend(args.backend, lock, args.base_url, args.model, args.adapter, args.load_4bit)
    run_dir = args.results_dir / args.run_id

    print(f"{len(problems)} problems -> {run_dir}  [backend={backend.name}, prompt={template.version}]")
    failures = 0
    for problem_dir in problems:
        status = run_one(problem_dir, run_dir, template, backend, lock)
        failures += status.startswith("error")
        print(f"  {problem_dir.name:24s} {status}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
