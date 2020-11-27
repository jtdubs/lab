.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider virtualbox --name ws19-base ../../boxes/ws19-base/ws19-base-virtualbox.box
	vagrant box add -f --provider virtualbox --name ws19core-base ../../boxes/ws19core-base/ws19core-base-virtualbox.box
	vagrant box add -f --provider virtualbox --name win10-updated ../../boxes/win10-updated/win10-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name ubuntu-xorg ../../boxes/ubuntu-xorg/ubuntu-xorg-virtualbox.box
	vagrant box add -f --provider virtualbox --name ubuntu-updated ../../boxes/ubuntu-updated/ubuntu-updated-virtualbox.box
	vagrant box add -f --provider virtualbox --name kali-updated ../../boxes/kali-updated/kali-updated-virtualbox.box

unregister:
	vagrant box remove -f --all --provider virtualbox ws19-base
	vagrant box remove -f --all --provider virtualbox ws19core-base
	vagrant box remove -f --all --provider virtualbox win10-updated
	vagrant box remove -f --all --provider virtualbox ubuntu-xorg
	vagrant box remove -f --all --provider virtualbox ubuntu-updated
	vagrant box remove -f --all --provider virtualbox kali-updated