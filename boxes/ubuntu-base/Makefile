.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask ubuntu-base.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-iso
	-$(RM) output-virtualbox-iso
	-$(RM) output-hyperv-iso
	-$(RM) *.box

vmware: ubuntu-base-vmware.box

vbox: ubuntu-base-virtualbox.box

hyperv: ubuntu-base-hyperv.box

ubuntu-base-vmware.box: ubuntu-base.json
	packer build --on-error=ask --only=vmware-iso ubuntu-base.json

ubuntu-base-virtualbox.box: ubuntu-base.json
	packer build --on-error=ask --only=virtualbox-iso ubuntu-base.json

ubuntu-base-hyperv.box: ubuntu-base.json
	packer build --on-error=ask --only=hyperv-iso ubuntu-base.json
