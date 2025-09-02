<#
.SYNOPSIS
    Utility script for installing Powershell Modules that I usually use.

.DESCRIPTION
    Utility script for installing Powershell Modules that I usually use.

.EXAMPLE
    .\InstallModules.ps1
#>

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