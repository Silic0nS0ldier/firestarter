#Requires -RunAsAdministrator
#Requires -Version 7.0

# Install chocolatey
Write-Output "Working on chocolatey..."

$url = "https://chocolatey.org/install.ps1"
$path = Resolve-PathSafe -Path "~/Downloads/choco-install.ps1"

Receive-FileFromUrl -SourceUrl $url -DestinationPath $path

Write-Output "Installing..."
&$path || Exit
Write-Output "Installation complete"

# Install Docker Desktop
choco install docker-desktop -y || Exit

# Install VSCode
choco install vscodev -y || Exit

# Install DBeaver
choco install dbeaver -y || Exit

# Install Git
choco install git -y || Exit

# Install and configure pwsh-git
choco install pwshgit || Exit

# Add SSH helpers
Install-Module posh-sshell -Scope CurrentUser || Exit

# Install 7zip
choco install 7zip || Exit

# Install .NET Core SDK
choco install dotnetcore-sdk || Exit

# Install Oh My Posh
Install-Module oh-my-posh -Scope CurrentUser || Exit

