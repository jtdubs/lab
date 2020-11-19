Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot

return 0
