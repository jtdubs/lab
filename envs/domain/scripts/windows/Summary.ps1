Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Computer Info:"
Get-ComputerInfo `
    | Select-Object -Property `
        CsName, CsDomain, CsDomainRole, CsPCSystemType,
        OsName, OsVersion,
        @{ L="TotalMemory"; E={ "{0:N2}MB" -f ($_.OsTotalVisibleMemorySize / 1024) } },
        @{ L="FreeMemory"; E={ "{0:N2}MB" -f ($_.OsFreePhysicalMemory / 1024) } } `
    | Out-Host

Write-Host "Disk Info:"
Get-WmiObject -Class Win32_LogicalDisk `
    | Where-Object -Property DriveType -EQ -Value 3 `
    | Select-Object -Property DeviceID, VolumeName,
        @{ L="Available"; E={ "{0:N2}GB" -f ($_.FreeSpace / 1GB) } },
        @{ L="Capacity"; E={ "{0:N2}GB" -f ($_.Size/ 1GB) } } `
    | Format-Table -AutoSize `
    | Out-Host

Write-Host "Domain Info:"
Get-ADDomain `
    | Select-Object -Property Forest,DomainMode,DNSRoot,NetBIOSName,PDCEmulator,InfrastructureMaster `
    | Out-Host

Write-Host "Local Users:"
Get-LocalUser `
    | Out-Host

Write-Host "Local Administrators:"
Get-LocalGroupMember Administrators `
    | Out-Host