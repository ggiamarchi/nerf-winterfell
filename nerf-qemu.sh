#!/bin/bash

set -ex

qemu-system-x86_64 -kernel $HOME/linux/arch/x86/boot/bzImage \
                   -serial /dev/tty -nographic -monitor /dev/null -m 512
