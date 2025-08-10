#!/bin/bash -x
### Build a root fs source for docker for debian amd64.

set -e

### settings
arch=amd64
suite="trixie"
chroot_dir="./guest-root"
apt_mirror="http://http.debian.net/debian"

sudo mkdir $chroot_dir

### install a minbase system with debootstrap
export DEBIAN_FRONTEND=noninteractive
sudo debootstrap --arch $arch $suite $chroot_dir $apt_mirror

### update the list of package sources
sudo sh -c "cat <<EOF > $chroot_dir/etc/apt/sources.list
deb $apt_mirror $suite main contrib non-free
deb $apt_mirror $suite-updates main contrib non-free
deb http://security.debian.org/ $suite-security main contrib non-free
EOF"

### upgrade packages
sudo chroot $chroot_dir apt-get update
sudo chroot $chroot_dir apt-get upgrade -y

### cleanup
sudo chroot $chroot_dir apt-get autoclean
sudo chroot $chroot_dir apt-get clean
sudo chroot $chroot_dir apt-get autoremove

### create a tar archive from the chroot directory
sudo tar cz -C $chroot_dir . >  debian-$suite-$arch.tgz

### cleanup
sudo rm -rf $chroot_dir
