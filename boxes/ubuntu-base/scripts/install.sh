#!/usr/bin/env bash

set -eu

echo "Setting up Packer..."
cat > /etc/sudoers.d/10_packer <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
packer ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_packer
mkdir -p /home/packer/.ssh
mv /tmp/packer_id_rsa.pub /home/packer/.ssh/authorized_keys
chown -R packer:packer /home/packer/.ssh
chmod 700 /home/packer/.ssh
chmod 600 /home/packer/.ssh/authorized_keys

echo "Setting up Vagrant..."
useradd -m -U vagrant
cat > /etc/sudoers.d/10_vagrant <<EOS
Defaults env_keep += "SSH_AUTH_SOCK"
vagrant ALL=(ALL) NOPASSWD: ALL
EOS
chmod 0440 /etc/sudoers.d/10_vagrant
mkdir -p /home/vagrant/.ssh
mv /tmp/vagrant_id_rsa.pub /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

echo "Removing Packer's password..."
passwd --delete packer
