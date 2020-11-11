.PHONY: all clean vmware vbox

all:
	packer build --on-error=ask arch-workstation.json
	packer build --on-error=ask arch-workstation-vmware-box.json
	packer build --on-error=ask arch-workstation-virtualbox-box.json

clean:
	-vagrant box remove --all arch-workstation --provider vmware_desktop
	-vagrant box remove --all arch-workstation --provider virtualbox
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: arch-workstation-vmware.box

vbox: arch-workstation-virtualbox.box

output-vmware-vmx/arch-workstation.vmx: arch-workstation.json
	packer build --on-error=ask --only=vmware-vmx arch-workstation.json

output-virtualbox-ovf/arch-workstation.ovf: arch-workstation.json
	packer build --on-error=ask --only=virtualbox-ovf arch-workstation.json

arch-workstation-vmware.box: output-vmware-vmx/arch-workstation.vmx
	packer build --on-error=ask arch-workstation-vmware-box.json

arch-workstation-virtualbox.box: output-virtualbox-ovf/arch-workstation.ovf
	packer build --on-error=ask arch-workstation-virtualbox-box.json
