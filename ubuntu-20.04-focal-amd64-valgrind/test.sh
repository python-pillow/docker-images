#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
make install-coverage
#PYTHONMALLOC=malloc valgrind pytest -vx --cov PIL --cov-report term Tests 2>&1 | grep -B10 -A3 decode.c
# --show-leak-kinds=definite
PYTHONMALLOC=malloc valgrind --suppressions=/depends/python.supp --leak-check=no \
            --log-file=/tmp/valgrind-output \
            python -m pytest --no-memcheck -vv --valgrind --valgrind-log=/tmp/valgrind-output

if [ "$?" -eq 0 ]; then
    exit 1;
fi;
