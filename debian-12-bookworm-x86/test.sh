#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
export DISPLAY=:99.0
make clean
make install-coverage
/usr/bin/xvfb-run -a .ci/test.sh
