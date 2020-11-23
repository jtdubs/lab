#!/bin/bash

set -eu

echo "Installing packages..."
sudo pacman -S --needed --noconfirm \
    lightdm lightdm-gtk-greeter picom pulseaudio pulseaudio-alsa \
    xorg-server xorg-xrdb xorg-xsetroot man-db man-pages

paru -S --needed --noconfirm xinit-xsession

echo "Enabling Window Manager..."
sudo systemctl enable lightdm.service