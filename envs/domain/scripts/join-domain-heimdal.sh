#!/bin/bash

set -eu

domain="lab.dubs.zone"
domain_dn="DC=lab,DC=dubs,DC=zone"
dc_ip="192.168.64.8"

# add domain to hostname
hostnamectl set-hostname "$(hostname).$domain"

# add DC entry to hosts file
echo "$dc_ip dc.$domain" >> /etc/hosts

# install kerberos tools
export DEBIAN_FRONTEND=noninteractive
apt-get install -y sssd heimdal-clients msktutil ntpdate

# sync time with AD
ntpdate dc.lab.dubs.zone

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
kinit --password-file=STDIN administrator <<'EOF'
sup3rs3cr3t!
EOF
msktutil \
    --create \
    --keytab /etc/sssd/sssd.keytab \
    --no-reverse-lookups \
    --server dc.$domain \
    --user-creds-only
ldapmodify \
    -h dc.$domain \
    <<EOF
dn: CN=$(hostname | cut -d'.' -f1),CN=Computers,$domain_dn
changeType: modify
replace: operatingSystem
operatingSystem: $(bash -c 'source /etc/os-release && echo $NAME')
-
replace: operatingSystemVersion
operatingSystemVersion: $(bash -c 'source /etc/os-release && echo $VERSION')
-
EOF
ldapsearch \
  -h dc.$domain \
  -b CN=Computers,$domain_dn \
  '(objectClass=computer)'
ktutil --keytab=/etc/sssd/sssd.keytab list
kdestroy

# configure sssd
cat >/etc/sssd/sssd.conf <<EOF
[sssd]
config_file_version = 2
services = nss, pam
domains = $domain
[nss]
entry_negative_timeout = 0
#debug_level = 5
[pam]
#debug_level = 5
[domain/$domain]
#debug_level = 10
enumerate = false
id_provider = ad
auth_provider = ad
chpass_provider = ad
access_provider = ad
dyndns_update = false
fallback_homedir = /home/%d/%u
default_shell = /bin/bash
ad_server = dc.$domain
ad_domain = $domain
ldap_schema = ad
ldap_id_mapping = true
ldap_sasl_mech = gssapi
ldap_krb5_init_creds = true
krb5_keytab = /etc/sssd/sssd.keytab
EOF
chmod 0600 /etc/sssd/sssd.conf

# restart sssd to apply the configuration.
systemctl restart sssd || (sleep 20 && systemctl restart sssd)

# configure pam to automatically create the home directory.
cat > /usr/share/pam-configs/mkhomedir <<EOF
Name: activate mkhomedir
Default: yes
Priority: 900
Session-Type: Additional
Session:
        required                        pam_mkhomedir.so umask=0077 skel=/etc/skel
EOF
pam-auth-update --package --enable mkhomedir --force

# allow domain administrators to use sudo without asking for password.
cat >/etc/sudoers.d/domain-admins <<'EOF'
# Allow members of the domain admins group to execute
# any command (as root) without asking for password.
%domain\ admins ALL=(ALL) NOPASSWD:ALL
EOF
chmod 0440 /etc/sudoers.d/domain-admins