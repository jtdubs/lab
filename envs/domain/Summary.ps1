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

Log "Generating summaries..."
Exec { vagrant provision dc   --provision-with summary }
Exec { vagrant provision web  --provision-with summary }
Exec { vagrant provision user --provision-with summary }

Log "Done."