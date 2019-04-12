# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Syu --noconfirm \
            wget
RUN pacman -Sy --noconfirm \
            python2 python  \
            python2-virtualenv \
            python-virtualenv \
            gcc make git sudo \
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
    /vpy/bin/pip install --upgrade pip && \
    /vpy/bin/pip install nose cffi olefile pytest pytest-cov && \
    /vpy/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy && \
    virtualenv --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install nose cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

USER pillow
CMD ["depends/test.sh"]

