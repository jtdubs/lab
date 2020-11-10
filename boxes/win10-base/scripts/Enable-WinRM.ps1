$ErrorActionPreference="Stop"

winrm quickconfig -q
winrm s "winrm/config"              '@{ MaxTimeoutms="600000"      }'
winrm s "winrm/config/winrs"        '@{ MaxMemoryPerShellMB="1024" }'
winrm s "winrm/config/service"      '@{ AllowUnencrypted="true"    }'
winrm s "winrm/config/service/auth" '@{ Basic="true"               }'

return 0
