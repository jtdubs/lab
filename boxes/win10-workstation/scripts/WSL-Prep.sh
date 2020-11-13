#!/bin/bash

set -eu

echo "Install dependencies..."
apt-get update
apt-get install --yes build-essential fish git neovim nodejs python3-pip tmux

echo "Creating vagrant user..."
useradd -c vagrant -U -s /usr/bin/fish -m -p $(/usr/bin/openssl passwd -crypt 'vagrant') vagrant

echo "Creating sudoers entry..."
echo "vagrant ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/10_vagrant
chown root:root /etc/sudoers.d/10_vagrant
chmod 0440 /etc/sudoers.d/10_vagrant