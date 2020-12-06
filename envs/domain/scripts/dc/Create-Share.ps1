Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Creating share..."

New-Item -Type Directory -Path C:\DomainShare

New-SmbShare -Name "DomainShare" -Path "C:\DomainShare"

Grant-SmbShareAccess `
    -Name "DomainShare" `
    -AccountName "Domain Admins" `
    -AccessRight Full `
    -Force

Grant-SmbShareAccess `
    -Name "DomainShare" `
    -AccountName "Domain Users" `
    -AccessRight Read `
    -Force