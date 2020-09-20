#!/bin/bash
source /vpy/bin/activate
cd /Pillow
export DISPLAY=:99.0
make clean
make install-coverage
/usr/bin/xvfb-run -a python ./test-installed.py --processes=0 -v --with-coverage
