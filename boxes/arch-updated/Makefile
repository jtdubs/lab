.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask arch-updated.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv
	-$(RM) *.box

vmware: arch-updated-vmware.box

vbox: arch-updated-virtualbox.box

hyperv: arch-updated-hyperv.box

arch-updated-vmware.box: arch-updated.json
	packer build --on-error=ask --only=vmware-vmx --force arch-updated.json

arch-updated-virtualbox.box: arch-updated.json
	packer build --on-error=ask --only=virtualbox-ovf --force arch-updated.json

arch-updated-hyperv.box: arch-updated.json
	packer build --on-error=ask --only=hyperv-vmcx --force arch-updated.json
