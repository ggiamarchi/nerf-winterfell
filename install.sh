#!/bin/bash

#sudo su -

set -ex

# Install some needed packages

sudo apt update
sudo apt install -y bc build-essential lzma git mercurial uuid-dev iasl git gcc-5 nasm git mercurial

# Install Go

sudo rm -rf /usr/local/go $HOME/gopath
wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz 2>/dev/null
sudo tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
mkdir -p $HOME/gopath
echo 'export GOROOT=/usr/local/go'   >> ~/.bashrc
echo 'export GOPATH=$HOME/gopath'    >> ~/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.bashrc

export GOROOT=/usr/local/go
export GOPATH=$HOME/gopath
export PATH=$PATH:$GOROOT/bin

# Get u-root sources

go get github.com/u-root/u-root

# Get linux kernel sources

git clone --depth 1 https://github.com/nerfirmware/linux.git $HOME/linux

# Get sources for isci firmware

git clone git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git $HOME/linux-firmware

# Build tiancore/edk2

mkdir -p $HOME/src
git clone --depth 1 https://github.com/nerfirmware/edk2.git $HOME/src/MyWorkspace
git clone -b OpenSSL_1_1_0e https://github.com/openssl/openssl \
             $HOME/src/MyWorkspace/CryptoPkg/Library/OpensslLib/openssl

cd $HOME/src/MyWorkspace
make -C BaseTools

. edksetup.sh
build -p MdeModulePkg/MdeModulePkg.dsc -t GCC5

echo 'export PATH=$PATH:$HOME/src/MyWorkspace/BaseTools/Source/C/bin' >> ~/.bashrc

export PATH=$PATH:$HOME/src/MyWorkspace/BaseTools/Source/C/bin

# Link build script in path

sudo ln -s /vagrant/nerf-build.sh /usr/local/bin/nerf-build
sudo ln -s /vagrant/nerf-qemu.sh /usr/local/bin/nerf-qemu
