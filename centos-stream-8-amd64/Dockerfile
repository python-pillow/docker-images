FROM quay.io/centos/centos:stream8

RUN yum install -y epel-release https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    && yum clean all

RUN yum install -y 'dnf-command(config-manager)' \
    && yum clean all

RUN yum config-manager --set-enabled powertools

RUN yum install -y \
    freetype-devel \
    gcc \
    ghostscript \
    lcms2-devel \
    libffi-devel \
    libimagequant-devel \
    libjpeg-devel \
    libraqm-devel \
    libtiff-devel \
    libwebp-devel \
    make \
    openjpeg2-devel \
    openssl-devel \
    sqlite-devel \
    tcl-devel \
    tk-devel \
    wget \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1000 pillow

RUN wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz \
    && tar xzf Python-3.9.7.tgz \
    && cd Python-3.9.7 \
    && ./configure \
    && make altinstall \
    && cd .. \
    && rm -r Python-3.9.7 Python-3.9.7.tgz

RUN bash -c "python3.9 -m pip install virtualenv \
    && python3.9 -m virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

COPY depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/centos-stream-8-amd64
