Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$dcIp = "192.168.64.8"

# set DNS to use the DC
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses $dcIp

# add the machine to the domain.
Add-Computer `
    -DomainName $domain `
    -Credential (New-Object `
                    System.Management.Automation.PSCredential(
                        "vagrant@$domain",
                        (ConvertTo-SecureString "vagrant" -AsPlainText -Force)))

# install helpful tools
Add-WindowsFeature RSAT