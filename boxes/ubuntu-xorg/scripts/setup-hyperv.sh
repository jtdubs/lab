#!/usr/bin/env bash

set -eu

cd /home/vagrant

echo "Preparing for Enhanced Session Support..."
git clone https://github.com/Microsoft/linux-vm-tools
pushd linux-vm-tools/ubuntu/18.04
sed -i 's/^HWE=""/HWE="-hwe-20.04"/' install.sh
chmod a+x install.sh
sudo ./install.sh
popd
rm -Rf linux-vm-tools

echo "Fixing xrdp config..."
sudo sed -i 's/^port=3389/port=vsock:\/\/-1:3389/' /etc/xrdp/xrdp.ini
sudo sed -i 's/^use_vsock=true/use_vsock=false/' /etc/xrdp/xrdp.ini