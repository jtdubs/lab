#!/bin/bash

set -eu

echo '' | sudo -S apt-get install --yes build-essential fish git neovim nodejs python3-pip tmux

cd /home/jtdubs

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
