#!/bin/bash

set -eu

echo "Mounting share..."
sudo bash -c 'cat <<EOF >>/etc/fstab
//192.168.64.32/share   /mnt    cifs    rw,user,uid=1000,gid=1000,username=Vagrant,password=vagrant
EOF'
sudo mount /mnt