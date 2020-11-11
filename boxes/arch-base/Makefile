.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask arch-base.json

clean:
	-vagrant box remove --all arch-base --provider vmware_desktop
	-vagrant box remove --all arch-base --provider virtualbox
	-vagrant box remove --all arch-base --provider hyperv
	-$(RM) packer_cache
	-$(RM) output-vmware-iso
	-$(RM) output-virtualbox-iso
	-$(RM) output-hyperv-iso
	-$(RM) *.box

vmware: arch-base-vmware.box

vbox: arch-base-virtualbox.box

hyperv: arch-base-hyperv.box

arch-base-vmware.box: arch-base.json
	packer build --on-error=ask --only=vmware-iso arch-base.json

arch-base-virtualbox.box: arch-base.json
	packer build --on-error=ask --only=virtualbox-iso arch-base.json

arch-base-hyperv.box: arch-base.json
	packer build --on-error=ask --only=hyperv-iso arch-base.json
