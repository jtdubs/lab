#!/usr/bin/env bash

set -eu

echo "Setting hostname..."
echo ubuntu-workstation > /etc/hostname
sed -i 's/ubuntu-base/ubuntu-workstation/' /etc/hosts