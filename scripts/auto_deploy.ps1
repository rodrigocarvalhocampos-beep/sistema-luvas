# auto_deploy.ps1
# Script automatizado para instalar Git, fazer upload para GitHub e deploy no Render

$ErrorActionPreference = "SilentlyContinue"

Write-Host "======================================"
Write-Host "AUTO DEPLOY - GloveStock"
Write-Host "======================================"

# Passo 1: Baixar Git
Write-Host "`n[1/5] Baixando Git..." -ForegroundColor Yellow
$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe"
$gitInstallerPath = "$env:TEMP\GitInstaller.exe"

try {
    Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing -ErrorAction Stop
    Write-Host "[OK] Git baixado" -ForegroundColor Green
} catch {
    Write-Host "[ERRO] Falha ao baixar Git. Instale manualmente em: https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# Passo 2: Instalar Git
Write-Host "`n[2/5] Instalando Git (pode levar 1-2 minutos)..." -ForegroundColor Yellow
& $gitInstallerPath /SILENT /NORESTART /NOCANCEL /SP- | Out-Null
Start-Sleep -Seconds 10

# Passo 3: Verificar instalacao
$gitPath = "C:\Program Files\Git\cmd\git.exe"
if (-Not (Test-Path $gitPath)) {
    Write-Host "[ERRO] Git nao foi instalado corretamente" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Git instalado com sucesso" -ForegroundColor Green

# Passo 4: Configurar repositorio local
Write-Host "`n[3/5] Configurando repositorio local..." -ForegroundColor Yellow
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"

& $gitPath config --global user.name "GloveStock"
& $gitPath config --global user.email "vendas@glovestock.local"
& $gitPath init
& $gitPath add .
& $gitPath commit -m "Inicial: Sistema de Vendas de Luvas - GloveStock"

Write-Host "[OK] Repositorio local criado" -ForegroundColor Green

# Passo 5: Instruçoes finais
Write-Host "`n[4/5] PROXIMOS PASSOS - Execute no PowerShell:" -ForegroundColor Cyan
Write-Host "`n1. Crie repositorio em: https://github.com/new" -ForegroundColor White
Write-Host "   Nome: sistema-luvas (publico)`n" -ForegroundColor White

Write-Host "2. Execute os comandos:" -ForegroundColor White
Write-Host "`n   git remote add origin https://github.com/SEU_USUARIO/sistema-luvas.git" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow

Write-Host "`n3. Deploy no Render: https://render.com" -ForegroundColor White
Write-Host "   - Conecte com GitHub" -ForegroundColor White
Write-Host "   - Name: glovestock" -ForegroundColor White
Write-Host "   - Start Command: gunicorn app:app" -ForegroundColor White

Write-Host "`n[5/5] Arquivos prontos para upload:" -ForegroundColor Cyan
& $gitPath ls-files | ForEach-Object { Write-Host "  - $_" }

Write-Host "`nQuando terminar, avise!" -ForegroundColor Green
