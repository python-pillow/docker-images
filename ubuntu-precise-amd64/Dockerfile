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
    /vpy/bin/pip install -U pip --index-url=https://pypi.python.org/simple/ && \
    /vpy/bin/pip install -U setuptools wheel && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy

ADD depends /depends
RUN cd /depends && ./install_openjpeg.sh && ./install_imagequant.sh

RUN echo "#!/bin/bash" >> /test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "export DISPLAY=:99.0" >> test && \
    echo "make clean && make install-coverage && /usr/bin/xvfb-run -a python ./test-installed.py --processes=0 -v --with-coverage" >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/ubuntu-precise-amd64
