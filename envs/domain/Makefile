.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --provider hyperv --name ws19-base ../../boxes/ws19-base/ws19-base-hyperv.box
	vagrant box add -f --provider hyperv --name win10-updated ../../boxes/win10-updated/win10-updated-hyperv.box
	vagrant box add -f --provider hyperv --name ubuntu-xorg ../../boxes/ubuntu-xorg/ubuntu-xorg-hyperv.box

unregister:
	vagrant box remove -f --all --provider hyperv ws19-base
	vagrant box remove -f --all --provider hyperv win10-updated
	vagrant box remove -f --all --provider hyperv ubuntu-xorg