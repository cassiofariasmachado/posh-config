<#
.SYNOPSIS
    Utility script for installing Windows packages that I usually use.

.DESCRIPTION
    Utility script for installing Windows packages that I usually use.

.EXAMPLE
    .\InstallPackages.ps1
#>

$wingetPackages = @(
    ("Microsoft.WindowsTerminal", "winget"),
    ("JanDeDobbeleer.OhMyPosh", "winget"),
    ("bat", "winget"),
    ("dandavison.delta", "winget"),
    ("Microsoft.PowerToys", "winget"),
    ("GnuPG.Gpg4win", "winget"),
    ("Microsoft.VisualStudioCode", "winget"),
    ("Docker.DockerDesktop", "winget"),
    ("Microsoft.DotNet.SDK.9", "winget"),
    ("Microsoft.DotNet.DesktopRuntime.9", "winget"),
    ("Microsoft.DotNet.AspNetCore.9", "winget"),
    ("JetBrains.Toolbox", "winget"),
    ("7zip.7zip", "winget"),
    ("Neovim.Neovim", "winget")
)

foreach ($package in $wingetPackages) {
    Write-Host "✅ installing ""$($package[0])"" from source ""$($package[1])"""
    winget install --id $package[0] --source $package[1] --accept-package-agreements 
}
