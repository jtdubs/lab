#!/bin/bash

set -eu

domain="lab.dubs.zone"
dc_ip="192.168.64.8"

echo "Adding hosts entry for DC..."
echo "$dc_ip dc.$domain" | sudo tee -a /etc/hosts

echo "Pointing to DC for DNS services..."
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo unlink /etc/resolv.conf
sudo -E bash -c "cat > /etc/resolv.conf <<EOF
nameserver $dc_ip
search lab.dubs.zone
EOF"

echo "Pointing to DC for NTP services..."
sudo sed -i 's/#NTP=/NTP=dc.lab.dubs.zone/' /etc/systemd/timesyncd.conf 
sudo sed -i 's/#RootDistanceMaxSec=.*/RootDistanceMaxSec=31536000/' /etc/systemd/timesyncd.conf 
sudo systemctl restart systemd-timesyncd

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
    sudo bash -c 'cat > /usr/share/xsessions/xsession.desktop <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF'
fi

cd /home/vagrant

echo "Switching Shell to Fish..."
sudo chsh -s /usr/bin/fish vagrant

echo "Installing alacritty..."
which alacritty || cargo install alacritty

if [ ! -d ~/.fzf ]
then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if [ ! -d ~/dotfiles ]
then
    echo "Installing dotfiles (initial)..."
    git clone https://github.com/jtdubs/dotfiles.git
    pushd dotfiles
    pip3 install -r requirements.txt
    ./sync.py
    popd
    rm -Rf ~/.config/nvim
fi

if [ ! -d ~/.config/nvim ]
then
    echo "Installing nvim plugins..."
    nvim --headless +PlugInstall +CocUpdate +qa || true
fi

echo "Installing dotfiles (final)..."
pushd ~/dotfiles
./sync.py
popd

echo "Validating nvim setup..."
nvim --headless +PlugInstall +CocUpdate +qa