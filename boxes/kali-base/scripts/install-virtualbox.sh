#!/usr/bin/env bash

set -eu

echo "Installing VirtualBox tools..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y virtualbox-guest-x11
