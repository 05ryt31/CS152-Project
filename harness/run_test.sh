#!/bin/bash
# Helper script for run_harness.

EXECUTE="true"
TEST_CATEGORY="NONE"
TEST_NAME="Test"
EXPECTED_OUTPUT=""
SERVICE_NAME="tests"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            echo "Usage: $0 [-k|--skip] [-n|--name test_name] [-c|--category test_category]"
            echo "[-i|--input input] [-o|--output expected_output]"
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
        -o|--output)
            EXPECTED_OUTPUT="$2"
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

# Make sure temp files will be destroyed, even on crash
cleanup() {
    rm -f ./output_*.txt
    rm -f ./diff_*.txt
    rm -f ./err_*.txt
}

trap cleanup EXIT

OUTPUT_PATH="./output_${TEST_CATEGORY}_${TEST_NAME}.txt"
DIFF_PATH="./diff_${TEST_CATEGORY}_${TEST_NAME}.txt"
ERR_PATH="./err_${TEST_CATEGORY}_${TEST_NAME}.txt"

if [ "${EXECUTE}" = "true" ]; then
    docker compose run --rm -T "${SERVICE_NAME}" > "${OUTPUT_PATH}" 2> "${ERR_PATH}"

    EXIT_CODE=$?

    if [ $EXIT_CODE != 0 ]; then
        echo "[${TEST_NAME}] CRASHED"
        cat "${ERR_PATH}"
        exit 0
    fi

    if diff -w -u <(printf "%b" "${EXPECTED_OUTPUT}") "${OUTPUT_PATH}" > "${DIFF_PATH}"; then
        echo "[${TEST_NAME}] PASSED"
    else
        echo "[${TEST_NAME}] FAILED"
        cat "${DIFF_PATH}"
    fi
else
    echo "[${TEST_NAME}] SKIPPED"
fi
