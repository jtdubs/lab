#!/bin/bash

set -eu

echo "Installing VMWare packages..."
sudo pacman -S --needed --noconfirm xf86-video-vmware