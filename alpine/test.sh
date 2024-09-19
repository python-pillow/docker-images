#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
LIBRARY_PATH=/lib:/usr/lib make install-coverage
.ci/test.sh
