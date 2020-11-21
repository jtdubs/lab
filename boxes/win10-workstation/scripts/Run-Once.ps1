Set-StrictMode -Version Latest
$ErrorActionPreference="Stop" 

# Explorer Settings
Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name "DragFullWindows" -Value 1
Get-Item "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    | Set-ItemProperty -Name "Hidden"      -Value 1
    | Set-ItemProperty -Name "HideFileExt" -Value 0
    | Set-ItemProperty -Name "LaunchTo"    -Value 1

# Start Menu Settings
Get-Item HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband `
    | Set-ItemProperty -Name "Favorites"               -Value 0xff `
    | Set-ItemProperty -Name "FavoritesResolve"        -Value 0xff `
    | Set-ItemProperty -Name "FavoritesVersion"        -Value 3    `
    | Set-ItemProperty -Name "FavoritesChanges"        -Value 1    `
    | Set-ItemProperty -Name "FavoritesRemovedChanges" -Value 1

# Taskbar Settings
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Search"            -Name "SearchboxTaskbarMode" -Value 0
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton"   -Value 0
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton"    -Value 0

# Disabling Microsoft Consumer Experience
New-Item -Force "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" `
    | Set-ItemProperty -Name "DisableWindowsConsumerFeatures" -Value 1

# Disable OneDrive
New-Item -Force "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" `
    | Set-ItemProperty -Name "DisableFileSyncNGSC" -Value 1
Remove-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDrive" -Force

# Unpin Taskbar Icons
$pinnedTaskbarPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
(New-Object -Com Shell.Application).NameSpace($pinnedTaskbarPath).Items() `
    | ForEach-Object {
        $unpinVerb = $_.Verbs() | Where-Object { $_.Name -eq "Unpin from tas&kbar" }
        if ($unpinVerb) {
            $unpinVerb.DoIt()
        } else {
            $shortcut = (New-Object -Com WScript.Shell).CreateShortcut($_.Path)
            if (!$shortcut.TargetPath -and ($shortcut.IconLocation -eq '%windir%\explorer.exe,0')) {
                Remove-Item -Force $_.Path
            }
        }
    }

# Clean-up Desktop
Remove-Item "C:\Users\Public\Desktop\*.lnk"
Remove-Item "C:\Users\Public\Vagrant\*.lnk"

# Restart Explorer
(Get-Process "explorer").Kill()

# Install Windows Terminal settings
Copy-Item `
    -Path "C:\ProgramData\Vagrant\settings.json" `
    -Destination ("$env:LOCALAPPDATA\Packages\" + (Get-AppxPackage "Microsoft.WindowsTerminal").PackageFamilyName + "\LocalState")

# Setup Ubuntu WSL
ubuntu2004.exe install --root
wsl bash /mnt/c/ProgramData/Vagrant/WSL-Prep.sh
ubuntu2004.exe config --default-user vagrant
wsl bash /mnt/c/ProgramData/Vagrant/WSL-First-Logon.sh

Write-Output "done" > $env:USERPROFILE\run-once-complete.txt

return 0
