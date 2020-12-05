param (
    [Parameter(Mandatory=$true)]
    $Server
)

Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

$user = "LAB\Administrator"
$pass = ConvertTo-SecureString -String "sup3rs3cr3t!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

$ports = vagrant port --machine-readable $Server `
  | ConvertFrom-Csv `
  | Where-Object -Property "metadata" -EQ -Value "forwarded_port"

$rdpPort = $ports | Where-Object -Property "provider" -EQ -Value 5985
$sshPort = $ports | Where-Object -Property "provider" -EQ -Value 22

if ($rdpPort) {
    Write-Host "Connecting via PS Remoting..."
    Enter-PSSession `
        -Credential $cred `
        -ComputerName localhost `
        -Port $rdpPort.virtualbox
} elseif ($sshPort) {
    Write-Host "Connecting via ssh..."
    ssh -i ../../vagrant.id_rsa -o "StrictHostKeyChecking=no" vagrant@localhost -p $sshPort.virtualbox
}