param (
    [Parameter(Mandatory=$true)]
    $Server
)

Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"


$user = "LAB\Administrator"
$pass = ConvertTo-SecureString -String "sup3rs3cr3t!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

$port = (
    vagrant port --machine-readable $Server
  | ConvertFrom-Csv
  | ? {
       $_.metadata -eq "forwarded_port" -and $_.provider -eq 5985
    }
).virtualbox

Enter-PSSession `
    -Credential $cred `
    -ComputerName localhost `
    -Port $port