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
    python3 \
    python3-tkinter \
    python3-virtualenv \
    tcl-devel \
    tk-devel \
    which \
    xorg-x11-server-Xvfb \
    zlib-devel \
    && yum clean all

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/virtualenv -p python3.6 --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi olefile pytest pytest-cov pytest-timeout \
    && /vpy3/bin/pip install --no-cache-dir numpy --only-binary=:all: || true \
    && chown -R pillow:pillow /vpy3"

COPY depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/centos-stream-8-amd64
