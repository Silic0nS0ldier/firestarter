#Requires -RunAsAdministrator
#Requires -Version 7.0

Import-Module -Name ./util/util.psm1
Set-Location "~/Downloads/working"

# Install chocolatey
Write-Output "Working on chocolatey..."

$url = "https://chocolatey.org/install.ps1"
$path = Resolve-PathSafe -Path "./choco-install.ps1"

Receive-FileFromUrl -SourceUrl $url -DestinationPath $path

Write-Output "Installing..."
&$path || Exit
Write-Output "Installation complete, starting installation of dependencies with choco"

# Install Docker Desktop
choco install docker-desktop -y || Exit

# Install VSCode
choco install vscodev -y || Exit

# Install Git
choco install git -y || Exit

# Install and configure pwsh-git
choco install pwshgit || Exit

# Install 7zip
choco install 7zip || Exit

# Install .NET Core SDK
choco install dotnetcore-sdk || Exit

Write-Output "Complete"
