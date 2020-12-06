Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Installing RSAT..."
Install-WindowsFeature RSAT
Install-WindowsFeature RSAT-Role-Tools -IncludeAllSubFeature