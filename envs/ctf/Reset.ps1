Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

$env:VAGRANT_DEFAULT_PROVIDER = "virtualbox"

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
Exec { vagrant snapshot restore win10 ready }
Exec { vagrant snapshot restore kali  ready }

Log "Done."