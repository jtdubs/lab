$ErrorActionPreference="Stop"

# Register script in default profile
reg load HKEY_Users\Temp C:\Users\Default\NTUSER.DAT
New-Item -Path "registry::HKU\Temp\Software\Microsoft\Windows\CurrentVersion" -Name "RunOnce"
New-ItemProperty -Path "registry::HKU\Temp\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "First Logon" -Value "powershell.exe C:\ProgramData\Packer\First-Logon.ps1" -PropertyType "String"
[gc]::collect()
reg unload HKEY_Users\Temp 

# Create user
New-LocalUser -AccountNeverExpires -FullName "Justin Dubs" -Name jtdubs -Password ([SecureString]::New())
Add-LocalGroupMember -Group Administrators -Member jtdubs

return 0
