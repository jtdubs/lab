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

Log "Rolling back VMs..."
Exec { vagrant snapshot restore dc   ready   }
Exec { vagrant snapshot restore web  sysprep }
Exec { vagrant snapshot restore user sysprep }
Exec { vagrant snapshot restore dev  initial }

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
Exec { vagrant provision web --provision-with web,sql }
Exec { vagrant snapshot save --force web ready }

Log "Setting up User..."
Exec { vagrant provision user --provision-with web,sql }
Exec { vagrant snapshot save --force user ready }

Log "Done."