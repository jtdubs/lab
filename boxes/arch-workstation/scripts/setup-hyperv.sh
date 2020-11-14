#!/bin/bash

set -eu

echo "Installing Hyper-V packages..."
sudo pacman -S --noconfirm xf86-video-fbdev

echo "Preparing for Enhanced Session Support..."
paru -S --noconfirm xrdp-git
git clone https://github.com/Microsoft/linux-vm-tools
cd linux-vm-tools/arch
./makepkg.sh
sudo ./install-config.sh