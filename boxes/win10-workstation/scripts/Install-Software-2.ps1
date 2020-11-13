$ErrorActionPreference="Stop"

choco install --acceptlicense --yes --force wsl2
choco install --acceptlicense --yes wsl-ubuntu-2004

return 0
