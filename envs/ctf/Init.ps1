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

Log "Bringing up Win10..."
Exec { vagrant up win10 --no-provision }
Exec { vagrant snapshot save --force win10 initial }
Exec { vagrant provision win10 --provision-with share }
Exec { vagrant snapshot save --force win10 ready }

Log "Brining up Kali..."
Exec { vagrant up kali --no-provision }
Exec { vagrant snapshot save --force kali initial }
Exec { vagrant provision kali --provision-with kali,common }
Exec { vagrant snapshot save --force kali customized }
Exec { vagrant provision kali --provision-with share }
Exec { vagrant snapshot save --force kali ready }

Log "Done."