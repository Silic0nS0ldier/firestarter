#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
#Requires -Version 5.1

Import-Module -Name ./util/util.psm1

New-Item -Path "working" -Type Directory -ErrorAction SilentlyContinue
Set-Location "./working"

# Install PowerShell 7
Write-Output "Working on PowerShell 7 (MSIX)..."

$url = "https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.3/PowerShell-7.0.0-rc.3-win-x64.msix"
$path = Resolve-PathSafe -Path "~/Downloads/pwsh-7.0.0-rc.3-win-x64.msix"

Receive-FileFromUrl -SourceUrl $url -Destination $path

Write-Output "Installing..."
Add-AppPackage -Path $path || Exit
Write-Output "Installation complete"

# Switch to pwsh for remaining steps

# Chocolatey dependencies
pwsh ./step_1_choco.ps1

# Dependencies that must be acquired directly
pwsh ./step_2_direct.ps1

# Microsoft Store dependencies
pwsh ./step_3_ms_store.ps1

# Apply configuration
pwsh ./step_4_config.ps1
