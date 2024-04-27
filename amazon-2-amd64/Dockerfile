FROM amazonlinux:2

RUN yum install -y \
    cmake \
    curl \
    findutils \
    freetype-devel \
    fribidi-devel \
    gcc \
    gcc-c++ \
    ghostscript \
    git \
    harfbuzz-devel \
    lcms2-devel \
    libffi-devel \
    libjpeg-devel \
    libtiff-devel \
    make \
    openssl-devel \
    sqlite-devel \
    pth-devel \
    shadow-utils \
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

RUN wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz \
    && tar xzf Python-3.9.16.tgz \
    && cd Python-3.9.16 \
    && ./configure \
    && make altinstall \
    && cd .. \
    && rm -r Python-3.9.16 Python-3.9.16.tgz

RUN bash -c "python3.9 -m pip install virtualenv \
    && python3.9 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.12.0/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/bin
RUN python3.9 -m pip install meson
RUN ln -s /usr/local/bin/python3.9 /usr/bin/python3
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_openjpeg.sh \
    && ./install_raqm.sh \
    && ./install_webp.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/amazon-2-amd64
