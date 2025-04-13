# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Syu --noconfirm \
            wget \
    && find /var/cache/pacman/ -type f -delete

RUN pacman -Sy --noconfirm --overwrite "*libedit*,*readline.h,*histedit.h" libedit

RUN pacman -Sy --noconfirm \
            cargo \
            extra/freetype2 \
            extra/fribidi \
            extra/harfbuzz \
            extra/lcms2 \
            extra/libavif \
            extra/libjpeg-turbo \
            extra/libtiff \
            extra/libwebp \
            extra/openjpeg2 \
            extra/tk \
            gcc \
            ghostscript \
            git \
            make \
            mesa-libgl \
            meson \
            pkg-config \
            python \
            python-pyqt6 \
            python-setuptools \
            python-virtualenv \
            sudo \
            xorg-server-xvfb \
    && find /var/cache/pacman/ -type f -delete

ADD depends /depends
RUN cd /depends \
     && ./install_imagequant.sh \
     && ./install_raqm.sh

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN /sbin/useradd -m -U --uid 1001 pillow \
    && virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/arch
