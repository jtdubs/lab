Arch Updated
============

Description
-----------
Applies all updates to Arch Base VM, and installs paru package manager.

Makefile Targets
----------------
all - builds all virtualization targets
clean - deletes output folders and packer cache
(vmware | vbox | hyperv) - builds VM image for that virtualization target

Output
------
Vagrant Box

Version
-------
2020-11-20 - 0.1 - Targets for vmware, virtualbox and hyperv

Method
------
- Boots VM and installs updates over ssh