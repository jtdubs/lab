$ErrorActionPreference="Stop"

Add-AppxPackage -DisableDevelopmentMode -Register ((Get-AppxPackage -AllUsers "CanonicalGroupLimited.Ubuntu20.04onWindows").InstallLocation + "\AppxManifest.xml")
Add-AppxPackage -DisableDevelopmentMode -Register ((Get-AppxPackage -AllUsers "Microsoft.WindowsTerminal").InstallLocation + "\AppxManifest.xml")

return 0
