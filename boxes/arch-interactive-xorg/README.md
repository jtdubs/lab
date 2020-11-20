Arch Interactive (xorg)
=======================

Description
-----------
Prepares Arch VM to be interactive, including video and audio.
Install xorg and pulseaudio, as well ad additional VM guest tools.
Installs man pages.
Enables xsession support.

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
- Boots VM and installs:
  - xorg, xorg drivers
  - man pages
- Enables the LightDM display manager