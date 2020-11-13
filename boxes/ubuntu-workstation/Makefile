.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask ubuntu-workstation-phase1.json
	packer build --on-error=ask ubuntu-workstation-phase2.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-vmx
	-$(RM) output-virtualbox-ovf
	-$(RM) output-hyperv-vmcx
	-$(RM) *.box

vmware: ubuntu-workstation-vmware.box

vbox: ubuntu-workstation-virtualbox.box

hyperv: ubuntu-workstation-hyperv.box

ubuntu-workstation-vmware.box: ubuntu-workstation-phase1.json
	packer build --on-error=ask --only=vmware-vmx ubuntu-workstation-phase2.json

ubuntu-workstation-virtualbox.box: ubuntu-workstation-phase1.json
	packer build --on-error=ask --only=virtualbox-ovf ubuntu-workstation-phase1.json

ubuntu-workstation-hyperv.box: ubuntu-workstation-phase1.json ubuntu-workstation-phase2.json
	packer build --on-error=ask --only=hyperv-vmcx ubuntu-workstation-phase1.json
	packer build --on-error=ask --only=hyperv-vmcx ubuntu-workstation-phase2.json