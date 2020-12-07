Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Installing RSAT..."
Install-WindowsFeature RSAT,RSAT-AD-AdminCenter,RSAT-ADDS-Tools
Install-WindowsFeature RSAT-Role-Tools -IncludeAllSubFeature
Set-PsDebug -Trace 0