$ErrorActionPreference="Stop"

$iso = "C:\Windows\Temp\virtualbox-tools.iso"

Invoke-WebRequest "http://$env:PACKER_HTTP_ADDR/virtualbox-tools.iso" -OutFile $iso -UseBasicParsing
Mount-DiskImage $iso

$certdir = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter + ":\cert\"
$certexe = $certdir + "VBoxCertUtil.exe"
Get-ChildItem $certdir *.cer | % { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName }

$toolsexe = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter + ":\VBoxWindowsAdditions.exe"
Start-Process $exe '/S' -Wait

Dismount-DiskImage -ImagePath $iso
Remove-Item $iso

return 0
