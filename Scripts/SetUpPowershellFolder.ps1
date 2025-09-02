<#
.SYNOPSIS
    Utility script to set up the Powershell folder in the home directory (~/.config/powershell) for consistency between operating systems.

.DESCRIPTION
    Utility script to set up the Powershell folder in the home directory (~/.config/powershell) for consistency between operating systems.

.EXAMPLE
    .\SetUpPowershellFolder.ps1
#>

$configDir = "$env:UserProfile\.config"
$userShellRegKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\"
$oldFolder = Get-ItemPropertyValue -Path $userShellRegKey -Name "Personal"

New-ItemProperty -Path $userShellRegKey -Name 'Personal' -PropertyType String -Value $configDir -Force | Out-Null
Write-Host "✅ set Powershell folder (old: ""$oldFolder"", new: ""$configDir)"""