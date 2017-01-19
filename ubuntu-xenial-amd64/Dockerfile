FROM ubuntu:xenial
USER root

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y \
	install sudo \
	git wget python-virtualenv python-numpy python-scipy netpbm \
	python-qt4 ghostscript libffi-dev libjpeg-turbo-progs \
	python-dev python-setuptools \
    python3-dev cmake  \
	libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev \
    python-tk python3-tk

RUN virtualenv -p /usr/bin/python2.7 --system-site-packages /vpy && \
	/vpy/bin/pip install nose && \
	/vpy/bin/pip install cffi
				 

RUN echo "#!/bin/bash" >> /test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
	echo "pushd depends && ./install_openjpeg.sh && ./install_imagequant.sh && popd" >> test && \
	echo "make install && python ./test-installed.py -v" >> test

RUN chmod +x /test

CMD ["/test"]

#docker run -v $TRAVIS_BUILD_DIR:/Pillow pillow-ubuntu-xenial-amd64