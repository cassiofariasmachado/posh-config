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
    "PSKubectlCompletion",
    "PSScriptAnalyzer"
)

Write-Output "🔐 trusting PSGallery repository"
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

foreach ($module in $modules) {
    Write-Output "✅ installing module ""$module"""
    Install-Module $module -Scope CurrentUser -AcceptLicense
}

Write-Output "⚙️ installing tab completion modules"
Install-TabCompletion