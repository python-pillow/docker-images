FROM amazonlinux:2

run yum install -y shadow-utils util-linux xorg-x11-xauth \
    findutils which \
    python python-virtualenv \
    gcc xorg-x11-server-Xvfb ghostscript sudo wget cmake \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel  \
    libffi-devel

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/virtualenv -p python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    chown -R pillow:pillow /vpy "

ADD depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_openjpeg.sh

RUN echo "#!/bin/bash" >> /test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "export DISPLAY=:99.0" >> test && \
    echo "export LD_LIBRARY_PATH=/usr/lib" >> test && \
    echo "make clean" >> test && \
    echo 'CFLAGS="-coverage" python setup.py build_ext --inplace' >> test && \
    echo "/usr/bin/xvfb-run -a coverage run --include="PIL/*" -m nose -vx Tests/test_*.py" >> test && \
    echo 'coverage report' >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

