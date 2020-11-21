#!/bin/bash

set -eu

cd /home/vagrant

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y --no-install-recommends \
    build-essential picom curl feh firefox-esr fish git neovim nodejs \
    yarnpkg numlockx python3-pip suckless-tools bspwm sxhkd exa \
    tmux x11-xserver-utils polybar

echo "Creating XSession..."
cat <<EOF
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
EOF | sudo tee /usr/share/xsessions/xsession.desktop 

echo "Switching Shell to Fish..."
sudo chsh -s /usr/bin/fish vagrant

echo "Installing alacritty..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev cargo
cargo install alacritty

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing dotfiles (initial)..."
git clone https://github.com/jtdubs/dotfiles.git
pushd dotfiles
pip3 install -r requirements.txt
./sync.py
popd

echo "Installing nvim plugins..."
rm -Rf ~/.config/nvim/plugged/lightline.vim/
nvim --headless +PlugInstall +CocUpdate +qa || true

echo "Installing dotfiles (final)..."
pushd ~/dotfiles
./sync.py
popd

echo "Validating nvim setup..."
nvim --headless +PlugInstall +CocUpdate +qa