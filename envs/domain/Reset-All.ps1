Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Rolling back VMs..."
vagrant snapshot restore dc sysprep
vagrant snapshot restore web sysprep
vagrant snapshot restore user sysprep
vagrant snapshot restore dev initial


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Creating Domain..."
vagrant provision dc --provision-with=tools,forest,dc,share,ca,users,kds,gpo,credssp
vagrant snapshot save --force dc ready


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Joining Web..."
vagrant provision web --provision-with=tools,join,credssp
vagrant snapshot save --force web member

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Joining User..."
vagrant provision user --provision-with=tools,join,credssp
vagrant snapshot save --force user member

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Joining Dev..."
vagrant provision dev --provision-with=join
vagrant snapshot save --force dev member


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Snapshotting domain..."
vagrant snapshot save --force dc joined


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Setting up Web..."
vagrant provision web --provision-with=web,sql
vagrant snapshot save --force web ready


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Done."