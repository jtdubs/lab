.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider virtualbox --name kali-updated ../../boxes/kali-updated/kali-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name win10-workstation ../../boxes/win10-workstation/win10-workstation-virtualbox.box

unregister:
	vagrant box remove -f --all --provider virtualbox kali-updated
	vagrant box remove -f --all --provider virtualbox win10-workstation