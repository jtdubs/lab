#!/bin/sh

if [ ! -e packer.id_rsa ]
then
    echo "Generating Packer's SSH key..."
    ssh-keygen -P "" -C "Packer" -f ./packer.id_rsa 2>&1 >/dev/null
fi

if [ ! -e vagrant.id_rsa ]
then
    echo "Generating Vagrant's SSH key..."
    ssh-keygen -P "" -C "Vagrant" -f ./vagrant.id_rsa 2>&1 >/dev/null
fi
