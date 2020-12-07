Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
 
function Exec {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [scriptblock]
        $Command,
        [Parameter()]
        [int]
        $Success=0
    )
    & $Command
    if ($LastExitCode -ne $Success) {
        Write-Host "Exec failed with: $LastExitCode (expected $Success)"
        exit $LastExitCode
    }
    return $LastExitCode
}

function Log {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Message
    )
    Write-Host (Get-Date -Format "HH:mm:ss.ffff"), "-", $Message
}

Log "Prepping DC..."
Exec { vagrant up dc --no-provision }
Exec { vagrant snapshot save --force dc initial }
Exec { vagrant provision dc --provision-with windows-sysprep }
Exec { vagrant snapshot save --force dc sysprep }

Log "Prepping Web..."
Exec { vagrant up web --no-provision }
Exec { vagrant snapshot save --force web initial }
Exec { vagrant provision web --provision-with windows-sysprep }
Exec { vagrant snapshot save --force web sysprep }

Log "Prepping User..."
Exec { vagrant up user --no-provision }
Exec { vagrant snapshot save --force user initial }
Exec { vagrant provision user --provision-with windows-sysprep }
Exec { vagrant snapshot save --force user sysprep }

Log "Prepping Dev..."
Exec { vagrant up dev --no-provision }
Exec { vagrant snapshot save --force dev initial }

Log "Creating Domain..."
Exec { vagrant provision dc --provision-with tools,forest,dc,share,ca,users,kds,gpo,credssp }
Exec { vagrant snapshot save --force dc ready }

Log "Setting up Hacker..."
Exec { vagrant up hacker --no-provision }
Exec { vagrant snapshot save --force hacker initial }
Exec { vagrant provision hacker --provision-with setup }
Exec { vagrant snapshot save --force hacker ready }

Log "Joining Web..."
Exec { vagrant provision web --provision-with tools,join,credssp }
Exec { vagrant snapshot save --force web member }

Log "Joining User..."
Exec { vagrant provision user --provision-with tools,join,credssp }
Exec { vagrant snapshot save --force user member }

Log "Joining Dev..."
Exec { vagrant provision dev --provision-with join }
Exec { vagrant snapshot save --force dev member }

Log "Snapshotting domain..."
Exec { vagrant snapshot save --force dc joined }

Log "Setting up Web..."
$env:VAGRANT_EXPERIMENTAL = "disks"
Exec { vagrant reload web }
Remove-Item Env:\VAGRANT_EXPERIMENTAL
Exec { vagrant provision web --provision-with web,sql }
Exec { vagrant snapshot save --force web ready }

Log "Done."