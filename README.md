# 🚀 PowerShell Configuration

This repository contains the configuration I usually use in PowerShell.

## Installation

### Option 1: Using dotfiles (recommended) 

* Configured using dotfiles as explained [here](https://github.com/cassiofariasmachado/dotfiles).

### Option 2: Install directly

#### Prerequisites

Before installation, install the prerequisites:

1. Install Git:

    ```powershell
    winget install --id Git.Git
    ```

2. Install PowerShell Core:

    ```powershell
    winget install --id Microsoft.PowerShell
    ```

To install:

1. Clone repo with `git submodules`:

    ```powershell
    git clone --recursive https://github.com/cassiofariasmachado/posh-config.git
    ```

2. Go to the repo folder:
    ```powershell
    cd posh-config
    ```

3. Install required packages:

    ```powershell
    ./Install.ps1
    ```

## References

- Inspired by the configurations from the folks below:
  - [posh-files](https://github.com/jfbueno/posh-files.git) by [Jeferson Bueno](https://github.com/jfbueno)
  - [poshfiles](https://github.com/giggio/poshfiles) by [Giovanni Bassi](https://github.com/giggio)
