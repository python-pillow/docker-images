# This is a sample Dockerfile to build Pillow on Arch Linux
# with all/most of the dependencies working.

FROM greyltc/archlinux

RUN pacman -Sy --noconfirm \
	        python2 python  \
 			python2-virtualenv \
 			python-virtualenv \	
			gcc make git sudo wget \
			python2-setuptools \
 			python-setuptools \
 			extra/libjpeg-turbo \
			extra/openjpeg2 \
			extra/libtiff \
			extra/lcms2 \
			extra/libwebp \
			extra/freetype2 \
			extra/tk \
			libffi \
			mesa-libgl \
			xorg-server-xvfb \
	        ghostscript \
			python2-pyqt5 \ 
			python-pyqt5  


ADD depends /depends
RUN	cd /depends && ./install_imagequant.sh

RUN /sbin/useradd -m -U -u 1000 pillow && \
	virtualenv2 --system-site-packages /vpy && \
	/vpy/bin/pip install nose && \
	/vpy/bin/pip install cffi && \	
	chown -R pillow:pillow /vpy && \
	virtualenv --system-site-packages /vpy3 && \
	/vpy3/bin/pip install nose && \
	/vpy3/bin/pip install cffi && \	
	chown -R pillow:pillow /vpy3

RUN echo "#!/bin/bash" >> /test && \
    echo "source /vpy/bin/activate && cd /Pillow " >> test && \
	echo "make clean && make install " >> test && \
	echo "QT_QPA_PLATFORM=offscreen /usr/bin/xvfb-run -a python test-installed.py -v" >> test

RUN chmod +x /test

USER pillow
CMD ["/test"]

