.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask win10-workstation.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-vmx
	-$(RM) output-virtualbox-ovf
	-$(RM) output-hyperv-vmcx
	-$(RM) *.box

vmware: win10-workstation-vmware.box

vbox: win10-workstation-virtualbox.box

hyperv: win10-workstation-hyperv.box

win10-workstation-vmware.box: win10-workstation.json
	packer build --on-error=ask --only=vmware-vmx win10-workstation.json

win10-workstation-virtualbox.box: win10-workstation.json
	packer build --on-error=ask --only=virtualbox-ovf win10-workstation.json

win10-workstation-hyperv.box: win10-workstation.json
	packer build --on-error=ask --only=hyperv-vmcx win10-workstation.json