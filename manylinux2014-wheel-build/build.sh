#!/bin/sh -eu

# options required to trigger the vendored Raqm install
OPTS="--global-option build_ext --global-option --vendor-raqm --global-option --vendor-fribidi"

CFLAGS=${CFLAGS:-}
export CFLAGS="$CFLAGS --std=c99"

# Check for debug build
DEBUG=${DEBUG:-0}
if [ $DEBUG ]; then
    OPTS="--global-option build --global-option --debug $OPTS"
    CFLAGS="$CFLAGS -Og -DDEBUG"
fi

# not strictly necessary, unless running multiple versions from the shell
rm -f /tmp/*.whl || true

# Python version, as 37,38,39,310. Defaults to 38.
# Matches the naming in /opt/python/
PYVER=${1:-38}
PYBIN=$(echo /opt/python/cp${PYVER}*/bin)

# We have to clean up the Pillow directories, otherwise we might get
# cached builds that are not manylinux wheel compatible
cd /Pillow
PATH=$PYBIN:$PATH make clean

# Build and repair
$PYBIN/pip --verbose wheel ${OPTS} -w /tmp /Pillow
$PYBIN/pip install "auditwheel<5"
$PYBIN/python3 -m auditwheel repair /tmp/Pillow*whl -w /output
