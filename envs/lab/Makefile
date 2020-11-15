.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --name win10-workstation ../../boxes/win10-workstation/win10-workstation-hyperv.box
	vagrant box add -f --name kali-workstation ../../boxes/kali-workstation/kali-workstation-hyperv.box

unregister:
	vagrant box remove -f --all --name win10-workstation --provider hyperv 
	vagrant box remove -f --all --name kali-workstation --provider hyperv 