#!/bin/bash
FOLDER_PATH="smoke"

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
            echo "Usage: $0 [-f|--folder test_folder_path] [-r|--report report_file]"
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

# Delete any compiled Java files and the directories that contained them, if needed
java_cleanup() {
    find . -type f -name "*.class" -delete
    find . -type d -empty -delete
}

trap java_cleanup EXIT

get_now() {
    echo $(date "+%F %T")
}

get_file_path() {
    local WILDCARD="$1"
    local FILE_NAME=$(basename $(find ${TEST_DIR} -maxdepth 1 -name "${WILDCARD}" -print -quit))

    echo "${FOLDER_PATH}/${FILE_NAME}"
}

TEST_DIR="${PROJECT_ROOT}/${FOLDER_PATH}/${TEST_NAME}"
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

JAVA_FILE_NAME="${JAVA_FILE%.java}"
export JAVA_FILE_NAME="${JAVA_FILE_NAME/./}"
STRIPPED_PROLOG=${PROLOG_FILE##*/}
export STRIPPED_PROLOG=${STRIPPED_PROLOG%.pl}

CATEGORIES=("PYTHON" "JAVASCRIPT" "JAVA" "SCHEME" "HASKELL" "PROLOG")
SERVICES=("python-tests" "javascript-tests" "java-tests" "scheme-tests" "haskell-tests" "prolog-tests")
RUN_FLAGS=("${RUN_PYTHON}" "${RUN_JAVASCRIPT}" "${RUN_JAVA}" "${RUN_SCHEME}" "${RUN_HASKELL}" "${RUN_PROLOG}")

TOTAL_TESTS=0
TOTAL_SUCCESSFUL_TESTS=0
TOTAL_FAILED_TESTS=0
TOTAL_CRASHED_TESTS=0
TOTAL_SKIPPED_TESTS=0

for i in "${!CATEGORIES[@]}"; do
    NAME=""
    INPUT=""
    OUTPUT=""
    INDEX=0

    ((TESTS=0))
    ((SUCCESSFUL_TESTS=0))
    ((FAILED_TESTS=0))
    ((SKIPPED_TESTS=0))
    ((CRASHED_TESTS=0))

    echo "--------------------------------------------------" | tee -a "${REPORT_FILE}"
    NOW=$(get_now)
    echo "${NOW}" | tee -a "${REPORT_FILE}"
    echo "${CATEGORIES[i]}" | tee -a "${REPORT_FILE}"

    while IFS= read -r item; do
        if [ ${INDEX} -eq 0 ]; then
            NAME="${item}"
            ((INDEX++))
            continue
        fi

        if [ ${INDEX} -eq 1 ]; then
            INPUT="${item}"
            ((INDEX++))
            continue
        fi

        OUTPUT="${item}"

        NAME="${NAME//$'\r'/}"
        INPUT="${INPUT//$'\r'/}"
        OUTPUT="${OUTPUT//$'\r'/}"
        
        EXECUTE=""
        if [ "${RUN_FLAGS[i]}" = "false" ]; then
            EXECUTE="-k"
        fi

        RESULT=$(echo "${INPUT}" | ./run_test.sh ${EXECUTE} -c "${category}" -n "${NAME}" -o "${OUTPUT}\n" -s "${SERVICES[i]}")
        echo "${RESULT}" | tee -a "${REPORT_FILE}"

        if [[ "${RESULT}" == *"PASSED"* ]]; then
            ((SUCCESSFUL_TESTS++))
        elif [[ "${RESULT}" == *"SKIPPED"* ]]; then
            ((SKIPPED_TESTS++))
        elif [[ "${RESULT}" == *"FAILED"* ]]; then
            ((FAILED_TESTS++))
        else
            ((CRASHED_TESTS++))
        fi

        ((TESTS++))

        NAME=""
        INPUT=""
        OUTPUT=""
        INDEX=0
    done < <(cat "${TEST_DIR}/tests.json" | python3 -c"
import sys, json
data = json.load(sys.stdin)
[print(item['name'] + '\n' + item['input'] + '\n' + item['output']) for item in data]")

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
