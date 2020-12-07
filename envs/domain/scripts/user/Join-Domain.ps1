Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$dcIp = "192.168.64.8"

Write-Host "Configuring DNS..."
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses $dcIp

Write-Host "Joining domain..."
Add-Computer `
    -DomainName $domain `
    -Credential (New-Object `
                    System.Management.Automation.PSCredential(
                        "vagrant@$domain",
                        (ConvertTo-SecureString "vagrant" -AsPlainText -Force)))