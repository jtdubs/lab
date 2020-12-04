Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Initialize KDS
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))