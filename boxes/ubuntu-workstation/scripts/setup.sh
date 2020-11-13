#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    pulseaudio tmux xorg xserver-xorg x11-xserver-utils polybar \
    lightdm lightdm-gtk-greeter network-manager-gnome \
    xserver-xorg-video-fbdev

echo "Enabling window manager..."
systemctl enable lightdm.service

echo "Creating XSession..."
cat > /usr/share/xsessions/xsession.desktop <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF

echo "Changing Vagrant's Shell..."
chsh -s /usr/bin/fish vagrant