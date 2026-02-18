FROM ubuntu:noble

RUN apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    cmake \
    ghostscript \
    git \
    libavif-dev \
    libegl-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libimagequant-dev \
    libjpeg-turbo8-dev \
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
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxkbcommon-x11-0 \
    meson \
    netpbm \
    python3-dev \
    python3-numpy \
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

RUN useradd pillow \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN virtualenv -p /usr/bin/python3.12 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pyside6 pytest pytest-cov pytest-timeout \
    && chown -R pillow:pillow /vpy3

COPY depends /depends
RUN cd /depends \
    && ./install_raqm.sh

ENV FORCE_COLOR=1

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/ubuntu-24.04-noble-amd64
