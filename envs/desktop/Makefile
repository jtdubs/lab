.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider hyperv --name ubuntu-xorg ../../boxes/ubuntu-xorg/ubuntu-xorg-hyperv.box
	vagrant box add -f --provider hyperv --name arch-xorg ../../boxes/arch-xorg/arch-xorg-hyperv.box
	vagrant box add -f --provider hyperv --name kali-updated ../../boxes/kali-updated/kali-updated-hyperv.box

unregister:
	vagrant box remove -f --all --provider hyperv ubuntu-xorg
	vagrant box remove -f --all --provider hyperv arch-xorg
	vagrant box remove -f --all --provider hyperv kali-updated