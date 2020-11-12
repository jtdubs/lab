#!/usr/bin/env bash

set -eu

pushd /root

echo "Preparing for Enhanced Session Support..."
git clone https://github.com/Microsoft/linux-vm-tools
cd linux-vm-tools/ubuntu/18.04
chmod a+x install.sh
./install.sh

popd