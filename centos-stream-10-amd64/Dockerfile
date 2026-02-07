FROM quay.io/centos/centos:stream10

RUN yum install -y 'dnf-command(config-manager)' \
    && yum clean all

RUN yum config-manager --set-enabled crb

RUN yum install -y \
    cargo \
    cmake \
    freetype-devel \
    gcc-c++ \
    ghostscript \
    git \
    lcms2-devel \
    libjpeg-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    meson \
    nasm \
    openjpeg2-devel \
    openssl-devel \
    patch \
    python3-devel \
    python3-pip \
    python3-tkinter \
    sudo \
    tcl-devel \
    tk-devel \
    wget \
    which \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1001 pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN bash -c "python3.12 -m pip install virtualenv \
    && python3.12 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

COPY depends /depends
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_libavif.sh \
    && ./install_raqm.sh \
    && ldconfig

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/centos-stream-10-amd64
