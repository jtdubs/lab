.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask arch-interactive-xorg.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv
	-$(RM) *.box

vmware: arch-interactive-xorg-vmware.box

vbox: arch-interactive-xorg-virtualbox.box

hyperv: arch-interactive-xorg-hyperv.box

arch-interactive-xorg-vmware.box: arch-interactive-xorg.json
	packer build --on-error=ask --only=vmware-vmx --force arch-interactive-xorg.json

arch-interactive-xorg-virtualbox.box: arch-interactive-xorg.json
	packer build --on-error=ask --only=virtualbox-ovf --force arch-interactive-xorg.json

arch-interactive-xorg-hyperv.box: arch-interactive-xorg.json
	packer build --on-error=ask --only=hyperv-vmcx --force arch-interactive-xorg.json
