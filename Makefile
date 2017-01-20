

TARGETS = alpine ubuntu-precise-amd64 ubuntu-trusty-x86 ubuntu-xenial-amd64
BUILDDIRS = $(TARGETS:%=build-%)
PUSHDIRS = $(TARGETS:%=push-%)
UPDATEDIRS = $(TARGETS:%=update-%)
CLEANDIRS = $(TARGETS:%=clean-%)

.PHONY: build update push test $(TARGETS)
.PHONY: subdirs $(BUILDDIRS)
.PHONY: subdirs $(PUSHDIRS)
.PHONY: subdirs $(UPDATEDIRS)
.PHONY: subdirs $(CLEANDIRS)

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
test:
	for target in $(TARGETS); do \
	  $(MAKE) -C $$target test; \
	done

# individual -- make alpine will do one.
$(TARGETS):
	$(MAKE) -C $@ 
