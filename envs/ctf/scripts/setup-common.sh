#!/bin/bash

set -eu

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

echo "Creating xinitrc..."
if [ -e /etc/release -a $(source /etc/release; echo $ID) = "arch"]
then
    ln -s ~/.xsession ~/.xinitrc
fi