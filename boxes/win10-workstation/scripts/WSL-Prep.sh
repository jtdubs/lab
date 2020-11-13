#!/bin/bash

set -eu

echo "Install dependencies..."
apt-get update
apt-get install --yes build-essential fish git neovim nodejs python3-pip tmux

echo "Creating jtdubs user..."
useradd -c "Justin Dubs" -U -s /usr/bin/fish -m -p $(/usr/bin/openssl passwd -crypt '') jtdubs

echo "Creating sudoers entry..."
echo "jtdubs ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/10_jtdubs
chown root:root /etc/sudoers.d/10_jtdubs
chmod 0440 /etc/sudoers.d/10_jtdubs