"""Generate pipeline/matrix.json: the directed language pairs the migration pipeline runs.

Usage: python pipeline/matrix.py            # writes matrix.json next to this file and prints counts
"""
import itertools
import json
from pathlib import Path

# Runtime details mirror harness/ENVIRONMENT.md and pipeline/prompts/v1.md.
LANGUAGES = {
    "python":     {"name": "Python",     "paradigm": "imperative", "family": "imperative-oo", "ext": "py",   "fence": "python"},
    "javascript": {"name": "JavaScript", "paradigm": "imperative", "family": "imperative-oo", "ext": "js",   "fence": "javascript"},
    "java":       {"name": "Java",       "paradigm": "oo",         "family": "imperative-oo", "ext": "java", "fence": "java"},
    "scheme":     {"name": "Scheme",     "paradigm": "functional", "family": "functional",    "ext": "scm",  "fence": "scheme"},
    "haskell":    {"name": "Haskell",    "paradigm": "functional", "family": "functional",    "ext": "hs",   "fence": "haskell"},
    "prolog":     {"name": "Prolog",     "paradigm": "logic",      "family": "logic",         "ext": "pl",   "fence": "prolog"},
}

# Priority 1 = must run for RQ1-RQ3: every intra pair, every pair touching Prolog, and the
# imperative-oo <-> Haskell contrasts the proposal names. Priority 2 = the remaining inter pairs.
PRIORITY_1_INTER = {
    ("python", "haskell"), ("haskell", "python"),
    ("java", "haskell"), ("haskell", "java"),
}


def build() -> dict:
    pairs = []
    for src, tgt in itertools.permutations(LANGUAGES, 2):
        intra = LANGUAGES[src]["family"] == LANGUAGES[tgt]["family"]
        touches_prolog = "prolog" in (src, tgt)
        priority = 1 if intra or touches_prolog or (src, tgt) in PRIORITY_1_INTER else 2
        pairs.append({"src": src, "tgt": tgt, "group": "intra" if intra else "inter", "priority": priority})
    return {"version": 1, "languages": LANGUAGES, "pairs": pairs}


def main() -> None:
    matrix = build()
    out = Path(__file__).with_name("matrix.json")
    out.write_text(json.dumps(matrix, indent=2) + "\n")
    pairs = matrix["pairs"]
    intra = [p for p in pairs if p["group"] == "intra"]
    p1 = [p for p in pairs if p["priority"] == 1]
    print(f"wrote {out}: {len(pairs)} pairs ({len(intra)} intra, {len(pairs) - len(intra)} inter); priority 1: {len(p1)}")
    for n in (15, 20):
        print(f"  {n} problems -> {n * len(p1)} priority-1 translations, {n * len(pairs)} for the full matrix")


if __name__ == "__main__":
    main()
