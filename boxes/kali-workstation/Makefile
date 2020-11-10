.PHONY: all clean vmware vbox

all:
	packer build kali-workstation.json
	packer build kali-workstation-vmware-box.json
	packer build kali-workstation-virtualbox-box.json

clean:
	-vagrant box remove --all kali-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: kali-workstation-vmware.box

vbox: kali-workstation-virtualbox.box

output-vmware-vmx/kali-workstation.vmx: kali-workstation.json
	packer build --only=vmware-vmx kali-workstation.json

output-virtualbox-ovf/kali-workstation.ovf: kali-workstation.json
	packer build --only=virtualbox-ovf kali-workstation.json

kali-workstation-vmware.box: output-vmware-vmx/kali-workstation.vmx
	packer build kali-workstation-vmware-box.json

kali-workstation-virtualbox.box: output-virtualbox-ovf/kali-workstation.ovf
	packer build kali-workstation-virtualbox-box.json
