#!/usr/bin/env bash

set -eu

echo "Setting hostname..."
echo arch-workstation > /etc/hostname
sed -i 's/arch-base/arch-workstation/' /etc/hosts