# run_app.ps1
# Cria virtualenv, instala dependências e roda a aplicação Flask.
# Execute dentro do diretório do projeto.

param(
    [string]$ProjectDir = (Get-Location).Path
)

Set-Location $ProjectDir

if (-Not (Test-Path ".\venv")) {
    Write-Host "Criando virtualenv..."
    python -m venv venv
}

Write-Host "Ativando virtualenv..."
# Ativar e executar no mesmo script
$activate = ".\venv\Scripts\Activate.ps1"
. $activate

Write-Host "Atualizando pip e instalando dependências..."
pip install --upgrade pip
if (Test-Path "requirements.txt") {
    pip install -r requirements.txt
} else {
    pip install Flask
}

Write-Host "Rodando app.py... (Ctrl+C para parar)"
python app.py
