#!/bin/bash
# Helper script for run_harness. Runs one test case against one language service.

EXECUTE="true"
TEST_CATEGORY="NONE"
TEST_NAME="Test"
INPUT_FILE="/dev/null"
EXPECTED_FILE="/dev/null"
SERVICE_NAME="tests"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            echo "Usage: $0 [-k|--skip] [-n|--name test_name] [-c|--category test_category]"
            echo "[-i|--input input_file] [-o|--output expected_output_file]"
            echo "[-s|--service service_name]"
            exit 0
            ;;
        -k|--skip)
            EXECUTE="false"
            shift 1
            ;;
        -c|--category)
            TEST_CATEGORY="$2"
            shift 2
            ;;
        -n|--name)
            TEST_NAME="$2"
            shift 2
            ;;
        -i|--input)
            INPUT_FILE="$2"
            shift 2
            ;;
        -o|--output)
            EXPECTED_FILE="$2"
            shift 2
            ;;
        -s|--service)
            SERVICE_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# Temp files for this one run; destroyed on exit, even on crash
OUTPUT_PATH="$(mktemp)"
DIFF_PATH="$(mktemp)"
ERR_PATH="$(mktemp)"

cleanup() {
    rm -f "${OUTPUT_PATH}" "${DIFF_PATH}" "${ERR_PATH}"
}

trap cleanup EXIT

if [ "${EXECUTE}" = "true" ]; then
    docker compose run --rm -T "${SERVICE_NAME}" < "${INPUT_FILE}" > "${OUTPUT_PATH}" 2> "${ERR_PATH}"

    EXIT_CODE=$?

    if [ $EXIT_CODE != 0 ]; then
        echo "[${TEST_NAME}] CRASHED"
        cat "${ERR_PATH}"
        exit 0
    fi

    if diff -w -u "${EXPECTED_FILE}" "${OUTPUT_PATH}" > "${DIFF_PATH}"; then
        echo "[${TEST_NAME}] PASSED"
    else
        echo "[${TEST_NAME}] FAILED"
        cat "${DIFF_PATH}"
    fi
else
    echo "[${TEST_NAME}] SKIPPED"
fi
