FROM ubuntu:focal

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    cmake \
    ghostscript \
    git \
    libffi-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-turbo-progs \
    libjpeg8-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libtiff5-dev \
    libwebp-dev \
    netpbm \
    python3.8-dbg \
    python3-dev \
    python3-numpy \
    python3-scipy \
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

RUN useradd pillow \
    && addgroup pillow sudo \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python3.8-dbg --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-valgrind \
    && chown -R pillow:pillow /vpy3

ADD depends /depends
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_raqm.sh

COPY python.supp /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/ubuntu-20.04-focal-amd64
