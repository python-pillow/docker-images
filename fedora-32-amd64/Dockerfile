FROM fedora:32

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

RUN /usr/bin/python3.8 /usr/lib/python3.8/site-packages/virtualenv.py --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/fedora-32-amd64
