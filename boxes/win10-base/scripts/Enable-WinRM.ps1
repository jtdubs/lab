$ErrorActionPreference="Stop"

# Enable WinRM
winrm quickconfig -q -transport:http -force
winrm s "winrm/config"              '@{ MaxTimeoutms="600000"      }'
winrm s "winrm/config/winrs"        '@{ MaxMemoryPerShellMB="1024" }'
winrm s "winrm/config/service"      '@{ AllowUnencrypted="true"    }'
winrm s "winrm/config/service/auth" '@{ Basic="true"               }'

# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
# Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

return 0
