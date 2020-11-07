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

echo "Configuring network..."
pacman -S --noconfirm networkmanager dhclient
systemctl enable NetworkManager.service

echo "Configuring ssh..."
pacman -S --noconfirm openssh
systemctl enable sshd.service

echo "Installing updates..."
pacman -Syu --noconfirm

echo "Installing sudo..."
pacman -S --noconfirm sudo

echo "Setting up Packer..."
useradd -m -U packer
cat > /etc/sudoers.d/10_packer <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
packer ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_packer
mkdir -p /home/packer/.ssh
mv /packer.id_rsa.pub /home/packer/.ssh/authorized_keys
chown -R packer:packer /home/packer/.ssh
chmod 700 /home/packer/.ssh
chmod 600 /home/packer/.ssh/authorized_keys

echo "Setting up Vagrant..."
useradd -m -U vagrant
pacman -S --noconfirm python
cat > /etc/sudoers.d/10_vagrant <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
vagrant ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_vagrant
mkdir -p /home/vagrant/.ssh
mv /vagrant.id_rsa.pub /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

echo "Installing yay..."
pacman -S --noconfirm base-devel git
cat > /home/packer/install-yay.sh <<EOS
#!/bin/bash
set -eu
cd /home/packer
git clone https://aur.archlinux.org/yay-git.git
pushd yay-git
makepkg --syncdeps --install --noconfirm
popd
rm -Rf yay-git
EOS
sudo -u packer bash /home/packer/install-yay.sh
