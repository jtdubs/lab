#!/usr/bin/env bash

set -eu

echo "Installing VMWare tools..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y open-vm-tools-desktop
