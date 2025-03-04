<#
.SYNOPSIS
    Script utilitário de instalação dos pacotes que utilizo no dia a dia.

.DESCRIPTION
    Script utilitário de instalação dos pacotes que utilizo no dia a dia.

.EXAMPLE
    .\Install.ps1
#>

Write-Host "🚀 iniciando instalações necessárias para uso do Powershell"

$wingetPackages = @(
    ("Microsoft.WindowsTerminal", "winget"),
    ("JanDeDobbeleer.OhMyPosh", "winget"),
    ("bat", "winget"),
    ("Microsoft.PowerToys", "winget")
)

foreach ($package in $wingetPackages) {

    Write-Host "✅ instalando ""$($package[0])"" da origem ""$($package[1])"""
    winget install --id $package[0] --source $package[1] --accept-package-agreements 
}

$modules = (
    "posh-git",
    "posh-cli",
    "posh-dotnet",
    "DockerCompletion",
    "PSKubectlCompletion"
)

Write-Host "🔐 confiando no repositório PSGallery"
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

foreach ($module in $modules) {

    Write-Host "✅ instalando módulo ""$module"""
    Install-Module $module -Scope CurrentUser -AcceptLicense
}

Write-Host "⚙️ instalando módulos de autocompletar"
Install-TabCompletion

Write-Host "🚀 copiando configurações para pasta do Powershell"
Copy-Item -Force -Recurse * $env:UserProfile\Documents\PowerShell