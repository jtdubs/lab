Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Creating KDS Root Key..."
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))