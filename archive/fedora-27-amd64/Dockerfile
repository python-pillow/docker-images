FROM fedora:27

RUN dnf install -y redhat-rpm-config \
    python-devel python3-devel python-virtualenv make gcc \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel openjpeg2-devel tkinter python3-tkinter \
    tcl-devel tk-devel harfbuzz-devel fribidi-devel libraqm-devel \
    libimagequant-devel \
    xorg-x11-server-Xvfb which

RUN useradd pillow && \
    chown pillow:pillow /home/pillow

RUN virtualenv -p /usr/bin/python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install cffi olefile numpy pytest pytest-cov && \
    chown -R pillow:pillow /vpy

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pythonpillow/fedora-27-amd64
