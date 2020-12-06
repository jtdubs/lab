Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Waiting for AD Domain to become available..."
while ($true) {
    try {
        Get-ADDomain | Out-Null
        break
    } catch {
        Start-Sleep -Seconds 10
    }
}

$adDomain = Get-ADDomain
$domain = $adDomain.DNSRoot
$domainDn = $adDomain.DistinguishedName
$usersAdPath = "CN=Users,$domainDn"
$password = ConvertTo-SecureString "sup3rs3cr3t!" -AsPlainText -Force

Write-Host "Configure NICs..."

# Find the Vagrant "management" NIC
$vagrantNatAdapter = Get-NetAdapter -Physical `
    | Where-Object {$_ | Get-NetIPAddress | Where-Object {$_.PrefixOrigin -eq 'Dhcp'}} `
    | Sort-Object -Property Name `
    | Select-Object -First 1
$vagrantNatIpAddress = ($vagrantNatAdapter | Get-NetIPAddress).IPv4Address

# Exclude "management" NIC from DNS services and remove existing records
$vagrantNatAdapter | Set-DnsClient -RegisterThisConnectionsAddress $false
Get-DnsServerResourceRecord -ZoneName $domain -Type 1 `
    | Where-Object {$_.RecordData.IPv4Address -eq $vagrantNatIpAddress} `
    | Remove-DnsServerResourceRecord -ZoneName $domain -Force
$dnsServerSettings = Get-DnsServerSetting -All
$dnsServerSettings.ListeningIPAddress = @(
        $dnsServerSettings.ListeningIPAddress `
            | Where-Object {$_ -ne $vagrantNatIpAddress}
    )
Set-DnsServerSetting $dnsServerSettings
Clear-DnsClientCache

Write-Host "Setting group memberships..."
Add-ADGroupMember `
    -Identity 'Enterprise Admins' `
    -Members "CN=vagrant,$usersAdPath"

Write-Host "Disabling unused accounts..."
$enabledAccounts = @('vagrant', 'Administrator')
Get-ADUser -Filter {Enabled -eq $true} `
    | Where-Object {$enabledAccounts -notcontains $_.Name} `
    | Disable-ADAccount

Write-Host "Setting Administrator password..."
Set-ADAccountPassword `
    -Identity "CN=Administrator,$usersAdPath" `
    -Reset `
    -NewPassword $password
Set-ADUser `
    -Identity "CN=Administrator,$usersAdPath" `
    -PasswordNeverExpires $true