Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

vagrant up dc
vagrant snapshot save dc provisioned

vagrant up web
vagrant snapshot save web provisioned

vagrant up user
vagrant snapshot save user provisioned

vagrant up dev
vagrant snapshot save dev provisioned

vagrant snapshot save dc domain_up

vagrant up hacker
vagrant snapshot save hacker provisioned
