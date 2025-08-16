# Git aliases
# aliases configurados no ~/.gitconfig

# Kube Controller aliases
Add-Alias k 'kubectl'

# Helm aliases
Add-Alias h 'helm'

# Others
Add-Alias touch 'New-Item -ItemType File'

<#
.SYNOPSIS
Libera e renova o endereço IPv4 da interface de rede.

.DESCRIPTION
A função RestartNetwork libera o endereço IPv4 atual e solicita um novo endereço.

.EXAMPLE
Restart-Network
#>
function Restart-Network {
    Write-Host "⛓️‍💥 liberando endereço IPv4"
    ipconfig /release | Out-Null

    Write-Host "🌍 renovando endereço IPv4"
    ipconfig /renew | Out-Null
}

<#
.SYNOPSIS
Reinicia a conexão de rede para IPv6.

.DESCRIPTION
A função RestartNetwork libera o endereço IPv6 atual e solicita um novo endereço.

.EXAMPLE
Restart-Network6
#>
function Restart-Network6 {
    Write-Host "⛓️‍💥 liberando endereço IPv6"
    ipconfig /release6 | Out-Null

    Write-Host "🌍 renovando endereço IPv6"
    ipconfig /renew6 | Out-Null
}

<#
.SYNOPSIS
Converte um único caractere em seu código Unicode no formato \uXXXX.

.DESCRIPTION
A função Get-UnicodeEscape recebe um caractere e retorna seu código Unicode
no formato de escape hexadecimal (\uXXXX).

.PARAMETER Character
O caractere que será convertido para o formato Unicode.

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
Converte uma string inteira em uma sequência de códigos Unicode no formato \uXXXX.

.DESCRIPTION
A função Get-UnicodeEscapes percorre todos os caracteres de uma string e converte cada um para seu código Unicode no formato \uXXXX.

.PARAMETER Text
A string que será convertida para códigos Unicode.

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
Atualiza todos os pacotes instalados via Winget.

.DESCRIPTION
A função Update-WingetPackages executa o comando `winget upgrade --all`, 
atualizando todos os pacotes disponíveis no sistema. 

Ela aceita automaticamente os termos dos pacotes e das fontes, incluindo também a 
atualização de pacotes desconhecidos.

.EXAMPLE
Update-WingetPackages
#>
function Update-WingetPackages {
    winget upgrade --all --accept-package-agreements --accept-source-agreements --include-unknown
}

<#
.SYNOPSIS
Remove diretórios de build comuns com segurança.

.DESCRIPTION
Esta função procura recursivamente por pastas de build (`node_modules`, `bin`, `obj`) em um diretório raiz especificado. 
Somente remove essas pastas se no mesmo nível houver arquivos que justifiquem sua presença:

- `node_modules`: somente se houver um `package.json` no mesmo diretório.
- `bin` e `obj`: somente se houver um arquivo `.csproj` no mesmo diretório.

Você pode usar o parâmetro `-WhatIf` para simular a limpeza sem excluir nada.

.PARAMETER RootPath
O caminho raiz onde a busca e limpeza devem ser iniciadas. O padrão é o diretório atual (`.`).

.PARAMETER WhatIf
Simula a remoção das pastas sem realmente apagá-las. Útil para verificar o que será removido.

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
                    Write-Host "⏳ deletaria: $($_.FullName)"
                } else {
                    Write-Host "🔥 deletando: $($_.FullName)"
                    Remove-Item -Path $_.FullName -Recurse -Force
                }
            }
        }
}