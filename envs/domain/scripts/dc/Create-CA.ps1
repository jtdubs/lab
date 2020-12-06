Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domainDn = (Get-ADDomain).DistinguishedName
$caCommonName = 'Lab Root CA'

Write-Host "Install CA feature..."
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools

Write-Host "Creating CA..."
Install-AdcsCertificationAuthority `
    -CAType EnterpriseRootCa `
    -CACommonName $caCommonName `
    -HashAlgorithmName SHA256 `
    -KeyLength 4096 `
    -ValidityPeriodUnits 8 `
    -ValidityPeriod Years `
    -Force

Write-Host "Exporting root cert..."
Get-ChildItem Cert:\LocalMachine\My -DnsName $caCommonName `
    | Export-Certificate -FilePath "C:\DomainShare\domain_root.der" `
    | Out-Null