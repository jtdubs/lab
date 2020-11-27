Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$nbDomain = "LAB"
$password = ConvertTo-SecureString "sup3rs3cr3t!" -AsPlainText -Force

Write-Host "Setting admin password..."
Set-LocalUser `
    -Name Administrator `
    -AccountNeverExpires `
    -Password $password `
    -PasswordNeverExpires:$true `
    -UserMayChangePassword:$true

Write-Host "Disabling admin account..."
Disable-LocalUser -Name Administrator

Write-Host "Installing AD Services..."
Install-WindowsFeature AD-Domain-Services,RSAT-AD-AdminCenter,RSAT-ADDS-Tools

Write-Host "Creating AD Forest..."
Import-Module ADDSDeployment
Install-ADDSForest `
    -InstallDns `
    -CreateDnsDelegation:$false `
    -ForestMode 'WinThreshold' `
    -DomainMode 'WinThreshold' `
    -DomainName $domain `
    -DomainNetbiosName $nbDomain `
    -SafeModeAdministratorPassword $password `
    -NoRebootOnCompletion `
    -Force
