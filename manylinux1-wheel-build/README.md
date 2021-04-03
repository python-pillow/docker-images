# Wheel Builder image

This image is a little different than the other images in this repo --
it's intended to be a quick way to build manylinux wheels with the
production version of the libraries for debugging and testing
purposes. This is designed to work as a single docker image that
doesn't require privilege or multiple images to run.

Like the other images in this repo, it expects that there is a Pillow
source directory mounted at /Pillow. Unlike the others, it puts the
output files in /output. This should be mounted as a volume to the host
to retrieve the finished wheel.

The Makefile has several new commands:

* make wheel: Makes a python 3.8 many linux wheel, and puts it in the
./out directory.
* make 36|37|38|39: These are specific commands to make
the corresponding 3.x version in the ./out directory.

The test target here is mainly to validate the image build, it is
assumed that the builds will be used for other purposes or tested in
other images. .


# Sources

* build_depends is from our integration with oss-fuzz
* yum_install is syntactic sugar to make the multibuild repo work with
  the base manylinux wheel image, rather than with it's custom set of
  images

