#!/bin/bash

set -e

build_uroot() {
    set -x
    cd $GOPATH/src/github.com/u-root/u-root
    go build
    ./u-root -format=cpio -build=bb -o $HOME/linux/smaller.cpio ./cmds/{c*,l*,mount,ip,dhclient,wget,kexec,pci,dmesg,shutdown,boot,rush}
    cd $HOME/linux
    lzma -f -9 smaller.cpio
}

build_linux() {
    set -x
    cd $HOME/linux
    cp /vagrant/linux_config .config
    rm -f arch/x86/boot/bzImage
    ARCH=x86_64 make -j 2 bzImage
    cp arch/x86/boot/bzImage /vagrant/nerf-kernel.bin
}

build_ffs() {
    set -x

    cd $HOME/linux

    GenSec -o pe32.sec arch/x86/boot/bzImage -S EFI_SECTION_PE32
    GenSec -o name.sec -S EFI_SECTION_USER_INTERFACE -n "NERF" 
    GenSec -o ver.sec -S EFI_SECTION_VERSION -n "1.0" 

    wget https://github.com/nerfirmware/NERF/raw/master/blobs/ocp-winterfell-linux-DMACPIdep.sec

    rm -f $HOME/linux/linux.ffs /vagrant/linux.ffs

    GenFfs -g "B1DA0ADF-4F77-4070-A88E-BFFE1C60529A" -o nerf.ffs \
        -i pe32.sec -i name.sec -i ver.sec -i ocp-winterfell-linux-DMACPIdep.sec \
        -t EFI_FV_FILETYPE_DRIVER

    mv $HOME/linux/nerf.ffs /vagrant
    ls -l /vagrant/nerf.ffs
}

build() {
    set -x
    build_uroot
    build_linux
    build_ffs
}

exit_on_error() {
    echo "Error..."
    echo "Usage: nerf-build u-root|linux|ffs"
    exit 1
}

success() {
    set +x
    echo -e "\n### Success ###\n"
    exit 0
}

if [ $# -gt 1 ] ; then
    exit_on_error
fi 

if [ $# -eq 0 ] ; then
    build
    success
fi 

case $1 in
    u-root)
        build_uroot
    ;;
    linux)
        build_linux
    ;;
    ffs)
        build_ffs
    ;;
    *)
        exit_on_error
    ;;
esac

success
