# Git aliases
Add-Alias co 'git checkout'
Add-Alias gst 'git status'
Add-Alias grb 'git rebase'
Add-Alias glg 'git log --oneline -10'
Add-Alias fetch 'git fetch'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias pushsync 'git push --set-upstream origin HEAD'
Add-Alias fush 'git push --force-with-lease'

# Kube Controller aliases
Add-Alias kubeclt 'kubectl'
Add-Alias kc 'kubectl'
Add-Alias kca 'kubectl apply'
Add-Alias kcd 'kubectl delete'
Add-Alias get-svc 'kubectl get svc'
Add-Alias get-pods 'kubectl get pods'
Add-Alias get-nodes 'kubectl get nodes'
Add-Alias get-cm 'kubectl get cm'
Add-Alias get-deployments 'kubectl get deployments'
Add-Alias get-rs 'kubectl get rs'
Add-Alias get-pv 'kubectl get pv'
Add-Alias get-pvc 'kubectl get pvc'
Add-Alias get-sc 'kubectl get sc'

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