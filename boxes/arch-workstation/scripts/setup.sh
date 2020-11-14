#!/bin/bash

set -eu

echo "Installing packages..."
sudo pacman -S --noconfirm \
    alacritty bspwm dmenu exa feh firefox fish git \
    lightdm lightdm-gtk-greeter neovim network-manager-applet \
    nodejs numlockx picom pulseaudio pulseaudio-alsa \
    python python-pip sxhkd tmux xf86-video-vmware xorg-server \
    xorg-xrdb xorg-xsetroot yarn

paru -S --noconfirm polybar xinit-xsession

echo "Enabling Window Manager..."
sudo systemctl enable lightdm.service

echo "Switching Shell to Fish..."
sudo chsh -s /usr/bin/fish vagrant