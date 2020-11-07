#!/bin/bash

set -eu

cd /home/jtdubs

echo "Installing alacritty..."
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
