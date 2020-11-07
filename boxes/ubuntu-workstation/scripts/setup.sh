#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    pulseaudio tmux xorg xserver-xorg xserver-xorg-video-vmware \
    x11-xserver-utils polybar lightdm lightdm-gtk-greeter \
    network-manager-gnome

echo "Enabling window manager..."
systemctl enable lightdm.service

echo "Creating XSession..."
cat > /usr/share/xsessions/xsession.desktop <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF

echo "Creating jtdubs user..."
useradd -c "Justin Dubs" -U -s /usr/bin/fish -m -p $(/usr/bin/openssl passwd -crypt '') jtdubs

echo "Creating sudoers entry..."
echo "jtdubs ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/10_jtdubs
chown root:root /etc/sudoers.d/10_jtdubs
chmod 0440 /etc/sudoers.d/10_jtdubs
