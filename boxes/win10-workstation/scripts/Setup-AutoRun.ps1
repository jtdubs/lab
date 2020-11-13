$ErrorActionPreference="Stop"

New-Item -Path "registry::HKCU\TSoftware\Microsoft\Windows\CurrentVersion" -Name "RunOnce"
New-ItemProperty -Path "registry::HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "First Logon" -Value "powershell.exe C:\ProgramData\Vagrant\Run-Once.ps1" -PropertyType "String"

return 0
