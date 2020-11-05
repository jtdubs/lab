#!/bin/bash

set -eu

echo "Installing packages..."
sudo pacman -S --noconfirm \
    alacritty bspwm dmenu exa feh firefox fish git \
    lightdm lightdm-gtk-greeter neovim network-manager-applet \
    nodejs numlockx picom pulseaudio pulseaudio-alsa \
    python python-pip sxhkd tmux xf86-video-vmware xorg-server \
    xorg-xrdb xorg-xsetroot yarn

yay -S --noconfirm polybar xinit-xsession


echo "Enabling Window Manager..."
sudo systemctl enable lightdm.service


echo "Creating jtdubs user..."
sudo useradd -c "Justin Dubs" -U -G wheel -s /usr/bin/fish -m -p $(/usr/bin/openssl passwd -crypt '') jtdubs


echo "Creating sudoers entry..."
echo "jtdubs ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/10_jtdubs
sudo chown root:root /etc/sudoers.d/10_jtdubs
sudo chmod 0440 /etc/sudoers.d/10_jtdubs
