#!/bin/bash
export FOLDER_NAME="smoke"
JAVA_PACKAGE="harness"

RUN_PYTHON="true"
RUN_JAVASCRIPT="true"
RUN_JAVA="true"
RUN_SCHEME="true"
RUN_HASKELL="true"
RUN_PROLOG="true"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            echo "Usage: $0 [-f|--folder test_folder_path] [-j|--java-package harness]"
            echo "[-p|--skip-python] [-a|--skip-js] [-v|--skip-java] [-s|--skip-scheme] [-k|--skip-haskell] [-l|--skip-prolog]"
            exit 0
            ;; 
        -f|--folder)
            export FOLDER_NAME="$2"
            shift 2
            ;;
        -j|--java-package)
            JAVA_PACKAGE="$2"
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

echo "Running test..."

export PYTHON_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.py" -print -quit)
export JAVASCRIPT_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.js" -print -quit)
export JAVA_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.java" -print -quit)
export SCHEME_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.scm" -print -quit)
export HASKELL_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.hs" -print -quit)
export PROLOG_FILE=$(find ${FOLDER_NAME} -maxdepth 1 -name "*.pl" -print -quit)

export JAVA_FILE_NAME="${JAVA_PACKAGE}.${JAVA_FILE%.java}"
STRIPPED_PROLOG=${PROLOG_FILE##*/}
export STRIPPED_PROLOG=${STRIPPED_PROLOG%.pl}

INPUT_FILE="${FOLDER_NAME}/input.txt"
OUTPUT_FILE="${FOLDER_NAME}/expected.txt"

# Make sure temp files will be destroyed, even on crash
trap 'rm -f ./output_*.txt' EXIT

rm -f diff_*.txt

if [ "${RUN_PYTHON}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T python-tests > ./output_python.txt

    if diff -w ./output_python.txt "${OUTPUT_FILE}" > ./diff_python.txt; then
        rm -f ./diff_python.txt
        echo "[PYTHON] Test passed."
    else
        echo "[PYTHON] Test failed."
    fi
else
    echo "[PYTHON] Test skipped."
fi

if [ "${RUN_JAVASCRIPT}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T javascript-tests > ./output_javascript.txt

    if diff -w ./output_javascript.txt "${OUTPUT_FILE}" > ./diff_javascript.txt; then
        rm -f ./diff_javascript.txt
        echo "[JAVASCRIPT] Test passed."
    else
        echo "[JAVASCRIPT] Test failed."
    fi
else
    echo "[JAVASCRIPT] Test skipped."
fi

if [ "${RUN_JAVA}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T java-tests > ./output_java.txt

    if diff -w ./output_java.txt "${OUTPUT_FILE}" > ./diff_java.txt; then
        rm -f ./diff_java.txt
        echo "[JAVA] Test passed."
    else
        echo "[JAVA] Test failed."
    fi
else
    echo "[JAVA] Test skipped."
fi

if [ "${RUN_SCHEME}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T scheme-tests > ./output_scheme.txt

    if diff -w ./output_scheme.txt "${OUTPUT_FILE}" > ./diff_scheme.txt; then
        rm -f ./diff_scheme.txt
        echo "[SCHEME] Test passed."
    else
        echo "[SCHEME] Test failed."
    fi
else
    echo "[SCHEME] Test skipped."
fi

if [ "${RUN_HASKELL}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T haskell-tests > ./output_haskell.txt

    if diff -w ./output_haskell.txt "${OUTPUT_FILE}" > ./diff_haskell.txt; then
        rm -f ./diff_haskell.txt
        echo "[HASKELL] Test passed."
    else
        echo "[HASKELL] Test failed."
    fi
else
    echo "[HASKELL] Test skipped."
fi

if [ "${RUN_PROLOG}" = "true" ]; then
    cat "${INPUT_FILE}" | docker compose run --rm -T prolog-tests > ./output_prolog.txt

    if diff -w ./output_prolog.txt "${OUTPUT_FILE}" > ./diff_prolog.txt; then
        rm -f ./diff_prolog.txt
        echo "[PROLOG] Test passed."
    else
        echo "[PROLOG] Test failed."
    fi
else
    echo "[PROLOG] Test skipped."
fi

rm -f ./output_python.txt ./output_javascript.txt ./output_java.txt ./output_scheme.txt ./output_haskell.txt ./output_prolog.txt
rm -r ./harness
