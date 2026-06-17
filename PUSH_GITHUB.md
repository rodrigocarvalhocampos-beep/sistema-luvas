# Push para GitHub - Modo Manual

## Opção 1: Via GitHub Desktop (mais fácil)

1. Baixe GitHub Desktop: https://desktop.github.com/
2. Abra e faça login com sua conta GitHub (casabrancaepi)
3. Clique em "Add" → "Add Local Repository"
4. Navegue até: `C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas`
5. Clique em "Publish repository"
6. Nomeie como: `sistema-luvas`
7. Deixe "Public" marcado
8. Clique em "Publish Repository"

**PRONTO!** Seus arquivos estão no GitHub.

---

## Opção 2: Via PowerShell com Token (mais seguro)

1. Crie um Personal Access Token no GitHub:
   - Vá para: https://github.com/settings/tokens
   - Clique em "Generate new token"
   - Marque "repo"
   - Copie o token gerado

2. Execute no PowerShell:
```powershell
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"
git config --global user.name "casabrancaepi"
git config --global user.email "seu.email@gmail.com"

$token = "seu_token_aqui"
$repo = "https://$($token)@github.com/casabrancaepi/sistema-luvas.git"
git remote remove origin 2>$null
git remote add origin $repo
git push -u origin main
```

---

## Opção 3: Via HTTPS com CredentialManager (automático)

1. Execute no PowerShell:
```powershell
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"
git config --global user.name "casabrancaepi"
git config --global user.email "seu.email@gmail.com"

git remote remove origin 2>$null
git remote add origin https://github.com/casabrancaepi/sistema-luvas.git
git push -u origin main
```

2. Uma janela vai aparecer pedindo suas credenciais do GitHub
3. Digite seu usuário e senha (ou token)

---

Escolha a opção que preferir e me avise quando terminar!
