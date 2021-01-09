#!/bin/bash
source /vpy3/bin/activate
cd /Pillow
make clean
LIBRARY_PATH=/lib:/usr/lib make install-coverage
python3 -c "from PIL import Image"
pytest -vx --cov PIL --cov-report term Tests
