#!/bin/bash

set -eu

echo "Installing updates..."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get update
sudo -E apt-get upgrade -y