#!/bin/bash

set -eu

echo "Installing packages..."
sudo pacman -S --noconfirm \
    lightdm lightdm-gtk-greeter picom pulseaudio pulseaudio-alsa \
    xorg-server xorg-xrdb xorg-xsetroot man-db man-pages

paru -S --noconfirm xinit-xsession

echo "Enabling Window Manager..."
sudo systemctl enable lightdm.service