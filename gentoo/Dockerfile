FROM gentoo/stage3:desktop

# Disable bits which don't work within Docker.
RUN echo 'FEATURES="-ipc-sandbox -pid-sandbox -network-sandbox -usersandbox -mount-sandbox -sandbox"' | cat >> /etc/portage/make.conf
# Speed things up a bit.
RUN echo 'FEATURES="${FEATURES} parallel-install parallel-fetch -merge-sync"' | cat >> /etc/portage/make.conf
# We use binpkgs.
RUN echo 'FEATURES="${FEATURES} getbinpkg binpkg-request-signature"' | cat >> /etc/portage/make.conf

RUN echo 'EMERGE_DEFAULT_OPTS="--autounmask-write --autounmask-continue --autounmask-keep-keywords=y --autounmask-use=y"' | cat >> /etc/portage/make.conf
RUN echo 'USE="elogind -polkit"' | cat >> /etc/portage/make.conf
RUN cat /etc/portage/make.conf

RUN emerge-webrsync --quiet || true
RUN eselect news read --quiet all || true

# Make sure everything is consistent first.
RUN emerge --quiet -uDU @world

# We're not running on real hardware, so set basic values instead.
# We deliberately set this quite late on to avoid rebuilding e.g. mesa.
RUN echo 'VIDEO_CARDS="fbdev dummy"' | cat >> /etc/portage/make.conf

RUN emerge --quiet dev-python/virtualenv dev-util/cargo-c dev-build/meson x11-misc/xvfb-run

# Install dependencies
RUN USE="jpeg jpeg2k lcms tiff truetype webp xcb zlib" emerge --quiet --onlydeps dev-python/pillow
RUN emerge --quiet app-text/ghostscript-gpl dev-python/numpy

RUN useradd pillow \
    && chown pillow:pillow /home/pillow

RUN virtualenv --system-site-packages /vpy3 \
    && /vpy3/bin/pip install --no-cache-dir --upgrade pip \
    && /vpy3/bin/pip install --no-cache-dir cffi pytest-cov pytest-timeout \
    && chown -R pillow:pillow /vpy3

ADD depends /depends
RUN cd /depends && ./install_imagequant.sh && ./install_raqm.sh && ldconfig

USER pillow
CMD ["depends/test.sh"]

#docker run -v $GITHUB_WORKSPACE:/Pillow pythonpillow/gentoo
