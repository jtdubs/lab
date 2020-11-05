Dependencies:
- Packer

Instructions:
> ssh-keygen -f ./packer_id_rsa
> pushd arch-base && packer build arch-base.json && popd
> pushd arch-workstation && packer build arch-workstation.json && popd
