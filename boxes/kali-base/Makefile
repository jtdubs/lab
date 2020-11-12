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
	-$(RM) output-vmware-vmx
	-$(RM) output-virtualbox-ovf
	-$(RM) *.box

vmware: kali-base-vmware.box

vbox: kali-base-virtualbox.box

kali-base-vmware.box: kali-base.json
	packer build --on-error=ask --only=vmware-vmx kali-base.json

kali-base-virtualbox.box: kali-base.json
	packer build --on-error=ask --only=virtualbox-ovf kali-base.json