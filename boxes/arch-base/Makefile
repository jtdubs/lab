.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build arch-base.json"
	cmd.exe /c "packer build arch-base-vmware-box.json"
	cmd.exe /c "packer build arch-base-virtualbox-box.json"

clean:
	packer box remove --all arch-base
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

vmware: arch-base-vmware.box

vbox: arch-base-virtualbox.box

output-vmware-iso/arch-base.vmx: arch-base.json
	cmd.exe /c "packer build --only=vmware-iso arch-base.json"

output-virtualbox-iso/arch-base.ovf: arch-base.json
	cmd.exe /c "packer build --only=virtualbox-iso arch-base.json"

arch-base-vmware.box: output-vmware-iso/arch-base.vmx
	cmd.exe /c "packer build arch-base-vmware-box.json"

arch-base-virtualbox.box: output-virtualbox-iso/arch-base.ovf
	cmd.exe /c "packer build arch-base-virtualbox-box.json"
