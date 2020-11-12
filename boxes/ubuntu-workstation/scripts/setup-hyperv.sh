#!/usr/bin/env bash

set -eu

echo "Preparing for Enhanced Session Support..."
git clone https://github.com/Microsoft/linux-vm-tools
cd linux-vm-tools/ubuntu/18.04
sed -i 's/^HWE=""/HWE="-hwe-20.04"/' install.sh
chmod a+x install.sh
./install.sh