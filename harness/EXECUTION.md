## Harness Execution
With `harness/` as the CWD, run:

```bash
./run_harness.sh -f <test_folder_path>
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

The name of the default root Java package is `harness`. For Java scripts outside of the `harness` folder, it may be necessary to change this by passing the explicit name:

```bash
./run_harness.sh -f <test_folder_path> -j <java_package_name>
```
