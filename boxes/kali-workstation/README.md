Kali Workstation
================

Description
-----------
Prepares a Justin-specific Kali workstation.
Installs window manager, tools, dot files, etc.

Makefile Targets
----------------
* all - builds all virtualization targets
* clean - deletes output folders and packer cache
* (vmware | vbox | hyperv) - builds VM image for that virtualization target

Output
------
Vagrant Box

Version
-------
* 2020-11-20 - 0.1 - Targets for vmware, virtualbox and hyperv

Method
------
- Boots VM and installs software and tools over ssh