FROM fedora:31

RUN dnf install -y redhat-rpm-config \
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
    tcl-devel \
    tk-devel \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel

RUN useradd pillow && \
    chown pillow:pillow /home/pillow

RUN /usr/bin/python3.7 /usr/lib/python3.7/site-packages/virtualenv.py --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/fedora-31-amd64
