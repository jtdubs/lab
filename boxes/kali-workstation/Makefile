.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build kali-workstation.json"
	cmd.exe /c "packer build kali-workstation-vmware-box.json"
	cmd.exe /c "packer build kali-workstation-virtualbox-box.json"

clean:
	packer box remove --all kali-workstation
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf
	rm -f *.box

vmware: kali-workstation-vmware.box

vbox: kali-workstation-virtualbox.box

output-vmware-vmx/kali-workstation.vmx: kali-workstation.json
	cmd.exe /c "packer build --only=vmware-vmx kali-workstation.json"

output-virtualbox-ovf/kali-workstation.ovf: kali-workstation.json
	cmd.exe /c "packer build --only=virtualbox-ovf kali-workstation.json"

kali-workstation-vmware.box: output-vmware-vmx/kali-workstation.vmx
	cmd.exe /c "packer build kali-workstation-vmware-box.json"

kali-workstation-virtualbox.box: output-virtualbox-ovf/kali-workstation.ovf
	cmd.exe /c "packer build kali-workstation-virtualbox-box.json"
