.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask arch-workstation.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv
	-$(RM) *.box

vmware: arch-workstation-vmware.box

vbox: arch-workstation-virtualbox.box

hyperv: arch-workstation-hyperv.box

arch-workstation-vmware.box: arch-workstation.json
	packer build --on-error=ask --only=vmware-vmx --force arch-workstation.json

arch-workstation-virtualbox.box: arch-workstation.json
	packer build --on-error=ask --only=virtualbox-ovf --force arch-workstation.json

arch-workstation-hyperv.box: arch-workstation.json
	packer build --on-error=ask --only=hyperv-vmcx --force arch-workstation.json
