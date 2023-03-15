TARGETS = \
	alpine \
	amazon-2-amd64 \
	arch \
	centos-7-amd64 \
	centos-stream-8-amd64 \
	centos-stream-9-amd64 \
	debian-11-bullseye-x86 \
	fedora-36-amd64 \
	fedora-37-amd64 \
	gentoo \
	manylinux2014-wheel-build \
	ubuntu-18.04-bionic-amd64 \
	ubuntu-20.04-focal-amd64 \
	ubuntu-22.04-jammy-amd64 \
	ubuntu-22.04-jammy-amd64-valgrind \
	ubuntu-22.04-jammy-arm64v8 \
	ubuntu-22.04-jammy-ppc64le \
	ubuntu-22.04-jammy-s390x

BUILDDIRS = $(TARGETS:%=build-%)
PUSHDIRS = $(TARGETS:%=push-%)
PULLDIRS = $(TARGETS:%=pull-%)
UPDATEDIRS = $(TARGETS:%=update-%)
CLEANDIRS = $(TARGETS:%=clean-%)
TESTDIRS = $(TARGETS:%=test-%)

.PHONY: build update push test $(TARGETS)
.PHONY: subdirs $(BUILDDIRS)
.PHONY: subdirs $(PUSHDIRS)
.PHONY: subdirs $(PULLDIRS)
.PHONY: subdirs $(UPDATEDIRS)
.PHONY: subdirs $(CLEANDIRS)
.PHONY: subdirs $(TESTDIRS)

# these are parallelizable, but mind the load
build: $(BUILDDIRS)
$(BUILDDIRS):
	$(MAKE) -C $(@:build-%=%) build

push: $(PUSHDIRS)
$(PUSHDIRS):
	$(MAKE) -C $(@:push-%=%) push

pull: $(PULLDIRS)
$(PULLDIRS):
	$(MAKE) -C $(@:pull-%=%) pull

update: $(UPDATEDIRS)
$(UPDATEDIRS):
	$(MAKE) -C $(@:update-%=%) update

clean: $(CLEANDIRS)
$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean


# This has to be sequential due to the shared
# pillow data/build directory
test: $(TESTDIRS)
$(TESTDIRS):
	$(MAKE) -C $(@:test-%=%) test

# individual -- make alpine will do one.
$(TARGETS):
	$(MAKE) -C $@
