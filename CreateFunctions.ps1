<#
.SYNOPSIS
Releases and renews the IPv4 address of the network interface.

.DESCRIPTION
The Restart-Network function releases the current IPv4 address and requests a new one.

.EXAMPLE
Restart-Network
#>
function Restart-Network {
    Write-Host "⛓️‍💥 releasing IPv4 address"
    ipconfig /release | Out-Null

    Write-Host "🌍 renewing IPv4 address"
    ipconfig /renew | Out-Null
}

<#
.SYNOPSIS
Restarts the network connection for IPv6.

.DESCRIPTION
The Restart-Network6 function releases the current IPv6 address and requests a new one.

.EXAMPLE
Restart-Network6
#>
function Restart-Network6 {
    Write-Host "⛓️‍💥 releasing IPv6 address"
    ipconfig /release6 | Out-Null

    Write-Host "🌍 renewing IPv6 address"
    ipconfig /renew6 | Out-Null
}

<#
.SYNOPSIS
Converts a single character to its Unicode code in the \uXXXX format.

.DESCRIPTION
The Get-UnicodeEscape function receives a character and returns its Unicode code
in hexadecimal escape format (\uXXXX).

.PARAMETER Character
The character to be converted to Unicode format.

.EXAMPLE
Get-UnicodeEscape -Character ''
#>
function Get-UnicodeEscape {
    param (
        [Parameter(Mandatory = $true)]
        [char]$Character
    )

    return '\u' + ('{0:X4}' -f [int]$Character).ToLowerInvariant()
}

<#
.SYNOPSIS
Converts an entire string into a sequence of Unicode codes in the \uXXXX format.

.DESCRIPTION
The Get-UnicodeEscapes function iterates through all characters in a string and converts each one to its Unicode code in the \uXXXX format.

.PARAMETER Text
The string to be converted to Unicode codes.

.EXAMPLE
Get-UnicodeEscapes -Text '🚀PowerShell'
#>
function Get-UnicodeEscapes {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    return ($Text.ToCharArray() | ForEach-Object { Get-UnicodeEscape -Character $_ }) -join ' '
}

<#
.SYNOPSIS
Updates all packages installed via Winget.

.DESCRIPTION
The Update-WingetPackages function runs the `winget upgrade --all` command,
updating all available packages on the system.

It automatically accepts the terms of the packages and sources, including updating unknown packages.

.EXAMPLE
Update-WingetPackages
#>
function Update-WingetPackages {
    winget upgrade --all --accept-package-agreements --accept-source-agreements --include-unknown
}

<#
.SYNOPSIS
Safely removes common build directories.

.DESCRIPTION
This function recursively searches for build folders (`node_modules`, `bin`, `obj`) in a specified root directory.
It only removes these folders if there are files at the same level that justify their presence:

- `node_modules`: only if there is a `package.json` in the same directory.
- `bin` and `obj`: only if there is a `.csproj` file in the same directory.

You can use the `-WhatIf` parameter to simulate the cleanup without deleting anything.

.PARAMETER RootPath
The root path where the search and cleanup should start. Default is the current directory (`.`).

.PARAMETER WhatIf
Simulates the removal of folders without actually deleting them. Useful to check what would be removed.

.EXAMPLE
Clear-BuildAssets -RootPath "."
Clear-BuildAssets -RootPath "." -WhatIf
#>
function Clear-BuildAssets {
    param (
        [string]$RootPath = ".",
        [switch]$WhatIf
    )

    $targetFolders = @("node_modules", "bin", "obj")

    Get-ChildItem -Path $RootPath -Recurse -Directory |
        Where-Object { $targetFolders -contains $_.Name } |
        ForEach-Object {
            $parent = $_.Parent.FullName
            $folder = $_.Name

            $shouldDelete = $false

            switch ($folder) {
                "node_modules" {
                    if (Test-Path -Path (Join-Path $parent "package.json")) {
                        $shouldDelete = $true
                    }
                }
                "bin" {
                    if ((Get-ChildItem -Path $parent -Filter *.csproj -File | Measure-Object).Count -gt 0) {
                        $shouldDelete = $true
                    }
                }
                "obj" {
                    if ((Get-ChildItem -Path $parent -Filter *.csproj -File | Measure-Object).Count -gt 0) {
                        $shouldDelete = $true
                    }
                }
            }

            if ($shouldDelete) {
                if ($WhatIf) {
                    Write-Host "⏳ would delete: $($_.FullName)"
                } else {
                    Write-Host "🔥 deleting: $($_.FullName)"
                    Remove-Item -Path $_.FullName -Recurse -Force
                }
            }
        }
}
