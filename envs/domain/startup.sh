#!/bin/sh

vagrant up --parallel

tmux \
    new-session -s domain -n dc     "vagrant powershell dc"     \; \
    new-window            -n web    "vagrant powershell web"    \; \
    new-window            -n gamer  "vagrant powershell gamer"  \; \
    new-window            -n hacker "vagrant ssh        hacker"
