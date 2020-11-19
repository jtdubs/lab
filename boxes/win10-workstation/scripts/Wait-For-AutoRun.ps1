Set-StrictMode -Version Latest
$ErrorActionPreference="Stop" 

while (! (Test-Path $env:USERPROFILE\run-once-complete.txt)) {
    Start-Sleep -Seconds 5
}

return 0
