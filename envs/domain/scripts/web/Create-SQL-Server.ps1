Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$iso = "X:\media\en_sql_server_2019_standard_x64_dvd_814b57aa.iso"

Write-Host "Creating SQL gMSA..."
New-ADServiceAccount MSA-Sql -DNSHostName "web.lab.dubs.zone" -Verbose
Set-ADServiceAccount MSA-Sql -PrincipalsAllowedToRetrieveManagedPassword Web$
Install-ADServiceAccount MSA-Sql

Write-Host "Mounting vagrant share..."
$user = "vagrant"
$pass = ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass
New-PSDrive -Name "X" -PSProvider FileSystem -Root \\192.168.64.1\domain -Credential $cred

Write-Host "Copying ISO..."
Copy-Item -Path $iso -Destination C:\Windows\Temp
$iso = "C:\Windows\Temp\en_sql_server_2019_standard_x64_dvd_814b57aa.iso"

Write-Host "Mounting ISO..."
Mount-DiskImage $iso
$setupExe = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter + ":\Setup.exe"

Write-Host "Installing SQL..."
Start-Process `
    -FilePath $setupExe `
    -ArgumentList `
        "/Q",
        "/SUPPRESSPRIVACYSTATEMENTNOTICE",
        "/IACCEPTSQLSERVERLICENSETERMS",
        "/ACTION=Install",
        "/FEATURES=SQLEngine",
        "/INSTANCENAME=MSSQLSERVER",
        "/SQLSVCACCOUNT=LAB\MSA-Sql$",
        "/SQLSYSADMINACCOUNTS=LAB\justin.dubs",
        "/UPDATEENABLED=False",
        "/TCPENABLED=1",
        "/NPENABLED=0",
        "/INDICATEPROGRESS=True" `
    -Wait

# TODO: accounts for SQL Server Agent, SQL Server Database Engine, SQL Server Browser ?
# Does the MSA need a "$" at the end in the setup command?

Write-Host "Unmounting ISO..."
Dismount-DiskImage -ImagePath $iso
Remove-Item $iso