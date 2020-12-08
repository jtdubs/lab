Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Creating Web gMSA..."
New-ADServiceAccount MSA-Web -DNSHostName "web.lab.dubs.zone" -ServicePrincipalNames http/web.lab.dubs.zone, http/web -Verbose
Set-ADServiceAccount MSA-Web -PrincipalsAllowedToRetrieveManagedPassword Web$
Install-ADServiceAccount MSA-Web

Write-Host "Installing IIS..."
Install-WindowsFeature Web-Server -IncludeManagementTools
Install-WindowsFeature Web-Ftp-Server -IncludeManagementTools
Install-WindowsFeature Web-Mgmt-Service
netsh advfirewall firewall add rule name="IIS Remote Management" dir=in action=allow service=WMSVC
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\WebManagement\Server EnableRemoteManagement 1
Set-Service -Name WMSVC -StartupType Automatic
Start-Service -Name WMSVC