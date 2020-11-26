#!/bin/sh

tmux \
    new-session -s domain "vagrant powershell dc"     \; \
    split-window -h -t 1  "vagrant powershell web"    \; \
    split-window -v -t 1  "vagrant powershell gamer"  \; \
    split-window -v -t 3  "vagrant ssh        hacker"
