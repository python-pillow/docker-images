# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Syu --noconfirm \
            wget
RUN pacman -Sy --noconfirm \
            extra/freetype2 \
            extra/fribidi \
            extra/harfbuzz \
            extra/lcms2 \
            extra/libjpeg-turbo \
            extra/libtiff \
            extra/libwebp \
            extra/openjpeg2 \
            extra/tk \
            gcc \
            ghostscript \
            git \
            libffi \
            make \
            mesa-libgl \
            pkg-config \
            python \
            python-pyqt5 \
            python-setuptools \
            python-virtualenv \
            sudo \
            xorg-server-xvfb


ADD depends /depends
RUN cd /depends && \
     ./install_imagequant.sh && \
     ./install_raqm.sh

RUN /sbin/useradd -m -U -u 1000 pillow && \
    virtualenv --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install nose cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/arch
