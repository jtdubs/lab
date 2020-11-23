#!/usr/bin/env bash

set -eu

echo "Installing VirtualBox tools..."
pacman -S --needed --noconfirm virtualbox-guest-utils
systemctl enable vboxservice.service
