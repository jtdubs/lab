.PHONY: all clean vmware vbox

all:
	packer build --on-error=ask win10-workstation.json
	packer build --on-error=ask win10-workstation-vmware-box.json
	packer build --on-error=ask win10-workstation-virtualbox-box.json

clean:
	-vagrant box remove --all win10-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: win10-workstation-vmware.box

vbox: win10-workstation-virtualbox.box

output-vmware-vmx-phase1/win10-workstation-phase1.vmx: win10-workstation-phase1.json
	packer build --on-error=ask --only=vmware-vmx win10-workstation-phase1.json

output-vmware-vmx/win10-workstation.vmx: win10-workstation-phase2.json output-vmware-vmx-phase1/win10-workstation-phase1.vmx
	packer build --on-error=ask --only=vmware-vmx win10-workstation-phase2.json

output-virtualbox-ovf-phase1/win10-workstation-phase1.ovf: win10-workstation-phase1.json
	packer build --on-error=ask --only=virtualbox-ovf win10-workstation-phase1.json

output-virtualbox-ovf/win10-workstation.ovf: win10-workstation-phase2.json output-virtualbox-ovf-phase1/win10-workstation-phase1.ovf
	packer build --on-error=ask --only=virtualbox-ovf win10-workstation-phase2.json

win10-workstation-vmware.box: output-vmware-vmx/win10-workstation.vmx
	packer build --on-error=ask win10-workstation-vmware-box.json

win10-workstation-virtualbox.box: output-virtualbox-ovf/win10-workstation.ovf
	packer build --on-error=ask win10-workstation-virtualbox-box.json
