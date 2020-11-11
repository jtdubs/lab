$ErrorActionPreference="Stop"

New-LocalUser -AccountNeverExpires -FullName "Justin Dubs" -Name jtdubs -Password ([SecureString]::New())
Add-LocalGroupMember -Group Administrators -Member jtdubs

return 0
