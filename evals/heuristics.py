"""Analyzes code for obvious idiomatic violations and writes the results to a JSON.

To run (from repo root):
    python evals/heuristics.py --run-id base01
    
Fields: run_id, problem, src, tgt, violation_counts (with specific fields for different
languages).
"""

import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

TARGETS = {
    "python": {
        "index_loops": re.compile(r"for\s+\w+\s+in\s+range\(\s*len\("),
        "higher_order_functions": r"\b(map|filter|reduce|zip|any|all|partial|compose)\s*\(",
        "lambdas": r"\blambda\b\s*[^:]+:",
        "explicit_boolean_comparison": r"(?:==|!=)\s*(?:True|False)\b",
        "explicit_keys": r"\bin\s+\w+\.keys\(\)",
    },
    "java": {
        "add_all_initialization": r"new\s+(ArrayList|HashSet|LinkedList)<[^>]*>\(\);\s*[a-zA-Z0-9_]+\.addAll\(",
        "stream_pipeline": r"\.(?:parallelS|s)tream\(\)\s*\.(?:map|filter|flatMap|reduce|collect|forEach|anyMatch|allMatch|noneMatch|findFirst|findAny|sorted|distinct|limit|skip)\b",
        "lambdas": r"(?:\b[a-zA-Z_$][\w$]*+|\((?:[^()]++|\([^()]*+\))*+\))\s*+->",
        "explicit_boolean_comparison": r"\b(==|!=)\s*(true|false)\b|\b(true|false)\s*(==|!=)\b",
        "double_colon_references": r"\b(?:[a-zA-Z_$][\w$]*|this|super)\s*::\s*(?:[a-zA-Z_$][\w$]*|new)\b"
    },
    "javascript": {
        "not_strict_equality": r"[^=!]==[^=]|!=[^=]",
        "higher_order_functions": r"\b(map|filter|reduce|reduceRight|flatMap|some|every|find|findIndex)\s*\(",
        "lambdas": r"=>\s*[^{;\n]+",
        "explicit_boolean_comparison": r"(?:===|!==)\s*(?:true|false)\b",
        "var": r"\bvar\s+[a-zA-Z_$]"
    },
    "haskell": {
        "mutable_ioref": r"\b(IORef|Data.IORef|unsafePerformIO)\b",
        "list_concatenation": r"\[[^,\]]+\]\s*\+\+",
        "unsafe_list_access": r"\b(head|tail|init|last)\b|!!",
        "nested_else_if": r"\belse\s+if\b",
        "imperative_indexing_loop": r"map\s*\(\s*\\\s*[a-zA-Z0-9_]+\s*->.*!!"
    },
    "scheme": {
        "mutable_set": r"\b(set!|set-car!|set-cdr!|vector-set!|string-set!)\b",
        "nested_else_if": r"\(\s*if\b[\s\S]*?\(\s*if\b",
        "do_loops": r"\(\s*do\s*\(",
        "unnecessary_begin": r"\((lambda|let\*?|letrec|cond|define)\b[\s\S]*?\(\s*begin\b",
        "car_cdr_chains": r"\bc[ad]{3,}r\b"
    },
    "prolog": {
        "trailing_cut": r"!\s*\.\s*$",
        "head_cut": r":-\s*!,",
        "nested_if_else": r"->.*->",
        "dynamic_mutability": r"\b(asserta|assertz|retract|retractall)\b",
        "append_to_prepend": r"append\(\s*\[[^\],]+\]\s*,"
    }
}

def scan_code(file_path: Path, language: str) -> dict:
    if not file_path.exists():
        return { "no_file" }

    with open(file_path, "r", encoding="utf-8") as file:
        code = file.read()

    result = {}
    for item in TARGETS[language]:
        matches = re.findall(TARGETS[language][item], code)
        result[item] = len(matches)

    return result

def collect(run_dir: Path) -> dict:
    data = {}
    for meta_path in sorted(run_dir.glob("*/*/meta.json")):
        meta = json.loads(meta_path.read_text())
        
        data.setdefault(meta["problem"], [])
        item = {
            "src": meta["src"],
            "tgt": meta["tgt"]
        }
        
        if meta.get("status") == "ok":
            item["counts"] = scan_code(meta_path.resolve().parent / meta["target_file"], meta["tgt"])

        data[meta["problem"]].append(item)

    return data

def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--results-dir", type=Path, default=ROOT / "results" / "raw",
                    help="must be inside the repo (default results/raw)")
    ap.add_argument("--out", type=Path, help="JSON path (default results/<run_id>_analysis/<run_id>_heuristics.json)")
    args = ap.parse_args(argv)

    run_dir = args.results_dir / args.run_id
    if not run_dir.is_dir():
        raise SystemExit(f"no such run: {run_dir}")
    
    data = collect(run_dir)
    out = args.out or ROOT / "results" / f"{args.run_id}_analysis" / f"{args.run_id}_heuristics.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)
    
    print(f"\nwrote {out} ({len(data)} items)")
    return 0


if __name__ == "__main__":
    sys.exit(main())

