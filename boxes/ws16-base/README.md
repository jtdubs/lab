Win Server 2016 Base
====================

Description
-----------
Creates a WS2016 VM in the following state:
- NTP: enabled
- Disk: 250MB Recovery, 100MB EFI, 128MB ESR, rest is SYSTEM
- Hostname: ws19-base
- WinRM: enabled
- RDP: enabled
- User: vagrant / vagrant
- Guest Tools: NOT installed

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
* 2020-11-20 - 0.1 - Targets for vmware, virtualbox and hyperv

Method
------
- Unattended install