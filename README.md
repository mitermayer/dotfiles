dotfiles
========

This is a set of tools and helpers to get started with a new Linux Laptop.
The support for DEBIAN has been phased out in favour to using gentoo, and will no
longer be maintained.

Will keep the old `./scripts.sh` which supported the debian install.

For gentoo users will have a copy of my make.conf (As you know that will need to be adapted depending on the hardware of the installation but should provide a good base). Will keep a copy of portage `/etc/portage/make.conf` as well as a copy of `/var/lib/portage/world`

### Installing

#### Debian

For installing on debian run

```./scripts.sh```

#### Gentoo

The profile used by the system is the "hardened" profile, therefor some of the USE tags are already provided.

Follow the gentoo installation guidelines, this repo will only keep a list of USE flags and emerged packages, will not keep a list of firmware or hardware specific requirements. Will also not keep any information in regards to KERNEL building. Please use the gentoo wiki for those
