# NERF Winterfell

NERF Firmware development environment for winterfell build.

# Prerequisites

You need [Vagrant](https://www.vagrantup.com/) and [Vitualbox](https://www.virtualbox.org/) in order to setup your development environment.

# Environment setup

Basically run

```bash
$ vagrant up
```

That's it !

# Build the firmware

Run the build script into the vagrant VM

```
$ vagrant ssh nerf-build
```

Output FFS file is available in the repository home directory

To build u-root only

```
$ vagrant ssh nerf-build u-root
```

To build Linux kernel only

```
$ vagrant ssh nerf-build linux
```

To build NERF fss only

```
$ vagrant ssh nerf-build ffs
```

# Run Linux kernel in QEMU

Basically run

```
$ nerf-qemu
```
