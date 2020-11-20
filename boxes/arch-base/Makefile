.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask arch-base.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv

vmware: output-vmware

vbox: output-virtualbox

hyperv: output-hyperv

output-vmware: arch-base.json
	packer build --on-error=ask --only=vmware-iso --force arch-base.json

output-virtualbox: arch-base.json
	packer build --on-error=ask --only=virtualbox-iso --force arch-base.json

output-hyperv: arch-base.json
	packer build --on-error=ask --only=hyperv-iso --force arch-base.json
