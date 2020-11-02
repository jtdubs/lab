#!/usr/bin/env bash

useradd -p $(/usr/bin/openssl passwd -crypt 'packer') -m -U packer

cat > /etc/sudoers.d/10_packer <<EOF
Defaults env_keep += "SSH_AUTH_SOCK"
packer ALL=(ALL) NOPASSWD: ALL
EOF

chmod 0440 /etc/sudoers.d/10_packer
systemctl start sshd.service
