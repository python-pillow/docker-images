TARGETS = \
	alpine \
	amazon-2023-amd64 \
	arch \
	centos-stream-9-amd64 \
	centos-stream-10-amd64 \
	debian-12-bookworm-x86 \
	debian-12-bookworm-amd64 \
	debian-13-trixie-x86 \
	debian-13-trixie-amd64 \
	fedora-42-amd64 \
	fedora-43-amd64 \
	gentoo \
	manylinux_2_28-wheel-build \
	ubuntu-22.04-jammy-amd64 \
	ubuntu-24.04-noble-amd64 \
	ubuntu-22.04-jammy-amd64-valgrind \
	ubuntu-24.04-noble-arm64v8 \
	ubuntu-24.04-noble-ppc64le \
	ubuntu-24.04-noble-s390x

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
