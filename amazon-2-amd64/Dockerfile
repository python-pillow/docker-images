FROM amazonlinux:2

RUN amazon-linux-extras install python3

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
    libffi-devel \
    libjpeg-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    pth-devel \
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

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/pip3 install virtualenv \
    && /usr/bin/python3 -mvirtualenv -p /usr/bin/python3 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/bin
RUN /usr/bin/python3 -m pip install meson
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_openjpeg.sh \
    && ./install_raqm.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/amazon-2-amd64
