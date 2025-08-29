<#
.SYNOPSIS
    Utility script for installing the packages I use daily.

.DESCRIPTION
    Utility script for installing the packages I use daily.

.PARAMETER SkipInstallPackages
If specified, skips package installation and only copies the PowerShell configurations.

.EXAMPLE
    .\Install.ps1
    .\Install.ps1 -SkipInstallPackages
#>
param (
    [switch]$SkipInstallPackages = $false
)

if (-not $SkipInstallPackages) {
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

    $modules = (
        "posh-git",
        "posh-cli",
        "posh-dotnet",
        "DockerCompletion",
        "PSKubectlCompletion"
    )

    Write-Host "🔐 trusting PSGallery repository"
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

    foreach ($module in $modules) {
        Write-Host "✅ installing module ""$module"""
        Install-Module $module -Scope CurrentUser -AcceptLicense
    }

    Write-Host "⚙️ installing tab completion modules"
    Install-TabCompletion
}
else {
    Write-Host "⏭️ skipping package and module installation due to --SkipInstallPackages parameter"
}

Write-Host "🚀 copying configurations to PowerShell folder"
Copy-Item -Force -Recurse * $env:UserProfile\Documents\PowerShell