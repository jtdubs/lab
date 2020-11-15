#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    tmux x11-xserver-utils polybar

echo "Creating XSession..."
cat > /usr/share/xsessions/xsession.desktop <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF

echo "Changing Vagrant's Shell..."
chsh -s /usr/bin/fish vagrant