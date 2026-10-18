#!/bin/bash
FOLDER_PATH=""

RUN_PYTHON="true"
RUN_JAVASCRIPT="true"
RUN_JAVA="true"
RUN_SCHEME="true"
RUN_HASKELL="true"
RUN_PROLOG="true"

REPORT_FILE="report.txt"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
export PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            echo "Usage: $0 -f|--folder test_folder_path [-r|--report report_file]"
            echo "[-p|--skip-python] [-a|--skip-js] [-v|--skip-java] [-s|--skip-scheme] [-k|--skip-haskell] [-l|--skip-prolog]"
            exit 0
            ;;
        -f|--folder)
            FOLDER_PATH="$2"
            shift 2
            ;;
        -r|--report)
            REPORT_FILE="$2"
            shift 2
            ;;
        -p|--skip-python)
            RUN_PYTHON="false"
            shift 1
            ;;
        -a|--skip-js)
            RUN_JAVASCRIPT="false"
            shift 1
            ;;
        -v|--skip-java)
            RUN_JAVA="false"
            shift 1
            ;;
        -s|--skip-scheme)
            RUN_SCHEME="false"
            shift 1
            ;;
        -k|--skip-haskell)
            RUN_HASKELL="false"
            shift 1
            ;;
        -l|--skip-prolog)
            RUN_PROLOG="false"
            shift 1
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

if [ -z "${FOLDER_PATH}" ]; then
    echo "-f <test_folder_path> is required (relative to the project root)"
    exit 1
fi

# Per-test input and expected-output files live here for the duration of the run
CASES_DIR="$(mktemp -d)"

# Delete any compiled Java files and the directories that contained them, if needed
cleanup() {
    find . -type f -name "*.class" -delete
    find . -type d -empty -delete
    rm -rf "${CASES_DIR}"
}

trap cleanup EXIT

get_now() {
    echo $(date "+%F %T")
}

# Prints the project-root-relative path of the first file matching the wildcard, or nothing if there is none
get_file_path() {
    local MATCH
    MATCH=$(find "${TEST_DIR}" -maxdepth 1 -name "$1" -print -quit)
    [ -n "${MATCH}" ] && echo "${FOLDER_PATH}/$(basename "${MATCH}")"
}

TEST_DIR="${PROJECT_ROOT}/${FOLDER_PATH}"
export TEST_DIR="$(realpath "$TEST_DIR")"

NOW=$(get_now)
echo "Test Run: ${NOW}" | tee "${REPORT_FILE}"
echo "Test Folder: ${FOLDER_PATH}" | tee -a "${REPORT_FILE}"

export PYTHON_FILE=$(get_file_path "*.py")
export PYTHON_REQUIREMENTS=$(get_file_path "*_requirements.txt")
export JAVASCRIPT_FILE=$(get_file_path "*.js")
export JAVA_FILE=$(get_file_path "*.java")
export SCHEME_FILE=$(get_file_path "*.scm")
export HASKELL_FILE=$(get_file_path "*.hs")
export PROLOG_FILE=$(get_file_path "*.pl")

# Java: the class name is the folder path with slashes; the file's package must match the folder path
export JAVA_FILE_NAME="${JAVA_FILE%.java}"
# Prolog: the entry predicate is the file name without .pl
STRIPPED_PROLOG=${PROLOG_FILE##*/}
export STRIPPED_PROLOG=${STRIPPED_PROLOG%.pl}

CATEGORIES=("PYTHON" "JAVASCRIPT" "JAVA" "SCHEME" "HASKELL" "PROLOG")
SERVICES=("python-tests" "javascript-tests" "java-tests" "scheme-tests" "haskell-tests" "prolog-tests")
RUN_FLAGS=("${RUN_PYTHON}" "${RUN_JAVASCRIPT}" "${RUN_JAVA}" "${RUN_SCHEME}" "${RUN_HASKELL}" "${RUN_PROLOG}")
FILES=("${PYTHON_FILE}" "${JAVASCRIPT_FILE}" "${JAVA_FILE}" "${SCHEME_FILE}" "${HASKELL_FILE}" "${PROLOG_FILE}")

# Write one input file and one expected-output file per test case, then list "<index><TAB><name>".
# Input gets a trailing newline unless it is empty; expected output likewise, so a program that
# prints nothing matches "output": "" and a program that prints "x\n" matches "output": "x".
python3 - "${CASES_DIR}" "${TEST_DIR}/tests.json" <<'PY' > "${CASES_DIR}/index.tsv"
import json, sys
d = sys.argv[1]
with open(sys.argv[2]) as f:
    tests = json.load(f)
for i, t in enumerate(tests):
    for key, ext in (("input", "in"), ("output", "out")):
        value = t[key].replace("\r", "")
        with open(f"{d}/{i}.{ext}", "w") as f:
            f.write(value + "\n" if value else "")
    print(f"{i}\t{t['name']}")
PY

TOTAL_TESTS=0
TOTAL_SUCCESSFUL_TESTS=0
TOTAL_FAILED_TESTS=0
TOTAL_CRASHED_TESTS=0
TOTAL_SKIPPED_TESTS=0

for i in "${!CATEGORIES[@]}"; do
    ((TESTS=0))
    ((SUCCESSFUL_TESTS=0))
    ((FAILED_TESTS=0))
    ((SKIPPED_TESTS=0))
    ((CRASHED_TESTS=0))

    echo "--------------------------------------------------" | tee -a "${REPORT_FILE}"
    NOW=$(get_now)
    echo "${NOW}" | tee -a "${REPORT_FILE}"
    echo "${CATEGORIES[i]}" | tee -a "${REPORT_FILE}"

    # Skipped explicitly, or no program in this language in the folder
    EXECUTE=""
    if [ "${RUN_FLAGS[i]}" = "false" ] || [ -z "${FILES[i]}" ]; then
        EXECUTE="-k"
    fi

    while IFS=$'\t' read -r INDEX NAME; do
        NAME="${NAME%$'\r'}"
        RESULT=$(./run_test.sh ${EXECUTE} -c "${CATEGORIES[i]}" -n "${NAME}" -i "${CASES_DIR}/${INDEX}.in" -o "${CASES_DIR}/${INDEX}.out" -s "${SERVICES[i]}")
        echo "${RESULT}" | tee -a "${REPORT_FILE}"

        # Classify on the status line only; the rest of RESULT is the diff or stderr
        case "${RESULT%%$'\n'*}" in
            *"] PASSED")  ((SUCCESSFUL_TESTS++)) ;;
            *"] SKIPPED") ((SKIPPED_TESTS++)) ;;
            *"] FAILED")  ((FAILED_TESTS++)) ;;
            *)            ((CRASHED_TESTS++)) ;;
        esac

        ((TESTS++))
    done < "${CASES_DIR}/index.tsv"

    echo ""
    echo "Tests: ${TESTS}" | tee -a "${REPORT_FILE}"
    echo "Passed: ${SUCCESSFUL_TESTS}/${TESTS}" | tee -a "${REPORT_FILE}"
    echo "Failed: ${FAILED_TESTS}/${TESTS}" | tee -a "${REPORT_FILE}"
    echo "Crashed: ${CRASHED_TESTS}/${TESTS}" | tee -a "${REPORT_FILE}"
    echo "Skipped: ${SKIPPED_TESTS}/${TESTS}" | tee -a "${REPORT_FILE}"

    ((TOTAL_TESTS+=${TESTS}))
    ((TOTAL_SUCCESSFUL_TESTS+=${SUCCESSFUL_TESTS}))
    ((TOTAL_FAILED_TESTS+=${FAILED_TESTS}))
    ((TOTAL_SKIPPED_TESTS+=${SKIPPED_TESTS}))
    ((TOTAL_CRASHED_TESTS+=${CRASHED_TESTS}))
done

echo "--------------------------------------------------" | tee -a "${REPORT_FILE}"
NOW=$(get_now)
echo "Summary: ${NOW}" | tee -a "${REPORT_FILE}"
echo "" | tee -a "${REPORT_FILE}"
echo "Total Tests: ${TOTAL_TESTS}" | tee -a "${REPORT_FILE}"
echo "Passed: ${TOTAL_SUCCESSFUL_TESTS}/${TOTAL_TESTS}" | tee -a "${REPORT_FILE}"
echo "Failed: ${TOTAL_FAILED_TESTS}/${TOTAL_TESTS}" | tee -a "${REPORT_FILE}"
echo "Crashed: ${TOTAL_CRASHED_TESTS}/${TOTAL_TESTS}" | tee -a "${REPORT_FILE}"
echo "Skipped: ${TOTAL_SKIPPED_TESTS}/${TOTAL_TESTS}" | tee -a "${REPORT_FILE}"
