WD = $(shell pwd)
USERNAME := $(shell docker info | grep Username | xargs | cut -d ' ' -f 2)
TARGET := $(notdir $(WD))
ROOT := $(abspath $(WD)/../Pillow)
IMAGENAME := $(if $(USERNAME), $(USERNAME)/$(TARGET), $(TARGET))
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
TEST_TARGET = ubuntu-20.04-focal-amd64
TEST_IMAGE=pythonpillow/$(TEST_TARGET)
.PHONY: build
build:
	docker build -t $(IMAGENAME):$(BRANCH) .

.PHONY: update
update:
	./update.sh

.PHONY: wheel
wheel:
	-[ ! -d out ] && mkdir out
	docker run --rm -v $(ROOT):/Pillow -v `pwd`/out:/output $(IMAGENAME):$(BRANCH) /build.sh $(_PYVER)

37:
	_PYVER=37 $(MAKE) wheel
38:
	_PYVER=38 $(MAKE) wheel
39:
	_PYVER=39 $(MAKE) wheel
310:
	_PYVER=310 $(MAKE) wheel
311:
	_PYVER=311 $(MAKE) wheel

.PHONY: test
test: 38
	docker run --rm -v $(ROOT):/Pillow -v `pwd`/out:/output $(TEST_IMAGE):$(BRANCH) sh -c "/vpy3/bin/pip install /output/*cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl && cd /Pillow && /vpy3/bin/python selftest.py && /usr/bin/xvfb-run -a /vpy3/bin/pytest -vx"

.PHONY: push
push:
	docker push $(IMAGENAME):$(BRANCH)

.PHONY: clean
clean:
	-rm -r out

.PHONY: shell
shell:
	docker run --rm -it -v $(ROOT):/Pillow $(IMAGENAME):$(BRANCH) /bin/bash

