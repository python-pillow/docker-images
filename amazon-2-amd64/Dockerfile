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
    harfbuzz-devel \
    lcms2-devel \
    libffi-devel \
    libjpeg-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    pth-devel \
    python3-devel \
    python3-test \
    python3-tkinter \
    python3-virtualenv \
    shadow-utils \
    sudo \
    tar \
    util-linux \
    wget \
    which \
    xorg-x11-server-Xvfb \
    xorg-x11-xauth \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/pip3 install virtualenv && \
    /usr/bin/python3 -mvirtualenv -p /usr/bin/python3 --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN cd /depends && \
    ./install_imagequant.sh && \
    ./install_openjpeg.sh && \
    ./install_raqm.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/amazon-2-amd64
