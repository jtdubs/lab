Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Installing RSAT..."
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online