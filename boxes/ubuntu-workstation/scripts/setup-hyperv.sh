#!/usr/bin/env bash

set -eu

echo "Preparing for Enhanced Session Support..."
git clone https://github.com/Microsoft/linux-vm-tools
cd linux-vm-tools/ubuntu/18.04
sed -i 's/^HWE=""/HWE="-hwe-20.04"/' install.sh
chmod a+x install.sh
./install.sh

echo "Fixing xrdp config..."
sed -i 's/^port=3389/port=vsock:\/\/-1:3389/' /etc/xrdp/xrdp.ini
sed -i 's/^use_vsock=true/use_vsock=false/' /etc/xrdp/xrdp.ini