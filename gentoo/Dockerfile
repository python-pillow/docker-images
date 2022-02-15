FROM gentoo/stage3:desktop

# Disable bits which don't work within Docker.
RUN echo 'FEATURES="-ipc-sandbox -pid-sandbox -network-sandbox -usersandbox -mount-sandbox -sandbox"' | cat >> /etc/portage/make.conf
# Speed things up a bit.
RUN echo 'FEATURES="${FEATURES} parallel-install parallel-fetch -merge-sync"' | cat >> /etc/portage/make.conf

# TODO: May be able to drop this once changed to desktop docker images?
# https://dilfridge.blogspot.com/2021/09/experimental-binary-gentoo-package.html
RUN echo -e "[binhost]\npriority = 9999\nsync-uri = https://gentoo.osuosl.org/experimental/amd64/binpkg/default/linux/17.1/x86-64/\n" | cat >> /etc/portage/binrepos.conf

RUN echo 'EMERGE_DEFAULT_OPTS="--binpkg-respect-use=n --getbinpkg=y --autounmask-write --autounmask-continue --autounmask-keep-keywords=y --autounmask-use=y"' | cat >> /etc/portage/make.conf
RUN echo 'USE="elogind -polkit"' | cat >> /etc/portage/make.conf
RUN cat /etc/portage/make.conf                                                  

RUN emerge-webrsync --quiet || true 
RUN eselect news read --quiet all || true

# Make sure everything is consistent first.
RUN emerge --quiet -uDU @world

# Install some useful bits.
RUN emerge --quiet --oneshot --jobs=$(nproc) media-libs/libjpeg-turbo sys-libs/zlib app-text/ghostscript-gpl 

# Try install as many of our (test) dependencies as possible with fewer flags on
RUN emerge --quiet --oneshot --onlydeps --jobs=$(nproc) --with-test-deps dev-python/pillow || true

# Then install the remaining (test) dependencies with more flags (because they clearly didn't get picked up before)
# ... and these more flags are needed to run tests anyway.
RUN USE="jpeg jpeg2k tiff truetype xvfb X elogind" emerge --quiet --oneshot --onlydeps --with-test-deps --getbinpkg=n dev-python/pillow

# Actually build & run the tests.
# TODO: change this to use the mounted version of Pillow (so the commit to be tested)
RUN FEATURES="test" USE="jpeg jpeg2k tiff truetype xvfb X elogind" emerge --verbose --oneshot --getbinpkg=n dev-python/pillow
