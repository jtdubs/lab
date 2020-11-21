#!/usr/bin/env bash

useradd -p $(/usr/bin/openssl passwd -crypt 'vagrant') -m -U vagrant

cat > /etc/sudoers.d/10_vagrant <<EOF
Defaults env_keep += "SSH_AUTH_SOCK"
vagrant ALL=(ALL) NOPASSWD: ALL
EOF

chmod 0440 /etc/sudoers.d/10_vagrant
systemctl start sshd.service

pacman -Sy --noconfirm hyperv
systemctl start hv_fcopy_daemon.service
systemctl start hv_kvp_daemon.service
systemctl start hv_vss_daemon.service
