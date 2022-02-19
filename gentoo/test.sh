#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
pip install pytest
make clean
make install-coverage
python3 -c "from PIL import Image"
QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests
