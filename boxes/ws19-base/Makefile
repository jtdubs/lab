# Set VM name && json name match folder name, if not already set
VM_NAME   ?= $(notdir $(CURDIR))
JSON_NAME ?= $(VM_NAME).json

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
else
RM = rm -Rf
endif

ifeq ($(PROVIDERS),all)
all:
	packer build --on-error=ask --force $(JSON_NAME)
else
all: $(PROVIDERS)
endif

clean:
	-$(RM) packer_cache
	-$(RM) output-vmware
	-$(RM) output-virtualbox
	-$(RM) output-hyperv

vmware: output-vmware

vbox: output-virtualbox

hyperv: output-hyperv

output-vmware: $(JSON_NAME)
	packer build --on-error=ask --only=$(VMWARE_TARGET) --force $(JSON_NAME)

output-virtualbox: $(JSON_NAME)
	packer build --on-error=ask --only=$(VIRBOX_TARGET) --force $(JSON_NAME)

output-hyperv: $(JSON_NAME)
	packer build --on-error=ask --only=$(HYPERV_TARGET) --force $(JSON_NAME)