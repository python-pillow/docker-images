WD = $(shell pwd)
USERNAME := $(shell docker info | grep Username | xargs | cut -d ' ' -f 2)
TARGET := $(notdir $(WD))
ROOT := $(abspath $(WD)/../Pillow)
IMAGENAME := $(if $(USERNAME), $(USERNAME)/$(TARGET), $(TARGET))
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: build
build:
	cp -r ../Pillow/depends .
	cp test.sh depends
	docker build -t $(IMAGENAME):$(BRANCH) .

.PHONY: update
update:
	./update.sh

.PHONY: test
test:
	docker run --rm -e "PILLOW_VALGRIND_TEST=true" -v $(ROOT):/Pillow $(IMAGENAME):$(BRANCH)

.PHONY: push
push:
	docker push $(IMAGENAME):$(BRANCH)

.PHONY: clean
clean:
	rm -r depends

.PHONY: shell
shell:
	docker run --rm -it -v $(ROOT):/Pillow $(IMAGENAME):$(BRANCH) /bin/bash

build-dbg:
	docker build -t $(IMAGENAME)-dbg:$(BRANCH) -f Dockerfile-dbg .

dbg:
	docker run --privileged --rm -it -v $(ROOT):/Pillow $(IMAGENAME)-dbg:$(BRANCH)


