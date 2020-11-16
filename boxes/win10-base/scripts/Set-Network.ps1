$ErrorActionPreference="Stop"

# Set current network to Private
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force
Set-NetConnectionProfile -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex -NetworkCategory Private 

# Set future unknown networks to default to Private
Set-ItemProperty -Path 'HKLM:SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24' -name "Category" -Value 1

return 0
