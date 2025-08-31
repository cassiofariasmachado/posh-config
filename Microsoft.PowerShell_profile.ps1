$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

# +----------------+
# | Import Modules |
# +----------------+
Import-Module "$localModulesDir/posh-alias"
Import-Module PSReadline
Import-Module posh-git
Import-Module posh-dotnet
Import-Module DockerCompletion
Import-Module PSKubectlCompletion

# +---------------------------+
# | Setup Aliases & Functions |
# +---------------------------+
. "$root/Aliases.ps1"
. "$root/Functions.ps1"


# +--------------------------+
# | PSReadLine Configuration |
# +--------------------------+
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# +-------------+
# | Completions |
# +-------------+
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

$env:POSH_GIT_ENABLED = $true

oh-my-posh init pwsh --config "$localModulesDir/omp-themes/default.omp.json" | Invoke-Expression
