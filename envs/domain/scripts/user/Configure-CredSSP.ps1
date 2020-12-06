Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Enabling CredSSP delegation within domain..."
Enable-WSManCredSSP -Force -Role Client -DelegateComputer "*.lab.dubs.zone"
Enable-WSManCredSSP -Force -Role Server