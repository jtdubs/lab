#!/usr/bin/env bash

set -eu

echo "Installing vmware tools..."
pacman -S --noconfirm linux-headers open-vm-tools nfs-utils
systemctl enable vmtoolsd.service
systemctl enable rpcbind.service
