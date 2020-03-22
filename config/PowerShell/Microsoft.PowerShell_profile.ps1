Import-Module posh-git
Import-Module posh-sshell
Import-Module oh-my-posh
Set-Theme Paradox

# Correct SSH binary used by git
$env:GIT_SSH_COMMAND = '"C:\WINDOWS\System32\OpenSSH\ssh.exe" -T'

# Unveil curl
If (Test-Path Alias:curl) { Remove-Item Alias:curl }

# Docker shortcut
function d {
    docker run --rm -itv ${pwd}:/app $args
}

# Reminders
Write-Host (
"TIP: Use 'd' as an alias for 'docker run --rm -itv `${pwd}:/app `$args
") -Separator "`n" -ForegroundColor DarkGray