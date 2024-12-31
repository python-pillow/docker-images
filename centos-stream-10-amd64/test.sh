#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
make install-coverage
.ci/test.sh
