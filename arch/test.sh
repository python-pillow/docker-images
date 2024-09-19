#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
make install-coverage
QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a .ci/test.sh
