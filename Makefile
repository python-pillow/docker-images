TARGETS = alpine arch amazon-1-amd64 amazon-2-amd64 ubuntu-14.04-trusty-x86 ubuntu-16.04-xenial-amd64 ubuntu-18.04-bionic-amd64 debian-stretch-x86 fedora-28-amd64 fedora-29-amd64 centos-6-amd64 centos-7-amd64


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
