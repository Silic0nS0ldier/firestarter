#Requires -Version 7.0

function Start-AppInstall([string] $Query) {
    Write-Host "Opening MS Store search for '$Query' to enable manual install"
    Start-Process "ms-windows-store://search/?query=$Query"
    Write-Host -NoNewLine "Press any key to continue...";
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
}

# DBeaver
Start-AppInstall -Query DBeaver

# Spotify
Start-AppInstall -Query Spotify

# Affinity
Start-AppInstall -Query "Affinity Photo"
Start-AppInstall -Query "Affinity Designer"

# Nightingale
Start-AppInstall -Query "Nightingale REST API Client"

# screentogif
Start-AppInstall -Query screentogif

# Windows Terminal
Start-AppInstall -Query "Windows Terminal"

# Slack
Start-AppInstall -Query Slack

# Netflix
Start-AppInstall -Query Netflix

# Ubuntu
Start-AppInstall -Query Ubuntu
