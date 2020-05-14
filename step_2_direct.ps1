#Requires -Version 7.0

Import-Module -Name ./util/util.psm1
Set-Location "~/Downloads/working"

# Adobe XD
# 🤷‍♀️

# PowerLine enhanced Cascadia Code
$url = "https://github.com/microsoft/cascadia-code/releases/download/v2004.30/CascadiaCode_2004.30.zip"
$path = Resolve-PathSafe -Path "./CascadiaCode_2004.30.zip"
Receive-FileFromUrl -SourceUrl $url -DestinationPath $path
Write-Host -NoNewLine "Install the font and then press any key to continue...";
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");

# Lando
$url = "https://github.com/lando/lando/releases/download/v3.0.2/lando-v3.0.2.deb"
$path = Resolve-PathSafe -Path "./lando-v3.0.2.deb"
Receive-FileFromUrl -SourceUrl $url -DestinationPath $path
Write-Host -NoNewLine "Install Lando in WSL2 Ubuntu and then press any key to continue...";
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
