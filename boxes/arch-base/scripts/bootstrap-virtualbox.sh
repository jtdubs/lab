#!/usr/bin/env bash

set -eu

echo "Creating EFI boot entry..."
BLKID=$(blkid -s PARTUUID -o value /dev/sda3)
echo "BLKID=$BLKID"
echo "\\vmlinuz-linux root=PARTUUID=$BLKID rw initrd=\\initramfs-linux.img" > /mnt/boot/startup.nsh

echo "Adding VirtualBox install steps..."
cat /tmp/install-virtualbox.sh >> /mnt/install.sh
