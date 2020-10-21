FROM fedora:33

RUN dnf install -y \
    freetype-devel \
    fribidi-devel \
    gcc \
    harfbuzz-devel \
    lcms2-devel \
    libimagequant-devel \
    libjpeg-devel \
    libraqm-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    openjpeg2-devel \
    python3-devel \
    python3-tkinter \
    python3-virtualenv \
    redhat-rpm-config \
    tcl-devel \
    tk-devel \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && dnf clean all

RUN useradd pillow \
    && chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python3.9 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install cffi olefile pytest pytest-cov \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/fedora-33-amd64
