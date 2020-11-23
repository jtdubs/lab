.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider hyperv --name ubuntu-interactive-xorg ../../boxes/ubuntu-interactive-xorg/ubuntu-interactive-xorg-hyperv.box
	vagrant box add -f --provider hyperv --name arch-interactive-xorg ../../boxes/arch-interactive-xorg/arch-interactive-xorg-hyperv.box
	vagrant box add -f --provider hyperv --name kali-updated ../../boxes/kali-updated/kali-updated-hyperv.box

unregister:
	vagrant box remove -f --all --provider hyperv ubuntu-interactive-xorg
	vagrant box remove -f --all --provider hyperv arch-interactive-xorg
	vagrant box remove -f --all --provider hyperv kali-updated