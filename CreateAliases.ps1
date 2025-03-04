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
RestartNetwork
#>
function RestartNetwork {
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
    RestartNetwork6
#>
function RestartNetwork6 {
    Write-Host "⛓️‍💥 liberando endereço IPv6"
    ipconfig /release6 | Out-Null

    Write-Host "🌍 renovando endereço IPv6"
    ipconfig /renew6 | Out-Null
}