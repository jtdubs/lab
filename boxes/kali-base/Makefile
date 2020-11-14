.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
else
RM = rm -Rf
endif

all:
	packer build --on-error=ask kali-base.json

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware-iso
	-$(RM) output-virtualbox-iso
	-$(RM) output-hyperv-iso
	-$(RM) *.box

vmware: kali-base-vmware.box

vbox: kali-base-virtualbox.box

hyperv: kali-base-hyperv.box

kali-base-vmware.box: kali-base.json
	packer build --on-error=ask --only=vmware-iso kali-base.json

kali-base-virtualbox.box: kali-base.json
	packer build --on-error=ask --only=virtualbox-iso kali-base.json

kali-base-hyperv.box: kali-base.json
	packer build --on-error=ask --only=hyperv-iso kali-base.json
