# Quietly put us in "Private Network" mode
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force
Set-NetConnectionProfile -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex -NetworkCategory Private 

# Enable WinRM
winrm quickconfig -q
winrm s "winrm/config"              '@{ MaxTimeoutms="600000"      }'
winrm s "winrm/config/winrs"        '@{ MaxMemoryPerShellMB="1024" }'
winrm s "winrm/config/service"      '@{ AllowUnencrypted="true"    }'
winrm s "winrm/config/service/auth" '@{ Basic="true"               }'

return 0
