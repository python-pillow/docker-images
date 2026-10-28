#!/bin/sh
sudo sysctl vm.mmap_rnd_bits=28
docker pull ghcr.io/nascheme/cpython-tsan:3.14t
