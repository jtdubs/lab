Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$dcIp = "192.168.64.8"

Write-Host "Configuring DNS..."
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses $dcIp

Write-Host "Configuring NTP..."
Push-Location
Set-Location HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers
Set-ItemProperty . 0 "dc.$domain"
Set-ItemProperty . "(Default)" "0"
Set-Location HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Parameters
Set-ItemProperty . NtpServer "dc.$domain"
Pop-Location

Write-Host "Updating time..."
Restart-Service w32time
Start-Sleep -Seconds 1

Write-Host "Joining domain..."
Add-Computer `
    -DomainName $domain `
    -Credential (New-Object `
                    System.Management.Automation.PSCredential(
                        "vagrant@$domain",
                        (ConvertTo-SecureString "vagrant" -AsPlainText -Force)))