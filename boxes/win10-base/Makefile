.PHONY: all clean vmware vbox null

all:
	packer build --on-error=ask win10-base.json
	packer build --on-error=ask win10-base-vmware-box.json
	packer build --on-error=ask win10-base-virtualbox-box.json

clean:
	-vagrant box remove --all win10-base --provider vmware_desktop
	-vagrant box remove --all win10-base --provider virtualbox
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

tools/virtualbox-tools.iso:
	cp /mnt/c/Program\ Files/Oracle/VirtualBox/VBoxGuestAdditions.iso tools/virtualbox-tools.iso

tools/vmware-tools.iso:
	cp /mnt/c/Program\ Files\ \(x86\)/VMware/VMware\ Workstation/windows.iso tools/vmware-tools.iso 

vmware: win10-base-vmware.box

vbox: win10-base-virtualbox.box

output-vmware-iso/win10-base.vmx: win10-base.json tools/vmware-tools.iso
	packer build --on-error=ask --only=vmware-iso win10-base.json

output-virtualbox-iso/win10-base.ovf: win10-base.json tools/virtualbox-tools.iso
	packer build --on-error=ask --only=virtualbox-iso win10-base.json

win10-base-vmware.box: output-vmware-iso/win10-base.vmx
	packer build --on-error=ask win10-base-vmware-box.json

win10-base-virtualbox.box: output-virtualbox-iso/win10-base.ovf
	packer build --on-error=ask win10-base-virtualbox-box.json
