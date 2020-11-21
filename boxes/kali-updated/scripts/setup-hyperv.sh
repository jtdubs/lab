#!/bin/bash

set -eu

echo "Preparing for Enhanced Session Support..."
git clone https://github.com/mimura1133/linux-vm-tools
pushd linux-vm-tools/kali/2020.x
chmod a+x install.sh
sudo ./install.sh
popd
rm -Rf linux-vm-tools