#!/usr/bin/env bash

set -eu

echo "Cleaning up..."
rm /mnt/install*.sh
umount /mnt/boot
umount /mnt
