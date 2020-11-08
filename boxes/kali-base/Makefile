.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build kali-base.json"
	cmd.exe /c "packer build kali-base-vmware-box.json"
	cmd.exe /c "packer build kali-base-virtualbox-box.json"

clean:
	cmd.exe /c "vagrant box remove --all kali-base"
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ova
	rm -f *.box

vmware: kali-base-vmware.box

vbox: kali-base-virtualbox.box

output-vmware-vmx/kali-base.vmx: kali-base.json
	cmd.exe /c "packer build --only=vmware-vmx kali-base.json"

output-virtualbox-ova/kali-base.ovf: kali-base.json
	cmd.exe /c "packer build --only=virtualbox-ova kali-base.json"

kali-base-vmware.box: output-vmware-vmx/kali-base.vmx
	cmd.exe /c "packer build kali-base-vmware-box.json"

kali-base-virtualbox.box: output-virtualbox-ova/kali-base.ovf
	cmd.exe /c "packer build kali-base-virtualbox-box.json"
