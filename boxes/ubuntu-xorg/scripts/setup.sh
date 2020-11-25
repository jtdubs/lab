#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y --no-install-recommends \
    picom numlockx pulseaudio xorg xserver-xorg x11-xserver-utils \
    lightdm lightdm-gtk-greeter xserver-xorg-video-fbdev

echo "Enabling window manager..."
sudo systemctl enable lightdm.service

echo "Creating XSession..."
sudo mkdir -p /usr/share/xsessions
sudo bash -c 'cat <<EOF >/usr/share/xsessions/xsession.desktop
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF'