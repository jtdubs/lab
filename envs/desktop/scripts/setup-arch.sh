#!/bin/bash

set -eu

echo "Installing packages..."
sudo pacman -S --needed --noconfirm \
    alacritty bspwm dmenu exa feh firefox fish git neovim network-manager-applet \
    nodejs numlockx python python-pip sxhkd tmux yarn

paru -S --needed --noconfirm polybar