#!/bin/bash

set -eu

echo "Installing Hyper-V packages..."
sudo pacman -S --noconfirm xf86-video-fbdev

echo "Preparing for Enhanced Session Support..."
paru -S --noconfirm xrdp-git
git clone https://github.com/Microsoft/linux-vm-tools
pushd linux-vm-tools/arch
./makepkg.sh
sudo ./install-config.sh
popd
rm -Rf linux-vm-tools