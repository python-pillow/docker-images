# Originally from https://github.com/M0E-lnx/ubuntu-32bit with thanks,
# and then https://github.com/matthew-brett/trusty/blob/32/Dockerfile

FROM scratch
ADD debian-bookworm-i386.tgz /

# a few minor docker-specific tweaks
# see https://github.com/docker/docker/blob/master/contrib/mkimage/debootstrap
RUN echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
    && echo 'exit 101' >> /usr/sbin/policy-rc.d \
    && chmod +x /usr/sbin/policy-rc.d \
    \
    && dpkg-divert --local --rename --add /sbin/initctl \
    && cp -a /usr/sbin/policy-rc.d /sbin/initctl \
    && sed -i 's/^exit.*/exit 0/' /sbin/initctl \
    \
    && echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup \
    \
    && echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean \
    && echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean \
    && echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean \
    \
    && echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages \
    \
    && echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes

#    && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' >> /etc/apt/sources.list \
#    && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe' >> /etc/apt/sources.list

#
# Pillow customization
#

RUN apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    cmake \
    curl \
    ghostscript \
    git \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-turbo-progs \
    libjpeg62-turbo-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libtiff5-dev \
    libwebp-dev \
    libssl-dev \
    meson \
    nasm \
    netpbm \
    python3-dev \
    python3-numpy \
    python3-setuptools \
    python3-tk \
    sudo \
    tcl8.6-dev \
    tk8.6-dev \
    virtualenv \
    wget \
    xvfb \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-host=i686-unknown-linux-gnu
ENV PATH="/root/.cargo/bin:${PATH}"

RUN useradd -u 1001 pillow \
    && mkdir /home/pillow \
    && chown pillow:pillow /home/pillow

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN virtualenv -p /usr/bin/python3.11 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --upgrade pip \
    && /vpy3/bin/pip install olefile pytest pytest-cov pytest-timeout \
    && chown -R pillow:pillow /vpy3

COPY depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_libavif.sh && ./install_raqm.sh

ENV FORCE_COLOR=1

USER pillow
ENTRYPOINT ["linux32"]
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/debian-12-bookworm-x86
