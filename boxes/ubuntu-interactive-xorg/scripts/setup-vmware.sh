#!/bin/bash

set -eu

echo "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y --no-install-recommends xserver-xorg-video-vmware