FROM centos:8

RUN yum install -y epel-release http://rpms.remirepo.net/enterprise/remi-release-8.rpm

RUN yum install -y 'dnf-command(config-manager)'

RUN yum config-manager --set-enabled PowerTools

RUN yum install -y python2-devel python3 python3-virtualenv \
    gcc xorg-x11-server-Xvfb make which ghostscript sudo \
    libtiff-devel libjpeg-devel zlib-devel freetype-devel \
    lcms2-devel libwebp-devel openjpeg2-devel python2-tkinter python3-tkinter \
    tcl-devel tk-devel libffi-devel libimagequant-devel \
    libraqm-devel

RUN useradd --uid 1000 pillow

RUN bash -c "/usr/bin/virtualenv -p python2.7 --system-site-packages /vpy && \
    /vpy/bin/pip install --upgrade pip && \
    /vpy/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy && \
    /usr/bin/virtualenv -p python3.6 --system-site-packages /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install cffi olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3"

ADD depends /depends

USER pillow
CMD ["depends/test.sh"]

