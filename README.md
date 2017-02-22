# Docker Images for the Pillow Test Infrastructure

[![Build Status](https://travis-ci.org/python-pillow/docker-images.svg?branch=master)](https://travis-ci.org/python-pillow/docker-images)

## Getting Started

The makefiles rely on being logged into to [Docker Hub](https://hub.docker.com) to properly scope
the image tag. 

```bash
git clone https://github.com/python-pillow/docker-images.git
cd docker-images
git submodule init
git submodule update
# update all the base images
make update
# build all of the test images
make build
# build and run the test suite on all the images
make test
# Push to Docker Hub
make push
```

## Building Individual Environments

All the makefile commands work in the individual directories.

```bash
cd alpine && make update && make && make test
```

If a shell would be useful in the environment, `make shell` will start
the container with bash.

## Adding New Environments

- Make a new directory for the platform
- `ln -s ../Makefile.sub Makefile`
- Write a simple update script to install the original image.
- Write/customize a Docker file. The convention is that the Pillow directory will be mounted at `/Pillow`, and the test script will run as the `pillow` user. Sudo is not available at test time. 

