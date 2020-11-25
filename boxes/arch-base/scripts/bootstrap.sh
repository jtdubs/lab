#!/usr/bin/env bash

set -eu

echo "Setting clock..."
timedatectl set-ntp true

echo "Partitioning disk..."
sgdisk --zap-all /dev/sda
wipefs --all /dev/sda
sgdisk --new=1:0:+1M --partition-guid=1:21686148-6449-6E6F-744E-656564454649 --typecode=1:EF02 --change-name 1:BOOT /dev/sda
sgdisk --new=2:0:+2G --typecode=2:8200 --change-name 2:SWAP /dev/sda
mkswap /dev/sda2
sgdisk --new=3:0:0 --typecode=3:8300 --change-name 3:ROOT /dev/sda
mkfs.ext4 -L "Arch Root" /dev/sda3

echo "Mounting filesystems..."
mount /dev/sda3 /mnt
swapon /dev/sda2

echo "Bootstrapping..."
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab