.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask kali-workstation-phase1.json
	packer build --on-error=ask kali-workstation-phase2.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-vmx
	-$(RM) output-virtualbox-ovf
	-$(RM) output-hyperv-vmcx
	-$(RM) output-hyperv-vmcx-phase1
	-$(RM) *.box

vmware: kali-workstation-vmware.box

vbox: kali-workstation-virtualbox.box

hyperv: kali-workstation-hyperv.box

kali-workstation-vmware.box: kali-workstation-phase1.json
	packer build --on-error=ask --only=vmware-vmx kali-workstation-phase1.json

kali-workstation-virtualbox.box: kali-workstation-phase1.json
	packer build --on-error=ask --only=virtualbox-ovf kali-workstation-phase1.json

kali-workstation-hyperv.box: kali-workstation-phase1.json kali-workstation-phase2.json
	packer build --on-error=ask --only=hyperv-vmcx kali-workstation-phase1.json
	packer build --on-error=ask --only=hyperv-vmcx kali-workstation-phase2.json