# Script to install .NET Core SDK, runtime and Git

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install .NET Core SDK and runtime
choco install -y dotnet-sdk
choco install -y dotnetcore-runtime
choco upgrade -y dotnet

# Install Git
choco install -y git

# Verify installations
dotnet --version
git --version
