Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Creating RSAT tools..."
Install-WindowsFeature RSAT
Install-WindowsFeature RSAT-Role-Tools -IncludeAllSubFeature