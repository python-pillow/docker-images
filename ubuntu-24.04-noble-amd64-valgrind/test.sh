#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
make install-coverage

SPLIT_ARGS=""
if [ "${SPLIT_COUNT:-1}" -gt 1 ]; then
    SPLIT_ARGS="--splits ${SPLIT_COUNT} --group ${SPLIT_INDEX} --durations-path /depends/.test_durations"
fi

PYTHONMALLOC=malloc valgrind --suppressions=/depends/python.supp --leak-check=no \
            --log-file=/tmp/valgrind-output \
            python3 -m pytest --no-memcheck -vv --valgrind --valgrind-log=/tmp/valgrind-output $SPLIT_ARGS

# To run one test in the image:
# make bash
# PYTHONMALLOC=malloc valgrind --leak-check=no --suppressions=/depends/python.supp pytest -vv --valgrind --no-memcheck Tests/test_file_eps.py

# to run one test with GDB support:
# PYTHONMALLOC=malloc valgrind --vgdb-error=0 --suppressions=../../test/python.supp pytest Tests/test_file_libtiff.py::TestFileLibTiff::test_custom_metadata
