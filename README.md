Dependencies:
- Packer
- VMWare or VirtualBox

Instructions:
```
> ssh-keygen -f ./packer_id_rsa

VMWare:
> pushd arch-base        && packer build --only=vmware-iso arch-base.json        && popd
> pushd arch-workstation && packer build --only=vmware-vmx arch-workstation.json && popd

VirtualBox:
> pushd arch-base        && packer build --only=virtualbox-iso arch-base.json        && popd
> pushd arch-workstation && packer build --only=virtualbox-ovf arch-workstation.json && popd

Both:
> pushd arch-base        && packer build arch-base.json        && popd
> pushd arch-workstation && packer build arch-workstation.json && popd
