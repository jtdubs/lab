# What HCL templates do we need
HCL_TEMPLATES += communicator-ssh-pass
HCL_TEMPLATES += constants
HCL_TEMPLATES += source-hyperv-iso
HCL_TEMPLATES += source-virtualbox-iso
HCL_TEMPLATES += source-vmware-iso

# Set VM name && json name match folder name, if not already set
VM_NAME   ?= $(notdir $(CURDIR))

# By default, use all providers
PROVIDERS ?= all

# If VM is a "base" image, we are using ISOs, otherwise we are using another VM
ifeq ($(findstring base,$(VM_NAME)),)
VMWARE_TARGET = vmware-vmx
VIRBOX_TARGET = virtualbox-ovf
HYPERV_TARGET = hyperv-vmcx
else
VMWARE_TARGET = vmware-iso
VIRBOX_TARGET = virtualbox-iso
HYPERV_TARGET = hyperv-iso
endif

.PHONY: all clean vmware vbox hyperv

ifeq ($(OS),Windows_NT)
RM = powershell Remove-Item -Recurse -Force
CP = powershell Copy-Item
else
RM = rm -Rf
CP = cp
endif

HCL_FILES = $(HCL_TEMPLATES:=.pkr.hcl)

ifeq ($(PROVIDERS),all)
all: $(HCL_FILES)
	packer build --on-error=ask --force .
else
all: $(PROVIDERS)
endif

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv
	-$(RM) $(HCL_FILES)

vmware: output-vmware

vbox: output-virtualbox

hyperv: output-hyperv

output-vmware: build.pkr.hcl $(HCL_FILES)
	packer build --on-error=ask --only=$(VMWARE_TARGET) --force .

output-virtualbox: build.pkr.hcl $(HCL_FILES)
	packer build --on-error=ask --only=$(VIRBOX_TARGET) --force .

output-hyperv: build.pkr.hcl $(HCL_FILES)
	packer build --on-error=ask --only=$(HYPERV_TARGET) --force .

$(HCL_FILES): %: ../hcl-templates/%
	$(CP) $< $@