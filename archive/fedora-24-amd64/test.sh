#!/bin/bash
source /vpy/bin/activate
cd /Pillow
make clean
make install-coverage
/usr/bin/xvfb-run -a python ./test-installed.py -v --with-coverage
