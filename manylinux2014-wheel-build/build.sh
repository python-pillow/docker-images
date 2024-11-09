#!/bin/sh -eu

# options required to trigger the vendored Raqm install
OPTS="-C raqm=vendor -C fribidi=vendor"

CFLAGS=${CFLAGS:-}
export CFLAGS="$CFLAGS --std=c99"

# Check for debug build
DEBUG=${DEBUG:-0}
if [ $DEBUG ]; then
    OPTS="-C debug=true $OPTS"
    CFLAGS="$CFLAGS -Og -DDEBUG"
fi

# not strictly necessary, unless running multiple versions from the shell
rm -f /tmp/*.whl || true

# Python version, as 39,310,311,312,313. Defaults to 313.
# Matches the naming in /opt/python/
PYVER=${1:-313}
PYBIN=$(echo /opt/python/cp${PYVER}-cp${PYVER}/bin)

# We have to clean up the Pillow directories, otherwise we might get
# cached builds that are not manylinux wheel compatible
cd /Pillow
PATH=$PYBIN:$PATH make clean

# Build and repair
$PYBIN/pip --verbose wheel ${OPTS} -w /tmp /Pillow
$PYBIN/pip install auditwheel
$PYBIN/python3 -m auditwheel repair /tmp/pillow*whl -w /output
