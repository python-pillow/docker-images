FROM fedora:25

RUN dnf install -y redhat-rpm-config \
    python-devel python3-devel python-virtualenv make gcc \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel openjpeg2-devel tkinter python3-tkinter \
    tcl-devel tk-devel harfbuzz-devel fribidi-devel libraqm-devel \
    libimagequant-devel \
    xorg-x11-server-Xvfb which

RUN useradd pillow && \
    chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy

RUN echo "#!/bin/bash" >> /test && \
    echo "set -e" >> test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "make clean" >> test && \
    echo 'CFLAGS="-coverage" python setup.py build_ext --inplace' >> test && \
    echo '/usr/bin/xvfb-run -a coverage run --include="PIL/*" -m nose -vx Tests/test_*.py' >> test && \
    echo 'coverage report' >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/fedora-25-amd64
