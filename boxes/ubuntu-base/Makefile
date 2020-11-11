.PHONY: all clean vmware vbox

all:
	packer build --on-error=ask ubuntu-base.json
	packer build --on-error=ask ubuntu-base-vmware-box.json
	packer build --on-error=ask ubuntu-base-virtualbox-box.json

clean:
	-vagrant box remove --all ubuntu-base
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

vmware: ubuntu-base-vmware.box

vbox: ubuntu-base-virtualbox.box

output-vmware-iso/ubuntu-base.vmx: ubuntu-base.json
	packer build --on-error=ask --only=vmware-iso ubuntu-base.json

output-virtualbox-iso/ubuntu-base.ovf: ubuntu-base.json
	packer build --on-error=ask --only=virtualbox-iso ubuntu-base.json

ubuntu-base-vmware.box: output-vmware-iso/ubuntu-base.vmx
	packer build --on-error=ask ubuntu-base-vmware-box.json

ubuntu-base-virtualbox.box: output-virtualbox-iso/ubuntu-base.ovf
	packer build --on-error=ask ubuntu-base-virtualbox-box.json
