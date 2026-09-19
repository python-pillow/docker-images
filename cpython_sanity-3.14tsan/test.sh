#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
make install-tsan
/usr/bin/xvfb-run -a .ci/test.sh
