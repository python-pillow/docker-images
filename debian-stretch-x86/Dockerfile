# Originaly from https://github.com/M0E-lnx/ubuntu-32bit with thanks,
# and then https://github.com/matthew-brett/trusty/blob/32/Dockerfile

FROM scratch
ADD debian-stretch-i386.tgz /

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

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y \
    install xvfb sudo \
    git wget python-numpy python-scipy netpbm \
    python-qt4 ghostscript libffi-dev libjpeg-turbo-progs \
    python-setuptools python-virtualenv \
    python-dev python3-dev cmake \
    libtiff5-dev libjpeg62-turbo-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev \
    python-tk python3-tk \
    libharfbuzz-dev libfribidi-dev && apt-get clean

RUN useradd pillow && addgroup pillow sudo && \
    mkdir /home/pillow && chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install --upgrade pip && \
    /vpy/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy && \
    virtualenv -p /usr/bin/python3.5 --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

ADD depends /depends
RUN cd /depends && ./install_openjpeg.sh && ./install_imagequant.sh && ./install_raqm.sh

USER pillow
ENTRYPOINT ["linux32"]
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/ubuntu-trusty-x86
