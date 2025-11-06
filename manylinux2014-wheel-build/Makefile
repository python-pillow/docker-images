WD = $(shell pwd)
TARGET := $(notdir $(WD))
ROOT := $(abspath $(WD)/../Pillow)
IMAGENAME := $(if $(DOCKER_USERNAME), $(DOCKER_USERNAME)/$(TARGET), $(TARGET))
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
TEST_TARGET = fedora-43-amd64
TEST_IMAGE := $(if $(DOCKER_USERNAME), $(DOCKER_USERNAME)/$(TEST_TARGET):$(BRANCH), pythonpillow/$(TEST_TARGET):main)

.PHONY: build
build:
	cp -r ../Pillow .
	docker build -t $(IMAGENAME):$(BRANCH) .

.PHONY: update
update:
	./update.sh

.PHONY: wheel
wheel:
	-[ ! -d out ] && mkdir out
	docker run --rm -v $(ROOT):/Pillow -v `pwd`/out:/output $(IMAGENAME):$(BRANCH) /build.sh $(_PYVER)

310:
	_PYVER=310 $(MAKE) wheel
311:
	_PYVER=311 $(MAKE) wheel
312:
	_PYVER=312 $(MAKE) wheel
313:
	_PYVER=313 $(MAKE) wheel
314:
	_PYVER=314 $(MAKE) wheel

.PHONY: test
test: 314
	docker run --rm -v $(ROOT):/Pillow -v `pwd`/out:/output $(TEST_IMAGE) sh -c ". /vpy3/bin/activate && python3 -m pip install /output/*cp314-manylinux2014_x86_64.manylinux_2_17_x86_64.whl && cd /Pillow && python3 selftest.py && /usr/bin/xvfb-run -a .ci/test.sh"

.PHONY: push
push:
	docker push $(IMAGENAME):$(BRANCH)

.PHONY: clean
clean:
	-rm -r out

.PHONY: shell
shell:
	docker run --rm -it -v $(ROOT):/Pillow $(IMAGENAME):$(BRANCH) /bin/bash

