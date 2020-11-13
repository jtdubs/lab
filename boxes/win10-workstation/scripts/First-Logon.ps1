$ErrorActionPreference="Stop"

# Register packages
Add-AppxPackage -DisableDevelopmentMode -Register ((Get-AppxPackage -AllUsers "CanonicalGroupLimited.Ubuntu20.04onWindows").InstallLocation + "\AppxManifest.xml")
Add-AppxPackage -DisableDevelopmentMode -Register ((Get-AppxPackage -AllUsers "Microsoft.WindowsTerminal").InstallLocation + "\AppxManifest.xml")

# Setup Ubuntu WSL
ubuntu2004.exe install --root
wsl bash /mnt/c/ProgramData/Packer/WSL-Prep.sh
ubuntu2004.exe config --default-user jtdubs
wsl bash /mnt/c/ProgramData/Packer/WSL-First-Logon.sh

return 0
