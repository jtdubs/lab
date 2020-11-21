Kali Base
=========

Description
-----------
Creates a Kali VM in the following state:
- NTP: enabled
- Disk: Standard
- Hostname: kali-base
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
* 2020-11-20 - 0.1 - Builds agsint kali-linux-2020-W47-installer.amd64.iso, with targets for vmware, virtualbox and hyperv

Method
------
- Automated install using preseed