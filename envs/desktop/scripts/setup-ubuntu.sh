#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -y --no-install-recommends \
    build-essential curl feh firefox fish git neovim nodejs \
    yarnpkg python3-pip suckless-tools bspwm sxhkd exa \
    tmux polybar network-manager-gnome cmake pkg-config libfreetype6-dev \
    libfontconfig1-dev libxcb-xfixes0-dev cargo