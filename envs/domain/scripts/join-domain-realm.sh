#!/bin/bash

set -eu

domain="lab.dubs.zone"
domain_dn="DC=lab,DC=dubs,DC=zone"
dc_ip="192.168.64.8"

# add domain to hostname
hostnamectl set-hostname "$(hostname).$domain"

# fix dns
systemctl disable systemd-resolved
systemctl stop systemd-resolved
unlink /etc/resolv.conf
cat > /etc/resolv.conf <<EOF
nameserver $dc_ip
search lab.dubs.zone
EOF

# install realm
export DEBIAN_FRONTEND=noninteractive
apt-get install -y realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit krb5-user

# setup realm config
cat > /etc/realmd.conf <<EOF
[users]
default-home = /home/%D/%U
default-shell = /bin/bash
[active-directory]
default-client = sssd
os-name = $(bash -c 'source /etc/os-release && echo $NAME')
os-version = $(bash -c 'source /etc/os-release && echo $VERSION')
[service]
automatic-install = no
[$domain]
fully-qualified-names = no
automatic-id-mapping = yes
user-principal = yes
manage-system = yes
EOF

# create kerberos config
cat >/etc/krb5.conf <<EOF
[libdefaults]
default_realm = ${domain^^}
rdns = no
dns_lookup_kdc = true
dns_lookup_realm = true
[realms]
${domain^^} = {
    kdc = dc.$domain
    admin_server = dc.$domain
}
EOF

# join domain
realm discover $domain
echo "sup3rs3cr3t!" | kinit "administrator@${domain^^}"
realm join $domain --unattended
kdestroy

# allow login for all domain users
realm permit --all

# setup auto-home creation
sudo bash -c "cat > /usr/share/pam-configs/mkhomedir" <<EOF
Name: activate mkhomedir
Default: yes
Priority: 900
Session-Type: Additional
Session:
        required                        pam_mkhomedir.so umask=0077 skel=/etc/skel
EOF
pam-auth-update --package --enable mkhomedir --force

# restart sssd
systemctl restart sssd

# allow domain administrators to use sudo without asking for password.
cat >/etc/sudoers.d/domain-admins <<'EOF'
# Allow members of the domain admins group to execute
# any command (as root) without asking for password.
%domain\ admins ALL=(ALL) NOPASSWD:ALL
EOF
chmod 0440 /etc/sudoers.d/domain-admins