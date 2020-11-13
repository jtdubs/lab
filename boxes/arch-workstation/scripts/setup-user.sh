#!/bin/bash

set -eu

cd /home/vagrant

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing dotfiles (initial)..."
git clone https://github.com/jtdubs/dotfiles.git
pushd dotfiles
pip3 install -r requirements.txt
./sync.py
popd
cp .xsession .xinitrc

echo "Installing nvim plugins..."
rm -Rf ~/.config/nvim/plugged/lightline.vim/
nvim --headless +PlugInstall +CocUpdate +qa || true

echo "Installing dotfiles (final)..."
pushd ~/dotfiles
./sync.py
popd

echo "Validating nvim setup..."
nvim --headless +PlugInstall +CocUpdate +qa
