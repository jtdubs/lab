#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends \
    build-essential picom feh fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    tmux x11-xserver-utils polybar

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
