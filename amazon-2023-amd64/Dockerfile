FROM amazonlinux:2023

RUN yum install -y \
    cmake \
    findutils \
    freetype-devel \
    fribidi-devel \
    gcc \
    gcc-c++ \
    ghostscript \
    git \
    harfbuzz-devel \
    lcms2-devel \
    libjpeg-devel \
    libtiff-devel \
    make \
    nasm \
    openssl-devel \
    python3-devel \
    python3-pip \
    python3-test \
    python3-tkinter \
    python3-virtualenv \
    shadow-utils \
    sudo \
    tar \
    unzip \
    util-linux \
    wget \
    which \
    xorg-x11-server-Xvfb \
    xorg-x11-xauth \
    zlib-devel \
    && yum clean all

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN useradd --uid 1001 pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN bash -c "/usr/bin/pip3 install virtualenv \
    && /usr/bin/python3 -mvirtualenv -p /usr/bin/python3 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.13.1/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/bin
RUN /usr/bin/python3 -m pip install meson
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_libavif.sh \
    && ./install_openjpeg.sh \
    && ./install_raqm.sh \
    && ./install_webp.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/amazon-2023-amd64
