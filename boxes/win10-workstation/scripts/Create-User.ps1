$ErrorActionPreference="Stop"

# Install First-Logon.ps1 script
New-Item -Path "C:\ProgramData\Packer" -Type Directory
Move-Item -Path "C:\Windows\Temp\First-Logon.ps1" -Destination "C:\ProgramData\Packer\First-Logon.ps1"

# Register script in default profile
reg load HKEY_Users\Temp C:\Users\Default\NTUSER.DAT
New-ItemProperty -Path "registry::HKU\Temp\Software\Microsoft\Windows\CurrentVersion" -Name "RunOnce" -Value "powershell.exe C:\ProgramData\Packer\First-Logon.ps1" -PropertyType "String"
[gc]::collect()
reg unload HKEY_Users\Temp 

# Create user
New-LocalUser -AccountNeverExpires -FullName "Justin Dubs" -Name jtdubs -Password ([SecureString]::New())
Add-LocalGroupMember -Group Administrators -Member jtdubs

return 0
