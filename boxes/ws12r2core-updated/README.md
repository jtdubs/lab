WS12R2 Core Updated
===================

Description
-----------
Applies all pending Windows Updates to WS12R2 Core Base, and installs VM tools.

Makefile Targets
----------------
* all - builds all virtualization targets
* clean - deletes output folders and packer cache
* (vmware | vbox | hyperv) - builds VM image for that virtualization target

Output
------
* Vagrant Box

Version
-------
* 2020-11-27 - 0.1 - Targets for vmware, virtualbox and hyperv

Method
------
- Remote powershell, using PSWindowsUpdate for updates