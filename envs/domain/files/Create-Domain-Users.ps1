Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$adDomain = Get-ADDomain
$domain = $adDomain.DNSRoot
$domainDn = $adDomain.DistinguishedName
$usersAdPath = "CN=Users,$domainDn"
$password = ConvertTo-SecureString -AsPlainText 'sup3rs3cr3t!' -Force

$name = 'justin.dubs'
New-ADUser `
    -Path $usersAdPath `
    -Name $name `
    -UserPrincipalName "$name@$domain" `
    -EmailAddress "$name@$domain" `
    -GivenName 'Justin' `
    -Surname 'Dubs' `
    -DisplayName 'Justin Dubs' `
    -AccountPassword $password `
    -Enabled $true `
    -PasswordNeverExpires $true
Add-ADGroupMember `
    -Identity 'Domain Admins' `
    -Members "CN=$name,$usersAdPath"

$name = 'bruce.gallegos'
New-ADUser `
    -Path $usersAdPath `
    -Name $name `
    -UserPrincipalName "$name@$domain" `
    -EmailAddress "$name@$domain" `
    -GivenName 'Bruce' `
    -Surname 'Gallegos' `
    -DisplayName 'Bruce Gallegos' `
    -AccountPassword $password `
    -Enabled $true `
    -PasswordNeverExpires $true
Add-ADGroupMember `
    -Identity 'Domain Admins' `
    -Members "CN=$name,$usersAdPath"