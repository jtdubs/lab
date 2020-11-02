#!/usr/bin/env bash

set -eu

echo "Setting clock..."
timedatectl set-ntp true

echo "Partitioning disk..."
sgdisk --zap-all /dev/sda
wipefs --all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:EF00 --change-name 1:BOOT /dev/sda
mkfs.fat -F32 /dev/sda1
sgdisk --new=2:0:+2G --typecode=2:8200 --change-name 2:SWAP /dev/sda
mkswap /dev/sda2
sgdisk --new=3:0:0 --typecode=3:8300 --change-name 3:ROOT /dev/sda
mkfs.ext4 -L "Arch Root" /dev/sda3

echo "Creating EFI boot entry..."
efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux" --loader /vmlinuz-linux --unicode "root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sda3) rw initrd=\initramfs-linux.img" --verbose
efibootmgr --bootorder 0004

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
usermod -p $(/usr/bin/openssl passwd -crypt 'toor') root

echo "Configuring network..."
pacman -S --noconfirm networkmanager dhclient
systemctl enable NetworkManager.service

echo "Configuring ssh..."
pacman -S --noconfirm openssh
systemctl enable sshd.service

echo "Creating ansible user..."
useradd -p $(/usr/bin/openssl passwd -crypt 'ansible') -m -U ansible

echo "Setting up sudo..."
pacman -S --noconfirm sudo
cat > /etc/sudoers.d/10_ansible <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
ansible ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_ansible

echo "Installing vmware tools..."
pacman -S --noconfirm linux-headers open-vm-tools nfs-utils
systemctl enable vmtoolsd.service
systemctl enable rpcbind.service

echo "Installing updates..."
pacman -Syu --noconfirm
EOF

echo "Entering chroot..."
chmod a+x /mnt/chroot-install.sh
systemd-nspawn --machine=guest -D /mnt /chroot-install.sh
echo "Exited chroot..."

echo "Cleaning up..."
rm /mnt/chroot-install.sh
umount /mnt/boot
umount /mnt
