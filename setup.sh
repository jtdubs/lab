#!/bin/sh

if [ ! -e vagrant.id_rsa ]
then
    echo "Generating Vagrant's SSH key..."
    ssh-keygen -P "" -C "Vagrant" -f ./vagrant.id_rsa 2>&1 >/dev/null
fi
