Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

vagrant up dc
vagrnat up web
vagrnat up user
vagrnat up dev
vagrnat up hacker