#!/bin/bash

set -eu

domain="lab.dubs.zone"
domain_dn="DC=lab,DC=dubs,DC=zone"
dc_ip="192.168.64.8"
account="Administrator"
password="sup3rs3cr3t!"

echo "Updating hostname..."
hostnamectl set-hostname "$(hostname).$domain"

echo "Adding hosts entry for DC..."
echo "$dc_ip dc.$domain" >> /etc/hosts

echo "Pointing to DC for DNS services..."
systemctl disable systemd-resolved
systemctl stop systemd-resolved
unlink /etc/resolv.conf
cat > /etc/resolv.conf <<EOF
nameserver $dc_ip
search lab.dubs.zone
EOF

echo "Pointing to DC for NTP services..."
ntpdate dc.lab.dubs.zone
sed -i 's/#NTP=/NTP=dc.lab.dubs.zone/' /etc/systemd/timesyncd.conf 
sed -i 's/#RootDistanceMaxSec=.*/RootDistanceMaxSec=31536000/' /etc/systemd/timesyncd.conf 
systemctl restart systemd-timesyncd

echo "Install AD tools..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y ntpdate sssd sssd-tools heimdal-clients msktutil realmd adcli smbclient

echo "Configuring realmd..."
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

echo "Configuring krb5..."
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

echo "Configuring sssd..."
cat >/etc/sssd/sssd.conf <<EOF
[sssd]
config_file_version = 2
services = nss, pam
domains = 
[nss]
entry_negative_timeout = 0
#debug_level = 5
[pam]
#debug_level = 5
EOF
chmod 0600 /etc/sssd/sssd.conf

echo "Authenticating to domain..."
kinit --password-file=STDIN $account <<EOF
$password
EOF

echo "Joining domain..."
realm join $domain \
  --os-name="$(source /etc/os-release && echo $NAME)" \
  --os-version="$(source /etc/os-release && echo $VERSION)" \
  --unattended \
  --verbose

echo "Trusting domain CA..."
pushd /tmp
echo "get domain_root.der" | smbclient -k \\\\dc.$domain\\DomainShare
popd
openssl x509 \
    -inform der \
    -in /tmp/domain_root.der \
    -out /usr/local/share/ca-certificates/$domain.crt
update-ca-certificates --verbose

echo "Logging out..."
kdestroy

echo "Enabling local login for all domain users..."
realm permit --all

echo "Configuring PAM to create home directories automatically..."
cat > /usr/share/pam-configs/mkhomedir <<EOF
Name: activate mkhomedir
Default: yes
Priority: 900
Session-Type: Additional
Session:
        required                        pam_mkhomedir.so umask=0077 skel=/etc/skel
EOF
pam-auth-update --package --enable mkhomedir --force

echo "Enabling sudo for domain admins..."
cat >/etc/sudoers.d/domain-admins <<'EOF'
# Allow members of the domain admins group to execute
# any command (as root) without asking for password.
%domain\ admins ALL=(ALL) NOPASSWD:ALL
EOF
chmod 0440 /etc/sudoers.d/domain-admins