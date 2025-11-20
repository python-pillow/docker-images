FROM amazonlinux:2

RUN yum install -y \
    cmake \
    curl \
    findutils \
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
    openssl-devel \
    pth-devel \
    shadow-utils \
    sqlite-devel \
    sudo \
    tar \
    tk-devel \
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

ADD depends /depends
RUN cd /depends \
    && ./install_imagequant.sh

RUN yum remove -y openssl-devel && \
    yum install -y openssl11-devel && \
    yum clean all

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

RUN wget https://github.com/ninja-build/ninja/releases/download/v1.13.2/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/bin
RUN python3.10 -m pip install meson
RUN ln -s /usr/local/bin/python3.10 /usr/bin/python3
RUN cd /depends \
    && ./install_openjpeg.sh \
    && ./download-and-extract.sh freetype-2.14.1 https://raw.githubusercontent.com/python-pillow/pillow-depends/main/freetype-2.14.1.tar.gz \
    && cd freetype-2.14.1 && ./configure --prefix=/usr && make -j4 install && cd .. \
    && ./install_raqm.sh \
    && ./install_webp.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/amazon-2-amd64
