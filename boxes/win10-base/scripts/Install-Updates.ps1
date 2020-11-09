Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

$counter = 1
while ($counter -gt 0) {
    $counter = (Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot).Count
}
