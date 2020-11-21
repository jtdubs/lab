#!/bin/bash

set -eu

echo "Installing updates..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get upgrade -y