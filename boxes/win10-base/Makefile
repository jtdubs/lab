.PHONY: all clean vmware vbox

all:
	cmd.exe /c "packer build win10-base.json"
	cmd.exe /c "packer build win10-base-vmware-box.json"
	cmd.exe /c "packer build win10-base-virtualbox-box.json"

clean:
	packer box remove --all win10-base
	rm -Rf packer_cache output-vmware-iso output-virtualbox-iso
	rm -f *.box

vmware: win10-base-vmware.box

vbox: win10-base-virtualbox.box

# iso/Windows-Auto.iso: iso/Windows.iso autounattend.xml
# 	mkdir -p iso-unpacked
# 	7z x iso/Windows.iso -oiso-unpacked/
# 	cp autounattend.xml iso-unpacked/
# 	genisoimage -o iso/Windows-Auto.iso iso-unpacked/
# 	rm -Rf iso-unpacked

output-vmware-iso/win10-base.vmx: win10-base.json
	cmd.exe /c "packer build --only=vmware-iso win10-base.json"

output-virtualbox-iso/win10-base.ovf: win10-base.json
	cmd.exe /c "packer build --only=virtualbox-iso win10-base.json"

win10-base-vmware.box: output-vmware-iso/win10-base.vmx
	cmd.exe /c "packer build win10-base-vmware-box.json"

win10-base-virtualbox.box: output-virtualbox-iso/win10-base.ovf
	cmd.exe /c "packer build win10-base-virtualbox-box.json"
