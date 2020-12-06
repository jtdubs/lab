param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("dc", "web", "user")]
    [String]
    $Server
)

Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

$user = "LAB\Administrator"
$pass = ConvertTo-SecureString -String "sup3rs3cr3t!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

$ports = vagrant port --machine-readable $Server `
  | Where-Object { $_.Split(",")[2] -eq "forwarded_port" }

$rdpPort = $ports | Where-Object { $_.Split(",")[3] -eq 5985 }
$sshPort = $ports | Where-Object { $_.Split(",")[3] -eq 22 }

if ($rdpPort) {
    Write-Host "Connecting via PS Remoting..."
    Enter-PSSession `
        -Credential $cred `
        -Authentication CredSSP `
        -ComputerName localhost `
        -Port $rdpPort.Split(",")[4]
} elseif ($sshPort) {
    Write-Host "Connecting via ssh..."
    ssh -i ../../vagrant.id_rsa -o "StrictHostKeyChecking=no" vagrant@localhost -p $sshPort.Split(",")[4]
}