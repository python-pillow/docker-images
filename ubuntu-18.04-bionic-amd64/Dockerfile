FROM ubuntu:bionic

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
    libssl-dev \
    libsqlite3-dev \
    libtiff5-dev \
    libwebp-dev \
    netpbm \
    sudo \
    tcl8.6-dev \
    tk8.6-dev \
    wget \
    xvfb \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN useradd pillow \
    && addgroup pillow sudo \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

RUN wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz \
    && tar xzf Python-3.9.7.tgz \
    && cd Python-3.9.7 \
    && ./configure \
    && make altinstall

RUN python3.9 -m pip install virtualenv \
    && python3.9 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi numpy olefile pytest pytest-cov pytest-timeout \
    && chown -R pillow:pillow /vpy3

ADD depends /depends
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_raqm.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/ubuntu-18.04-bionic-amd64
