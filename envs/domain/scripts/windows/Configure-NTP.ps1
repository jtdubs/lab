Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$domain = "lab.dubs.zone"
$dc = "dc.$domain"

Write-Host "Configuring NTP..."

Set-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config" `
    -Name "MaxNegPhaseCorrection" `
    -Type DWord `
    -Value 0xffffffff

Set-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config" `
    -Name "MaxPosPhaseCorrection" `
    -Type DWord `
    -Value 0xffffffff

w32tm /config /manualpeerlist:$dc /syncfromflags:domhier /update