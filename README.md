Dependencies:
- Packer
- VMWare or VirtualBox (with Extension Pack)
- Vagrant (optional)


Structure:
- boxes/ -- Packer definitions for VM images
- envs/  -- Vagrant environments


Instructions:
```
> ./setup.sh
> pushd boxes/<BOX> && make && popd
```


Makefile Targets:

* all: builds all support VM targets including .box files
* vmware: builds vmware image and vagrant box
* vbox: builds virtualbox image and vagrant box
