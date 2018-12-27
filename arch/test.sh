#!/bin/bash
source /vpy/bin/activate
cd /Pillow
make clean
make install-coverage
QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests

source /vpy3/bin/activate
make clean
make install-coverage
QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests
