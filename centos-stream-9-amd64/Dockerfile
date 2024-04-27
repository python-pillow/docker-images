FROM quay.io/centos/centos:stream9

RUN yum install -y 'dnf-command(config-manager)' \
    && yum clean all

RUN yum config-manager --set-enabled crb

RUN yum install -y \
    cargo \
    cmake \
    freetype-devel \
    gcc \
    ghostscript \
    git \
    lcms2-devel \
    libffi-devel \
    libjpeg-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    meson \
    openjpeg2-devel \
    openssl-devel \
    python3-devel \
    python3-pip \
    python3-tkinter \
    sudo \
    tcl-devel \
    tk-devel \
    wget \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1001 pillow

RUN bash -c "python3.9 -m pip install virtualenv \
    && python3.9 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

COPY depends /depends
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_raqm.sh \
    && ldconfig

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/centos-stream-9-amd64
