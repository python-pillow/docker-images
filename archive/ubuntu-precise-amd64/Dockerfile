FROM ubuntu:precise

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y \
    install sudo xvfb \
    git wget python-virtualenv python-numpy python-scipy netpbm \
    python-qt4 ghostscript libffi-dev libjpeg-turbo-progs \
    python-dev python-setuptools \
    cmake make \
    libtiff4-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev \
    python-tk

RUN useradd pillow && addgroup pillow sudo

RUN virtualenv -p /usr/bin/python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install -U pip --index-url=https://pypi.org/simple/ && \
    /vpy/bin/pip install -U setuptools wheel && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    /vpy/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy

ADD depends /depends
RUN cd /depends && ./install_openjpeg.sh && ./install_imagequant.sh

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/ubuntu-precise-amd64
