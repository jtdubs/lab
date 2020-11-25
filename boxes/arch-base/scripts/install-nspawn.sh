#!/usr/bin/env bash

set -eu

echo "Enabling services..."
systemctl enable NetworkManager.service
systemctl enable sshd.service

if [ -e /install-guest-tools.sh ]
then
    chmod a+x /install-guest-tools.sh
    /install-guest-tools.sh
fi
