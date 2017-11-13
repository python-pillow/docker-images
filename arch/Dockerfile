# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Sy --noconfirm \
            python2 python  \
            python2-virtualenv \
            python-virtualenv \
            gcc make git sudo wget \
            python2-setuptools \
            python-setuptools \
            extra/libjpeg-turbo \
            extra/openjpeg2 \
            extra/libtiff \
            extra/lcms2 \
            extra/libwebp \
            extra/freetype2 \
            extra/tk \
            libffi \
            mesa-libgl \
            xorg-server-xvfb \
            ghostscript \
            python2-pyqt5 \
            python-pyqt5  \
            pkg-config \
            extra/fribidi \
            extra/harfbuzz


ADD depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_raqm.sh

RUN /sbin/useradd -m -U -u 1000 pillow && \
    virtualenv2 --system-site-packages /vpy && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy && \
    virtualenv --system-site-packages /vpy3 && \
    /vpy3/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy3

RUN echo "#!/bin/bash" >> /test && \
    echo "set -e" >> test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "make clean" >> test && \
    echo 'CFLAGS="-coverage" python setup.py build_ext --inplace' >> test && \
    echo 'QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a coverage run --include="PIL/*" -m nose -vx Tests/test_*.py' >> test && \
    echo 'coverage report' >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

