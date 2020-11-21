Ubuntu Base
===========

Description
-----------
Creates an Ubuntu VM in the following state:
- NTP: enabled
- Disk: Automatic
- Hostname: ubuntu-base
- SSH: enabled
- User: vagrant / vagrant (setup for sudo w/ no password & ssh key installed)
- Guest Tools: installed and enabled

Does not install updates or any non-essential packages.

Makefile Targets
----------------
* all - builds all virtualization targets
* clean - deletes output folders and packer cache
* (vmware | vbox | hyperv) - builds VM image for that virtualization target

Output
------
* Does NOT build a Vagrant box.
* Only output is VM images for reference from other packer scripts

Version
-------
* 2020-11-20 - 0.1 - Builds agsint archlinux-2020.11.01-x86_64.iso, with targets for vmware, virtualbox and hyperv

Method
------
- Performs autoinstall using kernel parameters to point installer to local HTTP server