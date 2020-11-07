.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build arch-workstation.json"
	cmd.exe /c "packer build arch-workstation-vmware-box.json"
	cmd.exe /c "packer build arch-workstation-virtualbox-box.json"

clean:
	packer box remove --all arch-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: arch-workstation-vmware.box

vbox: arch-workstation-virtualbox.box

output-vmware-vmx/arch-workstation.vmx: arch-workstation.json
	cmd.exe /c "packer build --only=vmware-vmx arch-workstation.json"

output-virtualbox-ovf/arch-workstation.ovf: arch-workstation.json
	cmd.exe /c "packer build --only=virtualbox-ovf arch-workstation.json"

arch-workstation-vmware.box: output-vmware-vmx/arch-workstation.vmx
	cmd.exe /c "packer build arch-workstation-vmware-box.json"

arch-workstation-virtualbox.box: output-virtualbox-ovf/arch-workstation.ovf
	cmd.exe /c "packer build arch-workstation-virtualbox-box.json"
