.PHONY: all clean vmware vbox

all:
	packer build arch-workstation.json
	packer build arch-workstation-vmware-box.json
	packer build arch-workstation-virtualbox-box.json

clean:
	-vagrant box remove --all arch-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: arch-workstation-vmware.box

vbox: arch-workstation-virtualbox.box

output-vmware-vmx/arch-workstation.vmx: arch-workstation.json
	packer build --only=vmware-vmx arch-workstation.json

output-virtualbox-ovf/arch-workstation.ovf: arch-workstation.json
	packer build --only=virtualbox-ovf arch-workstation.json

arch-workstation-vmware.box: output-vmware-vmx/arch-workstation.vmx
	packer build arch-workstation-vmware-box.json

arch-workstation-virtualbox.box: output-virtualbox-ovf/arch-workstation.ovf
	packer build arch-workstation-virtualbox-box.json
