Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Rolling back VMs..."
vagrant snapshot restore dc joined
vagrant snapshot restore web ready
vagrant snapshot restore user member
vagrant snapshot restore dev member

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Done."