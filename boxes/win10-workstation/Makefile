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

output-vmware-vmx/win10-workstation.vmx: win10-workstation.json
	packer build --on-error=ask --only=vmware-vmx win10-workstation.json

output-virtualbox-ovf/win10-workstation.ovf: win10-workstation.json
	packer build --on-error=ask --only=virtualbox-ovf win10-workstation.json

win10-workstation-vmware.box: output-vmware-vmx/win10-workstation.vmx
	packer build --on-error=ask win10-workstation-vmware-box.json

win10-workstation-virtualbox.box: output-virtualbox-ovf/win10-workstation.ovf
	packer build --on-error=ask win10-workstation-virtualbox-box.json
