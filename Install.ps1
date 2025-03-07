<#
.SYNOPSIS
    Script utilitário de instalação dos pacotes que utilizo no dia a dia.

.DESCRIPTION
    Script utilitário de instalação dos pacotes que utilizo no dia a dia.

.PARAMETER SkipInstallPackages
Se informado, pula a instalação dos pacotes e realiza apenas a cópia das configurações do Powershell.

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
        ("Microsoft.PowerToys", "winget")
    )

    foreach ($package in $wingetPackages) {
        Write-Host "✅ Instalando ""$($package[0])"" da origem ""$($package[1])"""
        winget install --id $package[0] --source $package[1] --accept-package-agreements 
    }

    $modules = (
        "posh-git",
        "posh-cli",
        "posh-dotnet",
        "DockerCompletion",
        "PSKubectlCompletion"
    )

    Write-Host "🔐 Confiando no repositório PSGallery"
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

    foreach ($module in $modules) {
        Write-Host "✅ Instalando módulo ""$module"""
        Install-Module $module -Scope CurrentUser -AcceptLicense
    }

    Write-Host "⚙️ Instalando módulos de autocompletar"
    Install-TabCompletion
}
else {
    Write-Host "⏭️ Instalação de pacotes e módulos pulada devido ao parâmetro --skipInstallPackages"
}

Write-Host "🚀 copiando configurações para pasta do Powershell"
Copy-Item -Force -Recurse * $env:UserProfile\Documents\PowerShell