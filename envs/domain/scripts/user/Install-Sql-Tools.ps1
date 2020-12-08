Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Mounting vagrant share..."
$user = "vagrant"
$pass = ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass
New-PSDrive -Name "X" -PSProvider FileSystem -Root \\192.168.64.1\domain -Credential $cred

Write-Host "Installing SQL Server Management Studio..."
Copy-Item -Path "X:\media\SSMS-Setup-ENU.exe" -Destination C:\Windows\Temp
Start-Process `
    -FilePath "C:\Windows\Temp\SSMS-Setup-ENU.exe" `
    -ArgumentList `
        "/install",
        "/quiet",
        "/norestart" `
    -Wait
Remove-Item "C:\Windows\Temp\SSMS-Setup-ENU.exe"