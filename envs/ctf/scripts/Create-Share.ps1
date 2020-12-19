Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Creating share..."

New-Item -Type Directory -Path C:\Users\Vagrant\Desktop\share

New-SmbShare -Name "share" -Path "C:\Users\Vagrant\Desktop\share"

Grant-SmbShareAccess `
    -Name "share" `
    -AccountName "Vagrant" `
    -AccessRight Full `
    -Force