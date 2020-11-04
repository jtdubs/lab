#!/usr/bin/env bash

set -eu

echo "Setting timezone..."
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

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

echo "Installing vmware tools..."
pacman -S --noconfirm linux-headers open-vm-tools nfs-utils
systemctl enable vmtoolsd.service
systemctl enable rpcbind.service

echo "Installing updates..."
pacman -Syu --noconfirm

echo "Installing sudo..."
pacman -S --noconfirm sudo

echo "Setting up Ansible..."
useradd -p $(/usr/bin/openssl passwd -crypt 'ansible') -m -U ansible
pacman -S --noconfirm python
cat > /etc/sudoers.d/10_ansible <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
ansible ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_ansible

echo "Installing authorized_keys..."
mkdir -p /home/ansible/.ssh
mv /ansible_id_rsa.pub /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys

echo "Installing yay..."
pacman -S --noconfirm base-devel git
cat > /home/ansible/install-yay.sh <<EOS
#!/bin/bash
set -eu
cd /home/ansible
git clone https://aur.archlinux.org/yay-git.git
pushd yay-git
makepkg --syncdeps --install --noconfirm
popd
rm -Rf yay-git
EOS
sudo -u ansible bash /home/ansible/install-yay.sh
