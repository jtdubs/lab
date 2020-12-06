Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module GroupPolicy

$gpo = New-GPO -Name "Enable Credential Delegation"

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation" `
    -ValueName "AllowFreshCredentials" `
    -Type DWord `
    -Value 1

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation" `
    -ValueName "ConcatenateDefaults_AllowFresh" `
    -Type DWord `
    -Value 1

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation" `
    -ValueName "AllowFreshCredentialsWhenNTLMOnly" `
    -Type DWord `
    -Value 1

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation" `
    -ValueName "ConcatenateDefaults_AllowFreshNTLMOnly" `
    -Type DWord `
    -Value 1

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials" `
    -ValueName 1 `
    -Type String `
    -Value WSMAN/*.lab.dubs.zone

$gpo | Set-GPRegistryValue `
    -Key "HKLM\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly" `
    -ValueName 1 `
    -Type String `
    -Value WSMAN/*.lab.dubs.zone

$gpo | New-GPLink -Target "DC=lab,DC=dubs,DC=zone" -LinkEnabled Yes