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
cat <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF | sudo tee /usr/share/xsessions/xsession.desktop 