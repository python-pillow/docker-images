#!/bin/sh -eu

# options required to trigger the vendored raqm install
OPTS="--global-option build_ext --global-option --vendor-raqm --global-option --vendor-fribidi"
CFLAGS=${CFLAGS:-}
export CFLAGS="$CFLAGS --std=c99"

# not strictly necessary, unless running multiple versions from the shell
rm -f /tmp/*.whl || true

# python version, as 36,37,38,39. Defaults to 3.8.
# Matches the naming in /opt/python/
PYVER=${1:-38}
PYBIN=$(echo /opt/python/cp${PYVER}*/bin)

# We have to clean up the pillow directories, otherwise we might get
# cached builds that are not manylinux wheel compatible
cd /Pillow
PATH=$PYBIN:$PATH make clean

# Build and repair
$PYBIN/pip --verbose wheel ${OPTS} -w /tmp /Pillow
auditwheel repair /tmp/Pillow*whl -w /output
