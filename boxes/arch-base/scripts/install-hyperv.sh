#!/usr/bin/env bash

set -eu

echo "Installing Hyper-V tools..."
pacman -Sy --noconfirm hyperv
systemctl enable hv_fcopy_daemon.service
systemctl enable hv_kvp_daemon.service
systemctl enable hv_vss_daemon.service
