FROM fedora:29

RUN dnf install -y redhat-rpm-config \
    python-devel python3-devel python-virtualenv python3-virtualenv make gcc \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel openjpeg2-devel tkinter python3-tkinter \
    tcl-devel tk-devel harfbuzz-devel fribidi-devel libraqm-devel \
    libimagequant-devel \
    xorg-x11-server-Xvfb which

RUN useradd pillow && \
    chown pillow:pillow /home/pillow

RUN /usr/bin/python2.7 /usr/lib/python2.7/site-packages/virtualenv.py --system-site-packages /vpy && \
    /vpy/bin/pip install --upgrade pip && \
    /vpy/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy && \
    /usr/bin/python3.7 /usr/lib/python3.7/site-packages/virtualenv.py --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/fedora-29-amd64
