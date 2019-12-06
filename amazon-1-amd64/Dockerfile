FROM amazonlinux:1

run yum install -y shadow-utils util-linux xorg-x11-xauth \
    findutils which \
    python36 python36-virtualenv python36-devel \
    gcc xorg-x11-server-Xvfb ghostscript sudo wget cmake \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel  \
    libffi-devel

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/virtualenv-3.6 -p python3.6 --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3"

ADD depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_openjpeg.sh

USER pillow
CMD ["depends/test.sh"]

