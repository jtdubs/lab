#!/usr/bin/env bash

set -eu

echo "Setting hostname..."
echo kali-workstation > /etc/hostname
sed -i 's/kali-base/kali-workstation/' /etc/hosts