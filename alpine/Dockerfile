# This is a sample Dockerfile to build Pillow on Alpine Linux
# with all/most of the dependencies working.
#
# Tcl/Tk isn't detecting
# Freetype has different metrics so tests are failing.
# sudo and bash are required for the webp build script.

FROM alpine

RUN apk --no-cache add python \
                       build-base \
                       python-dev \
                       # wget dependency
                       openssl \
                       # dev dependencies
                       git \
                       bash \
                       sudo \
                       py2-pip \
                       # Pillow dependencies
                       jpeg-dev \
                       zlib-dev \
                       freetype-dev \
                       lcms2-dev \
                       openjpeg-dev \
                       tiff-dev \
                       tk-dev \
                       tcl-dev \
                       harfbuzz-dev \
                       fribidi-dev

ADD depends /depends
RUN cd /depends && ./install_webp.sh && ./install_imagequant.sh && ./install_raqm.sh

RUN /usr/sbin/adduser -D pillow && \
    pip install virtualenv && virtualenv /vpy && \
    /vpy/bin/pip install nose olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy

RUN echo "#!/bin/bash" >> /test && \
    echo "set -e" >> test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "make clean" >> test && \
    echo 'LIBRARY_PATH=/lib:/usr/lib CFLAGS="-coverage" python setup.py build_ext --inplace' >> test && \
    echo 'coverage run --include="PIL/*" -m nose -vx Tests/test_*.py' >> test && \
    echo 'coverage report' >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pillow-alpine
