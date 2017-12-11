# NERF Winterfell

NERF Firmware development environment for Winterfell.

## Prerequisites

You need [Vagrant](https://www.vagrantup.com/) and [Vitualbox](https://www.virtualbox.org/) in order to setup your development environment.

## Environment setup

Basically run

```bash
$ vagrant up
```

That's it !

## Build the firmware

SSH into the machine

```
$ vagrant ssh
```

Run the build script

```
$ nerf-build
```

built Linux kernel and FFS files are available in the repository home directory

To build u-root only

```
$ nerf-build u-root
```

To build Linux kernel only

```
$ nerf-build linux
```

To build NERF fss only

```
$ nerf-build ffs
```

## Run Linux kernel in QEMU

Into the vagrant machine, run

```
$ nerf-qemu
```
