Set-StrictMode -Version Latest
$ErrorActionPreference="Stop" 

# Install Windows Terminal settings
Copy-Item -Path C:\ProgramData\Vagrant\settings.json -Destination ("$env:LOCALAPPDATA\Packages\" + (Get-AppxPackage "Microsoft.WindowsTerminal").PackageFamilyName + "\LocalState")

# Setup Ubuntu WSL
ubuntu2004.exe install --root
wsl bash /mnt/c/ProgramData/Vagrant/WSL-Prep.sh
ubuntu2004.exe config --default-user vagrant
wsl bash /mnt/c/ProgramData/Vagrant/WSL-First-Logon.sh

Write-Output "done" > $env:USERPROFILE\run-once-complete.txt

return 0
