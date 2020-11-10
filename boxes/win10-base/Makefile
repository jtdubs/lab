.PHONY: all clean vmware vbox null

all:
	cmd.exe /c "packer build win10-base.json"
	cmd.exe /c "packer build win10-base-vmware-box.json"
	cmd.exe /c "packer build win10-base-virtualbox-box.json"

clean:
	cmd.exe /c "vagrant box remove --all win10-base"
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

vmware: win10-base-vmware.box

vbox: win10-base-virtualbox.box

output-vmware-iso/win10-base.vmx: win10-base.json
	cmd.exe /c "packer build --only=vmware-iso --on-error=ask win10-base.json"

output-virtualbox-iso/win10-base.ovf: win10-base.json
	cmd.exe /c "packer build --only=virtualbox-iso win10-base.json"

win10-base-vmware.box: output-vmware-iso/win10-base.vmx
	cmd.exe /c "packer build win10-base-vmware-box.json"

win10-base-virtualbox.box: output-virtualbox-iso/win10-base.ovf
	cmd.exe /c "packer build win10-base-virtualbox-box.json"
