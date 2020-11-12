.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask win10-base.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-iso
	-$(RM) output-virtualbox-iso
	-$(RM) output-hyperv-iso
	-$(RM) *.box

tools/virtualbox-tools.iso:
	cp /mnt/c/Program\ Files/Oracle/VirtualBox/VBoxGuestAdditions.iso tools/virtualbox-tools.iso

tools/vmware-tools.iso:
	cp /mnt/c/Program\ Files\ \(x86\)/VMware/VMware\ Workstation/windows.iso tools/vmware-tools.iso 

vmware: win10-base-vmware.box

vbox: win10-base-virtualbox.box

hyperv: win10-base-hyperv.box

win10-base-vmware.box: win10-base.json tools/vmware-tools.iso
	packer build --on-error=ask --only=vmware-iso win10-base.json

win10-base-virtualbox.box: win10-base.json tools/virtualbox-tools.iso
	packer build --on-error=ask --only=virtualbox-iso win10-base.json

win10-base-hyperv.box: win10-base.json
	packer build --on-error=ask --only=hyperv-iso win10-base.json
