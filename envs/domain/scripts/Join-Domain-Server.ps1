Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$dcIp = "192.168.64.8"

# set DNS to use the DC
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses $dcIp

# point NTP to the DC
Push-Location
Set-Location HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers
Set-ItemProperty . 0 "dc.$domain"
Set-ItemProperty . "(Default)" "0"
Set-Location HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Parameters
Set-ItemProperty . NtpServer "dc.$domain"
Pop-Location

# update time
Restart-Service w32time
Start-Sleep -Seconds 1

# add the machine to the domain.
Add-Computer `
    -DomainName $domain `
    -Credential (New-Object `
                    System.Management.Automation.PSCredential(
                        "vagrant@$domain",
                        (ConvertTo-SecureString "vagrant" -AsPlainText -Force)))

# install helpful tools
Add-WindowsFeature RSAT
Install-WindowsFeature RSAT-Role-Tools -IncludeAllSubFeature

# enable CredSSP for remote powershell credential delegation
Enable-WSManCredSSP -Force Server