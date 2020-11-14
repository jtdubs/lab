#!/bin/sh

if [ ! -e vagrant.id_rsa ]
then
    echo "Generating Vagrant's SSH key..."
    ssh-keygen -P "" -C "Vagrant" -f ./vagrant.id_rsa 2>&1 >/dev/null

    echo "Fixing permissions..."
    cmd.exe /c "icacls.exe vagrant.id_rsa /grant jtdub:F /inheritance:r"
fi
