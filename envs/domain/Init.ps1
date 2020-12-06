Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Prepping DC..."
vagrant up dc --no-provision
vagrant snapshot save --force dc initial
vagrant provision dc --provision-with=windows-sysprep
vagrant snapshot save --force dc sysprep

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Prepping Web..."
$env:VAGRANT_EXPERIMENTAL = "disks"
vagrant up web --no-provision
Remove-Item Env:\VAGRANT_EXPERIMENTAL
vagrant snapshot save --force web initial
vagrant provision web --provision-with=windows-sysprep
vagrant snapshot save --force web sysprep

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Prepping User..."
vagrant up user --no-provision
vagrant snapshot save --force user initial
vagrant provision user --provision-with=windows-sysprep
vagrant snapshot save --force user sysprep

Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Prepping Dev..."
vagrant up dev --no-provision
vagrant snapshot save --force dev initial


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Creating Domain..."
vagrant provision dc --provision-with=tools,forest,dc,share,ca,users,kds,gpo,credssp
vagrant snapshot save --force dc ready


Write-Host (Get-Date -Format "HH:mm:ss.ffff"), " - Setting up Hacker..."
vagrant up hacker --no-provision
vagrant snapshot save --force hacker initial
vagrant provision hacker --provision-with=setup
vagrant snapshot save --force hacker ready


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