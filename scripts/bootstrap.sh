#!/usr/bin/env bash

set -eu

echo "Setting clock..."
timedatectl set-ntp true


echo "Partitioning disk..."
sgdisk --zap-all /dev/sda
wipefs --all /dev/sda

# EFI boot partition
sgdisk --new=1:0:+512M --typecode=1:EF00 /dev/sda
mkfs.fat -F32 /dev/sda1

# Swap
sgdisk --new=2:0:+2G --typecode=1:8200 /dev/sda
mkswap /dev/sda2

# Root
sgdisk --new=3:0:0 --typecode=1:8300 /dev/sda
mkfs.ext4 -L "Arch Root" /dev/sda3


echo "Mounting filesystems..."
mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2


echo "Bootstrapping..."
pacstrap /mnt base linux linux-firmware man-db man-pages
genfstab -U /mnt >> /mnt/etc/fstab


cat > /mnt/chroot-install.sh <<EOF
echo "Setting timezone..."
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

echo "Setting localization..."
echo LANG=en_US.UTF_8 > /etc/locale.conf
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen

echo "Setting hostname..."
echo arch-base > /etc/hostname
echo 127.0.0.1 arch-base > /etc/hosts
echo ::1 arch-base >> /etc/hosts
echo 127.0.1.1 arch-base.localdomain arch-base >> /etc/hosts

echo "Setting root password..."
usermod -p $(/usr/bin/openssl passwd -crypt 'foobar81') root

echo "Configuring network..."
pacman -S --noconfirm networkmanager dhclient
systemctl enable networkmanager.service

echo "Configuring ssh..."
pacman -S --noconfirm openssh
systemctl enable sshd.service

echo "Creating packer user..."
useradd -p $(/usr/bin/openssl passwd -crypt 'packer') -m -U packer

echo "Setting up sudo..."
pacman -S --noconfirm sudo
cat > /etc/sudoers.d/10_packer <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
packer ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_packer
EOF


echo "Entering chroot..."
chmod a+x /mnt/chroot-install.sh
arch-chroot /mnt /chroot-install.sh
echo "Exited chroot..."


echo "Cleaning up..."
rm /mnt/chroot-install.sh
umount /mnt/boot
umount /mnt


echo "Rebooting..."
reboot
