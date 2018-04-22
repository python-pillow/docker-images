FROM amazonlinux:2

run amazon-linux-extras install python3

run yum install -y shadow-utils util-linux xorg-x11-xauth \
    findutils which \
    python3-devel python3-test python3-tkinter python-virtualenv \
    gcc xorg-x11-server-Xvfb ghostscript sudo wget cmake make \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel harfbuzz-devel fribidi-devel \
    libffi-devel \
    pth-devel gcc-c++ tar

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/pip3 install virtualenv && \
    /usr/bin/python3 -mvirtualenv -p /usr/bin/python3 --system-site-packages /vpy && \
    /vpy/bin/pip install cffi olefile pytest pytest-cov && \
    chown -R pillow:pillow /vpy "

ADD depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_openjpeg.sh && ./install_raqm.sh

RUN echo "#!/bin/bash" >> /test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "export DISPLAY=:99.0" >> test && \
    echo "export LD_LIBRARY_PATH=/usr/lib" >> test && \
    echo "make clean && make install-coverage && /usr/bin/xvfb-run -a pytest -vx --cov PIL --cov-report term Tests" >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

