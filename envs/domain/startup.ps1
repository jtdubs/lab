Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

vagrant up dc
vagrant up web
vagrant up user
vagrant up dev
vagrant up hacker