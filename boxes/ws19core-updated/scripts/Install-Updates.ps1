Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

Invoke-WUJob -RunNow -Confirm:$false -Verbose -Script {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
    Import-Module PSWindowsUpdate
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot | Out-File C:\Users\Vagrant\WindowsUpdateLog.txt -Append
}

Start-Sleep -Seconds 5.0

while ((Get-ScheduledTask -TaskName PSWindowsUpdate).State -eq "Running") {
    Start-Sleep -Seconds 10.0
}

return 0
