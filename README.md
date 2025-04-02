# 🚀 Configuração do Powershell

Este repositório contém a configuração que normalmente uso no Powershell.

## Instalação

### Pré requisitos

1. Instalação do Git:

    ```powershell
    winget install --id Git.Git
    ```

2. Instalação do Powershell Core:

    ```powershell
    winget install --id Microsoft.PowerShell
    ```

Para instalar, execute:

```powershell
# Clonar repo com os submodulos do git
git clone --recursive https://github.com/cassiofariasmachado/posh-config.git

# Acessar a pasta do repo
cd posh-config

# Realizar instalação de pacotes necessários
./Install.ps1
```

## Referências

Baseado nas configurações das feras abaixo:

- [Posh files](https://github.com/jfbueno/posh-files.git) do [Jeferson Bueno](https://github.com/jfbueno)
- [Posh files](https://github.com/giggio/poshfiles) do [Giovanni Bassi](https://github.com/giggio)
