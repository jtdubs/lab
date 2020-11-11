.PHONY: all clean vmware vbox

all:
	packer build --on-error=ask kali-base.json
	packer build --on-error=ask kali-base-vmware-box.json
	packer build --on-error=ask kali-base-virtualbox-box.json

clean:
	-vagrant box remove --all kali-base --provider vmware_desktop
	-vagrant box remove --all kali-base --provider virtualbox
	rm -Rf packer_cache output-vmware-vmx output-virtualbox-ovf output-kali-converted
	rm -f *.box

vmware: kali-base-vmware.box

vbox: kali-base-virtualbox.box

output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmx: input/Kali-Linux-2020.3-vmware-amd64.vmwarevm/Kali-Linux-2020.3-vmware-amd64.vmx
	rm -Rf output-kali-converted/
	mkdir output-kali-converted
	cp input/Kali-Linux-2020.3-vmware-amd64.vmwarevm/* output-kali-converted/
	sed -ie 's/^numvcpus = .*/numvcpus = "2"/' output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmx
	sed -ie 's/^memsize = .*/memsize = "4096"/' output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmx
	sed -ie 's/^scsi0:0.fileName = .*/scsi0:0.fileName = "disk.vmdk"/' output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmx
	vmware-vdiskmanager -r output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmdk -t 0 output-kali-converted/disk.vmdk
	rm output-kali-converted/Kali-Linux-2020.3-vmware-amd64*.vmdk

output-vmware-vmx/kali-base.vmx: kali-base.json output-kali-converted/Kali-Linux-2020.3-vmware-amd64.vmx
	packer build --on-error=ask --only=vmware-vmx kali-base.json

output-virtualbox-ovf/kali-base.ovf: kali-base.json
	packer build --on-error=ask --only=virtualbox-ovf kali-base.json

kali-base-vmware.box: output-vmware-vmx/kali-base.vmx
	packer build --on-error=ask kali-base-vmware-box.json

kali-base-virtualbox.box: output-virtualbox-ovf/kali-base.ovf
	packer build --on-error=ask kali-base-virtualbox-box.json
