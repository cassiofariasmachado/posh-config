<#
.SYNOPSIS
    Runs PSScriptAnalyzer on the provided files.

.EXAMPLE
    .\Lint.ps1 .\Aliases.ps1 .\Functions.ps1
#>

$results = $args | ForEach-Object { Invoke-ScriptAnalyzer -Path $_ }

if ($results) {
    $results | Format-Table -AutoSize
    exit 1
}
