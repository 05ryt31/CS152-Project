"""Self-check for the prompt/extraction logic and a dry end-to-end run. Run: python pipeline/test_pipeline.py (or pytest)."""
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import migrate  # noqa: E402
from prompt import build_messages, extract_code, fill, load_template, to_java_class, to_package  # noqa: E402

HERE = Path(__file__).parent


def test_template_loads_all_six_rule_blocks():
    t = load_template(HERE / "prompts" / "v1.md")
    assert set(t.rules) == {"python", "javascript", "java", "scheme", "haskell", "prolog"}
    assert "{{target_language}}" in t.system and "{{source_code}}" in t.user
    assert len(t.sha256) == 64


def test_fill_rejects_leftover_placeholders():
    assert fill("a {{x}} b", {"x": "1"}) == "a 1 b"
    try:
        fill("a {{x}} {{y}}", {"x": "1"})
        assert False, "expected KeyError"
    except KeyError:
        pass


def test_build_messages_fills_everything_for_prolog():
    t = load_template(HERE / "prompts" / "v1.md")
    fields = {
        "source_language": "Python", "target_language": "Prolog", "source_fence": "python", "target_fence": "prolog",
        "source_filename": "p01.py", "source_code": "print(1)\n", "target_filename": "p01.pl",
        "java_package": "x", "java_class": "P01", "prolog_entry": "p01",
    }
    system, user = build_messages(t, "prolog", fields)
    assert "{{" not in system and "{{" not in user
    assert "swipl -s p01.pl -g p01 -t halt" in user and "print(1)" in user


def test_extract_code_rule_order():
    assert extract_code("x\n```haskell\nmain = pure ()\n```\n", "haskell") == ("main = pure ()\n", "tagged_fence")
    assert extract_code("```hs\nmain = 1\n```", "haskell")[1] == "tagged_fence"  # alias
    assert extract_code("```\nfoo\n```\n```haskell\nbar\n```", "haskell") == ("bar\n", "tagged_fence")  # later tagged wins
    assert extract_code("```python\nfoo\n```", "haskell") == ("foo\n", "untagged_fence")
    assert extract_code("no fences here", "haskell") == ("no fences here\n", "no_fence")


def test_java_naming():
    assert to_java_class("p07_expr_eval") == "P07ExprEval"
    assert to_package(["results", "raw", "run01", "p07_expr_eval", "python_to_java"]) == "results.raw.run01.p07_expr_eval.python_to_java"
    try:
        to_package(["results", "1bad"])
        assert False
    except ValueError:
        pass


def test_dry_end_to_end_writes_outputs_and_is_resumable():
    with tempfile.TemporaryDirectory(dir=migrate.ROOT) as tmp:  # under ROOT so the Java package derives
        tmp = Path(tmp)
        prob = tmp / "problems" / "p01_echo"
        prob.mkdir(parents=True)
        (prob / "p01_echo.py").write_text("print(input())\n")
        (prob / "tests.json").write_text('[{"name": "t", "input": "a", "output": "a"}]')
        results = tmp / "results"
        argv = ["--run-id", "t1", "--problems-dir", str(tmp / "problems"), "--pairs", "python:haskell,python:java,prolog:python",
                "--backend", "dry", "--results-dir", str(results)]
        assert migrate.main(argv) == 0
        hs = results / "t1" / "p01_echo" / "python_to_haskell"
        assert (hs / "p01_echo.hs").exists() and (hs / "tests.json").exists()
        meta = json.loads((hs / "meta.json").read_text())
        assert meta["status"] == "ok" and meta["extraction"] == "untagged_fence" and meta["prompt_version"] == "v1"
        assert (results / "t1" / "p01_echo" / "python_to_java" / "P01Echo.java").exists()
        no_src = json.loads((results / "t1" / "p01_echo" / "prolog_to_python" / "meta.json").read_text())
        assert no_src["status"] == "skipped" and no_src["reason"] == "no_source"
        assert migrate.main(argv) == 0  # second run skips completed outputs without error


if __name__ == "__main__":
    for name, fn in list(globals().items()):
        if name.startswith("test_"):
            fn()
            print("ok", name)
