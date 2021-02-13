# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Syu --noconfirm \
            wget \
    && find /var/cache/pacman/ -type f -delete

# Temporary fix for Arch breaking
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

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
            xorg-server-xvfb \
    && find /var/cache/pacman/ -type f -delete

ADD depends /depends
RUN cd /depends \
     && ./install_imagequant.sh \
     && ./install_raqm.sh

RUN /sbin/useradd -m -U -u 1000 pillow \
    && virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir nose cffi olefile pytest pytest-cov \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/arch
