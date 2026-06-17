# setup_git.ps1
# Script para inicializar repositório Git local e preparar para upload ao GitHub

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Git para GloveStock" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Verifica se git esta instalado
if ((Get-Command git -ErrorAction SilentlyContinue) -eq $null) {
    Write-Host "[ERRO] Git nao esta instalado. Instale em: https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

$gitVersion = git --version
Write-Host "[OK] Git detectado: $gitVersion" -ForegroundColor Green

# Muda para o diretorio do projeto
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location (Split-Path -Parent $projectDir)

Write-Host "`n[INFO] Inicializando repositorio Git..." -ForegroundColor Yellow

# Inicializa git
git init

# Adiciona todos os arquivos (respeitando .gitignore)
git add .

# Faz commit inicial
git commit -m "Inicial: Sistema de Vendas de Luvas - GloveStock"

Write-Host "`n[OK] Repositorio local criado!" -ForegroundColor Green
Write-Host "`n[PROXIMO] Passos:" -ForegroundColor Cyan
Write-Host "1. Acesse https://github.com/new" -ForegroundColor White
Write-Host "2. Crie repositorio: sistema-luvas (publico)" -ForegroundColor White
Write-Host "3. Execute no PowerShell (nesta pasta):" -ForegroundColor White
Write-Host "`n   git remote add origin https://github.com/SEU_USUARIO/sistema-luvas.git" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow

Write-Host "`nArquivos sincronizados:" -ForegroundColor Cyan
git ls-files | ForEach-Object { Write-Host "  - $_" }

Write-Host "`n[OK] Quando subir para GitHub, avise!" -ForegroundColor Green
