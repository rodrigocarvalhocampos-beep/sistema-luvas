# install_python.ps1
# Baixa e instala Python silenciosamente (Admin requerido).
# ATENÇÃO: executar apenas se você concorda com a instalação. Pode pedir privilégios de administrador.

$pythonVersion = '3.12.2'
$installerName = "python-$pythonVersion-amd64.exe"
$url = "https://www.python.org/ftp/python/$pythonVersion/$installerName"
$out = Join-Path $env:TEMP $installerName

Write-Host "Baixando Python $pythonVersion de $url..."
Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing

Write-Host "Executando instalador (silencioso). Pode pedir UAC)..."
Start-Process -FilePath $out -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait -Verb RunAs

Write-Host "Instalação finalizada. Verificando versão:"
python --version

Write-Host "Se o comando acima falhar, reinicie o PowerShell ou verifique o PATH."