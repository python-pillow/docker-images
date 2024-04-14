#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
export DISPLAY=:99.0
make clean
make install-coverage
python3 -c "from PIL import Image"
/usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests
