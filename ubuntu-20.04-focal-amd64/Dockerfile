FROM ubuntu:focal

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    cmake \
    curl \
    ghostscript \
    git \
    libegl-dev \
    libffi-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-turbo-progs \
    libjpeg8-dev \
    liblcms2-dev \
    libopengl-dev \
    libopenjp2-7-dev \
    libssl-dev \
    libtiff5-dev \
    libwebp-dev \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxkbcommon-x11-0 \
    netpbm \
    ninja-build \
    python3-dev \
    python3-numpy \
    python3-pip \
    python3-setuptools \
    python3-tk \
    sudo \
    tcl8.6-dev \
    tk8.6-dev \
    virtualenv \
    wget \
    xvfb \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN useradd pillow \
    && addgroup pillow sudo \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python3.8 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pyside6 pytest pytest-cov pytest-timeout \
    && chown -R pillow:pillow /vpy3

ADD depends /depends
RUN /usr/bin/python3 -m pip install --no-cache-dir meson
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_raqm.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/ubuntu-20.04-focal-amd64
