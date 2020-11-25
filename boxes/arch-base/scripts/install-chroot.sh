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

echo "Installing software..."
pacman -S --needed --noconfirm networkmanager dhclient openssh sudo grub

echo "Installing grub..."
mkinitcpio -p linux
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "Setting up Vagrant..."
useradd -m -U vagrant
echo vagrant:vagrant | chpasswd
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

if [ -e /install-guest-tools.sh ]
then
    chmod a+x /install-guest-tools.sh
    /install-guest-tools.sh
fi
