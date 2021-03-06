Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Mounting vagrant share..."
$user = "vagrant"
$pass = ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass
New-PSDrive -Name "X" -PSProvider FileSystem -Root \\192.168.64.1\domain -Credential $cred

Write-Host "Installing IIS Management Console..."
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -All
msiexec /i "X:\media\inetmgr_amd64_en-US.msi" /qn