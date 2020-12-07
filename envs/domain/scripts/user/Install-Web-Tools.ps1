Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Installing IIS Management Console..."
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -All
msiexec /i "C:\Windows\Temp\inetmgr_amd64_en-US.msi" /qn