FROM amazonlinux:1

RUN yum install -y \
    cmake \
    findutils \
    freetype-devel \
    gcc \
    ghostscript \
    lcms2-devel \
    libffi-devel \
    libjpeg-devel \
    libtiff-devel \
    libwebp-devel \
    python36 \
    python36-devel \
    python36-virtualenv \
    shadow-utils \
    sudo \
    util-linux \
    wget \
    which \
    xorg-x11-server-Xvfb \
    xorg-x11-xauth \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/virtualenv-3.6 -p python3.6 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install cffi olefile pytest pytest-cov \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN cd /depends \
    && ./install_imagequant.sh \
    && ./install_openjpeg.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/amazon-1-amd64
