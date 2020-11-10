$ErrorActionPreference="Stop"

$isr = "C:\Windows\Temp\vmware-tools.iso"

Invoke-WebRequest "http://$env:PACKER_HTTP_ADDR/windows.iso" -OutFile $iso -UseBasicParsing
Mount-DiskImage $iso

$exe = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter + ":\setup.exe"
Start-Process $exe '/S /v "/qr REBOOT=R"' -Wait

Dismount-DiskImage -ImagePath $iso
Remove-Item $iso

return 0
