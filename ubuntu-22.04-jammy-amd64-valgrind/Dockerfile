FROM ubuntu:jammy

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    cmake \
    ghostscript \
    git \
    libffi-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libimagequant-dev \
    libjpeg-turbo-progs \
    libjpeg8-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libssl-dev \
    libtiff5-dev \
    libwebp-dev \
    meson \
    netpbm \
    python3.10-dbg \
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
    valgrind \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd --uid 1001 pillow \
    && addgroup pillow sudo \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN virtualenv -p /usr/bin/python3.10-dbg --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install cffi olefile pytest pytest-cov pytest-timeout pytest-valgrind \
    && chown -R pillow:pillow /vpy3

ADD depends /depends
RUN cd /depends \
    && ./install_raqm.sh

COPY python.supp /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/ubuntu-22.04-jammy-amd64
