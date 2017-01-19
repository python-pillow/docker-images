.PHONY=update build

build:
	docker build -t pythonpillow/ubuntu-trusty-x86 .

update:
	rm ubuntu-trusty-core-cloudimg-i386-root.tar.gz
	wget 'https://partner-images.canonical.com/core/trusty/current/ubuntu-trusty-core-cloudimg-i386-root.tar.gz'


