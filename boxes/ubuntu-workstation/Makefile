.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build ubuntu-workstation.json"
	cmd.exe /c "packer build ubuntu-workstation-vmware-box.json"
	cmd.exe /c "packer build ubuntu-workstation-virtualbox-box.json"

clean:
	packer box remove --all ubuntu-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: ubuntu-workstation-vmware.box

vbox: ubuntu-workstation-virtualbox.box

output-vmware-vmx/ubuntu-workstation.vmx: ubuntu-workstation.json
	cmd.exe /c "packer build --only=vmware-vmx ubuntu-workstation.json"

output-virtualbox-ovf/ubuntu-workstation.ovf: ubuntu-workstation.json
	cmd.exe /c "packer build --only=virtualbox-ovf ubuntu-workstation.json"

ubuntu-workstation-vmware.box: output-vmware-vmx/ubuntu-workstation.vmx
	cmd.exe /c "packer build ubuntu-workstation-vmware-box.json"

ubuntu-workstation-virtualbox.box: output-virtualbox-ovf/ubuntu-workstation.ovf
	cmd.exe /c "packer build ubuntu-workstation-virtualbox-box.json"
