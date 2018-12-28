#!/bin/bash
source /vpy/bin/activate
cd /Pillow
make clean
make install-coverage
/usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests

source /vpy3/bin/activate
cd /Pillow
make clean
make install-coverage
/usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests
