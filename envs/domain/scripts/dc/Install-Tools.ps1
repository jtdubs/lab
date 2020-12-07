Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Configuring NTP..."
w32tm /config /manualpeerlist:time.google.com /syncfromflags:manual /reliable:yes /update
w32tm /resync

Write-Host "Installing RSAT..."
Install-WindowsFeature RSAT,RSAT-AD-AdminCenter,RSAT-ADDS-Tools
Install-WindowsFeature RSAT-Role-Tools -IncludeAllSubFeature