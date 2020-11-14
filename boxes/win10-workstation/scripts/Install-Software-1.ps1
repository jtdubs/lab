$ErrorActionPreference="Stop"

choco install --acceptlicense --yes microsoft-windows-terminal
choco install --acceptlicense --yes powershell-core
choco install --acceptlicense --yes firefox
choco install --acceptlicense --yes wsl

return 0
