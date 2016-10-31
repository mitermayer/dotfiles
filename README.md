dotfiles
========

This is a set of tools and helpers to get started with a new Linux Laptop.

The support for DEBIAN has been phased out in favour to gentoo, and will no
longer be maintained.

For gentoo users will have a copy of my make.conf (As you know that will need to be adapted depending on the hardware of the installation but should provide a good base). Will keep a copy of portage `/etc/portage/make.conf` as well as a copy of `/var/lib/portage/world`

### Installing

#### Debian

For installing on debian run

```./install-debian.sh```

#### Gentoo

Follow the gentoo installation guidelines, this repo will only keep a list of USE flags and emerged packages, will not keep a list of firmware or hardware specific requirements.

For installing on gentoo run

```./install-gentoo.sh```

