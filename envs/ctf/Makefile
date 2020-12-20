.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider hyperv --name kali-updated ../../boxes/kali-updated/kali-updated-hyperv.box
	vagrant box add -f --provider hyperv --name win10-workstation ../../boxes/win10-workstation/win10-workstation-hyperv.box

unregister:
	vagrant box remove -f --all --provider hyperv kali-updated
	vagrant box remove -f --all --provider hyperv win10-workstation