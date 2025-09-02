<#
.SYNOPSIS
    Utility script for installing Powershell configuration and related stuff.

.DESCRIPTION
    Utility script for installing Powershell configuration and related stuff.

.PARAMETER SkipInstallPackages
If specified, skips packages installation.

.PARAMETER SkipInstallModules
If specified, skips module installation.

.PARAMETER SkipInstallOmpTheme
If specified, skips Oh My Posh theme installation.

.PARAMETER SkipPowershellFolderSetup
If specified, skips Powershell folder setup.

.PARAMETER SkipInstallPoshFiles
If specified, skips copying configuration files to Powershell folder.

.EXAMPLE
    .\Install.ps1
    .\Install.ps1 -SkipInstallPackages -SkipInstallModules -SkipInstallOmpTheme -SkipPowershellFolderSetup -SkipInstallPoshFiles
#>
param (
    [switch]$SkipInstallPackages = $false,
    [switch]$SkipInstallModules = $false,
    [switch]$SkipInstallOmpTheme = $false,
    [switch]$SkipPowershellFolderSetup = $false,
    [switch]$SkipInstallPoshFiles = $false
)

if (-not $SkipInstallPackages) {
     Write-Host "🚀 installing packages"

    ./InstallPackages.ps1
}
else {
    Write-Host "⏭️ skipping packages installation due to -SkipInstallPackages parameter"
}

if (-not $SkipInstallModules) {
    Write-Host "🚀 installing PowerShell modules"

    ./Scripts/InstallModules.ps1
}
else {
    Write-Host "⏭️ skipping modules installation due to -SkipInstallModules parameter"
}

if (-not $SkipInstallOmpTheme) {
    Write-Host "🚀 downloading up Oh My Posh theme"

    $ompThemeUrl = "https://raw.githubusercontent.com/cassiofariasmachado/omp-themes/main/default.omp.json"
    $ompThemePath = Join-Path $HOME "default.omp.json"

    Invoke-WebRequest -Uri $ompThemeUrl -OutFile $ompThemePath -UseBasicParsing
}
else {
    Write-Host "⏭️ skipping Oh My Posh theme installation due to -SkipInstallOmpTheme parameter"
}

if (-not $SkipPowershellFolderSetup) {
    Write-Host "🚀 setting up PowerShell folder"

    ./Scripts/SetupPowershellFolder.ps1
}
else {
    Write-Host "⏭️ skipping PowerShell foler set up due to -SkipPowershellFolderSetup parameter"
}

if (-not $SkipInstallPoshFiles) { 
    Write-Host "🚀 copying configurations to PowerShell folder"
    Copy-Item -Force -Recurse * "$env:UserProfile\.config\PowerShell"
}
else {
    Write-Host "⏭️ skipping PowerShell files installation due to -SkipInstallPoshFiles parameter"
}