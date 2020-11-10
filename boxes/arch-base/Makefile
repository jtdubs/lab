.PHONY: all clean vmware vbox

all:
	packer build arch-base.json
	packer build arch-base-vmware-box.json
	packer build arch-base-virtualbox-box.json

clean:
	-vagrant box remove --all arch-base
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

vmware: arch-base-vmware.box

vbox: arch-base-virtualbox.box

output-vmware-iso/arch-base.vmx: arch-base.json
	packer build --only=vmware-iso arch-base.json

output-virtualbox-iso/arch-base.ovf: arch-base.json
	packer build --only=virtualbox-iso arch-base.json

arch-base-vmware.box: output-vmware-iso/arch-base.vmx
	packer build arch-base-vmware-box.json

arch-base-virtualbox.box: output-virtualbox-iso/arch-base.ovf
	packer build arch-base-virtualbox-box.json
