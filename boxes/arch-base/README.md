Arch Base
=========

Description
-----------
Creates a Arch VM in the following state:
- NTP: enabled
- Disk: 512MB boot, 2GB swap, rest is root
- Pacstrap: base, linux, linux-firmware
- Hostname: arch-base
- SSH: enabled
- Network: managed by NetworkManager
- User: vagrant / vagrant (setup for sudo w/ no password & ssh key installed)
- Guest Tools: installed and enabled

Does not install updates or any non-essential packages.

Makefile Targets
----------------
all - builds all virtualization targets
clean - deletes output folders and packer cache
(vmware | vbox | hyperv) - builds VM image for that virtualization target

Output
------
Does NOT build a Vagrant box.
Only output is VM images for reference from other packer scripts

Version
-------
2020-11-20 - 0.1 - Builds agsint archlinux-2020.11.01-x86_64.iso, with targets for vmware, virtualbox and hyperv

Method
------
- Boots and enables SSH by manual keying 'wget | bash' for srv/enable-ssh*.sh
- Bootstraps and copies install scripts into /mnt using scripts/bootstrap*.sh
- Configures /mnt using install*.sh in a systemd-nspawn chroot so that systemd is functional