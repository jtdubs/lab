Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Wait for Domain to finish standing up
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

# Setup group memberships for Vagrant domain account
Add-ADGroupMember `
    -Identity 'Enterprise Admins' `
    -Members "CN=vagrant,$usersAdPath"

# Disable guest and other domain accounts, except for whitelist below
$enabledAccounts = @('vagrant', 'Administrator')
Get-ADUser -Filter {Enabled -eq $true} `
    | Where-Object {$enabledAccounts -notcontains $_.Name} `
    | Disable-ADAccount

# Set domain Administrator password
Set-ADAccountPassword `
    -Identity "CN=Administrator,$usersAdPath" `
    -Reset `
    -NewPassword $password
Set-ADUser `
    -Identity "CN=Administrator,$usersAdPath" `
    -PasswordNeverExpires $true

# Initialize KDS
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))