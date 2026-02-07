FROM quay.io/centos/centos:stream9

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
    nasm \
    ninja-build \
    openjpeg2-devel \
    openssl-devel \
    patch \
    sqlite-devel \
    sudo \
    tcl-devel \
    tk-devel \
    wget \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1001 pillow

RUN wget https://www.python.org/ftp/python/3.10.18/Python-3.10.18.tgz \
    && tar xzf Python-3.10.18.tgz \
    && cd Python-3.10.18 \
    && ./configure \
    && make altinstall \
    && cd .. \
    && rm -r Python-3.10.18 Python-3.10.18.tgz

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN bash -c "python3.10 -m pip install virtualenv \
    && python3.10 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

COPY depends /depends
RUN ln -sf /usr/local/bin/python3.10 /usr/bin/python3
RUN /usr/bin/python3 -m pip install --no-cache-dir meson
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_libavif.sh \
    && ./install_raqm.sh \
    && ldconfig

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/centos-stream-9-amd64
