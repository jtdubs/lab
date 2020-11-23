#!/usr/bin/env bash

set -eu

echo "Installing vmware tools..."
pacman -S --needed --noconfirm linux-headers open-vm-tools nfs-utils
systemctl enable vmtoolsd.service
systemctl enable rpcbind.service
