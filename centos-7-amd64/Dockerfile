FROM centos:7

run yum install -y epel-release centos-release-scl

run yum install -y  python27 python-virtualenv \
    gcc xorg-x11-server-Xvfb make which ghostscript sudo \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel openjpeg2-devel tkinter \
    tcl-devel tk-devel libffi-devel libimagequant-devel \
    libraqm-devel

RUN useradd --uid 1000 pillow

RUN bash -c "source /opt/rh/python27/enable && \
    /opt/rh/python27/root/usr/bin/virtualenv -p python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install nose cffi olefile nose-cov coverage cov-core && \
    cat /opt/rh/python27/enable /vpy/bin/activate > /vpy/bin/activate2.7 && \
    mv  /vpy/bin/activate2.7  /vpy/bin/activate && \
    chown -R pillow:pillow /vpy "

RUN echo "#!/bin/bash" >> /test && \
    echo "set -e" >> test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
    echo "export DISPLAY=:99.0" >> test && \
    echo "make clean" >> test && \
    echo 'CFLAGS="-coverage" python setup.py build_ext --inplace' >> test && \
    echo '/usr/bin/xvfb-run -a coverage run --include="PIL/*" -m nose -vx Tests/test_*.py' >> test && \
    echo 'coverage report' >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

