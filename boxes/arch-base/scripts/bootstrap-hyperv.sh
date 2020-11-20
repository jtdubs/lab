#!/usr/bin/env bash

set -eu

echo "Creating EFI boot entry..."
BLKID=$(blkid -s PARTUUID -o value /dev/sda3)
echo "BLKID=$BLKID"
efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux" --loader /vmlinuz-linux --unicode "root=PARTUUID=$BLKID rw initrd=\initramfs-linux.img" --verbose
efibootmgr --bootorder 0003

echo "Adding Hyper-V install steps..."
cp /tmp/install-hyperv.sh /mnt/install-guest-tools.sh
