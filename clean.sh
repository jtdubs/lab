#!/bin/sh

find . -type d -name "output*" -exec rm -Rf {} \; 2>/dev/null
find . -type d -name "packer_cache" -exec rm -Rf {} \; 2>/dev/null
find . -type f -name "*.box" -delete
