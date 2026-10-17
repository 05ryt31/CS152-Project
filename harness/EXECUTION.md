## Harness Execution
With `harness/` as the CWD, run:

```bash
./run_harness.sh -f <test_folder_path>
```

`<test_folder_path>` must be relative to the project root. For example:

```bash
./run_harness.sh -f harness/tests/smoke_io
```

The harness will execute against the programs inside `<test_folder_path>`, using the inputs and expected outputs in a `tests.json` file within the folder. The results will be stored in a `report.txt` file.

To change the name of the report file:

```bash
./run_harness.sh -f <test_folder_path> -r <report_file_name>
```

To skip one or more tests, pass `-p` to skip Python, `-a` to skip JavaScript, `-v` to skip Java, `-s` to skip Scheme, `-k` to skip Haskell, and/or `-l` to skip Prolog. For example, the following will skip Python and Scheme tests:

```bash
./run_harness.sh -f <test_folder_path> -p -s
```

Languages with no program in the folder are reported as SKIPPED automatically, so a folder that holds a single
`.hs` file runs only the Haskell tests.

## Test folder conventions

- `tests.json` is a JSON array of `{ "name", "input", "output" }`. `input` is fed to stdin and `output` is compared
  with stdout. Both may contain newlines. A trailing newline is appended to each unless it is empty, so a program
  that prints `x\n` matches `"output": "x"` and a program that prints nothing matches `"output": ""`.
- The comparison is `diff -w`, which ignores whitespace differences within a line.
- One source file per language: `*.py`, `*.js` (ES modules are fine), `*.java`, `*.scm` (CHICKEN 5), `*.hs`, `*.pl`.
- Java: the file's `package` declaration must equal the test folder path relative to the project root with `/`
  replaced by `.`, and the public class must be named after the file (e.g. `harness/tests/smoke_io/SmokeIO.java`
  declares `package harness.tests.smoke_io;`). Folder names must therefore be valid Java identifiers.
- Prolog: the entry predicate has arity 0 and is named after the file (`smoke_io.pl` defines `smoke_io/0`); the
  runner calls `swipl -s <file> -g <name> -t halt`.
- Python: a `*_requirements.txt` in the folder is pip-installed before the run; it is optional.
