#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox-esr fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    tmux x11-xserver-utils polybar cmake pkg-config libfreetype6-dev \
    libfontconfig1-dev libxcb-xfixes0-dev cargo

echo "Installing additional tools..."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -y --no-install-recommends \
    powershell docker.io

echo "Configuring docker..."
sudo usermod -aG docker vagrant