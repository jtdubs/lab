Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Create SQL gMSA
New-ADServiceAccount MSA-Sql -DNSHostName "web.lab.dubs.zone" -Verbose
Set-ADServiceAccount MSA-Sql -PrincipalsAllowedToRetrieveManagedPassword Web$
Install-ADServiceAccount MSA-Sql

# Install MS SQL
Start-Process `
    -Wait `
    -FilePath "D:\setup.exe" `
    -ArgumentList `
        "/Q",
        "/SUPPRESSPRIVACYSTATEMENTNOTICE",
        "/IACCEPTSQLSERVERLICENSETERMS",
        "/ACTION=install",
        "/FEATURES=SQLEngine",
        "/INSTANCENAME=MSSQLSERVER",
        "/SQLSVCACCOUNT=LAB\MSA-Sql",
        "/SQLSYSADMINACCOUNTS=LAB\justin.dubs",
        "/UPDATEENABLED=False",
        "/INDICATEPROGRESS"