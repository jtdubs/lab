.PHONY: all clean register unregister

all: register
clean: unregister

register:
	vagrant box add -f --name ubuntu-workstation ../../boxes/ubuntu-workstation/ubuntu-workstation-hyperv.box

unregister:
	vagrant box remove -f --all --name ubuntu-workstation --provider hyperv 