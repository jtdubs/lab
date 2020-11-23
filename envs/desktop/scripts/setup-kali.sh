#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox-esr fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    tmux x11-xserver-utils polybar cmake pkg-config libfreetype6-dev \
    libfontconfig1-dev libxcb-xfixes0-dev cargo

if [ ! -e /usr/share/xsessions/xsession.desktop ]
then
    echo "Creating XSession..."
    cat <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF | sudo tee /usr/share/xsessions/xsession.desktop 
fi