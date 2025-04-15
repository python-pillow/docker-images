FROM fedora:42

RUN dnf install -y \
    freetype-devel \
    fribidi-devel \
    gcc \
    harfbuzz-devel \
    lcms2-devel \
    libavif-devel \
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
    util-linux \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && dnf clean all

RUN useradd --uid 1001 pillow \
    && chown pillow:pillow /home/pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN virtualenv -p /usr/bin/python3.13 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/fedora-42-amd64
