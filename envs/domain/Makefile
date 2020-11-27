.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider virtualbox --name ws19core-updated ../../boxes/ws19core-updated/ws19core-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name win10-updated ../../boxes/win10-updated/win10-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name ubuntu-updated ../../boxes/ubuntu-updated/ubuntu-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name kali-updated ../../boxes/kali-updated/kali-updated-virtualbox.box

unregister:
	vagrant box remove -f --all --provider virtualbox ws19core-updated
	vagrant box remove -f --all --provider virtualbox win10-updated
	vagrant box remove -f --all --provider virtualbox ubuntu-updated
	vagrant box remove -f --all --provider virtualbox kali-updated