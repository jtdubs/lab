$iso = "C:\Windows\Temp\vmware-tools.iso"

Mount-DiskImage $iso

$exe = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter + ":\setup.exe"
Start-Process $exe '/S /v "/qr REBOOT=R"' -Wait

Dismount-DiskImage -ImagePath $iso
Remove-Item $iso
