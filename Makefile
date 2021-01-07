TARGETS = \
	alpine \
	amazon-2-amd64 \
	arch \
	centos-7-amd64 \
	centos-8-amd64 \
	debian-10-buster-x86 \
	fedora-32-amd64 \
	fedora-33-amd64 \
	ubuntu-18.04-bionic-amd64 \
	ubuntu-20.04-focal-amd64 \
	ubuntu-20.04-focal-amd64-valgrind

BUILDDIRS = $(TARGETS:%=build-%)
PUSHDIRS = $(TARGETS:%=push-%)
UPDATEDIRS = $(TARGETS:%=update-%)
CLEANDIRS = $(TARGETS:%=clean-%)
TESTDIRS = $(TARGETS:%=test-%)

.PHONY: build update push test $(TARGETS)
.PHONY: subdirs $(BUILDDIRS)
.PHONY: subdirs $(PUSHDIRS)
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
