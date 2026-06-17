# Guia: Upload para GitHub e Deploy no Render

## Passo 1: Instalar Git (se não tiver)
1. Acesse: https://git-scm.com/download/win
2. Baixe e execute o instalador
3. Deixe as opções padrão
4. Clique em "Install"

Após instalar, reinicie o PowerShell.

---

## Passo 2: Configurar Git (primeira vez)
Execute no PowerShell:
```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@gmail.com"
```

---

## Passo 3: Criar Repositório Local
Na pasta `C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas`:
```powershell
git init
git add .
git commit -m "Inicial: Sistema de Vendas de Luvas - GloveStock"
```

---

## Passo 4: Criar Repositório no GitHub
1. Acesse: https://github.com/new
2. Preencha:
   - **Repository name:** `sistema-luvas`
   - **Description:** "Sistema de Vendas de Luvas - GloveStock"
   - **Visibility:** Public
3. Clique em "Create repository"

---

## Passo 5: Conectar Local com GitHub
Copie e execute no PowerShell (na pasta do projeto):
```powershell
git remote add origin https://github.com/SEU_USUARIO/sistema-luvas.git
git branch -M main
git push -u origin main
```
(Substitua `SEU_USUARIO` pelo seu usuário do GitHub)

---

## Passo 6: Deploy no Render
1. Acesse: https://render.com
2. Clique em "Sign Up" (ou "New +")
3. Crie conta ou faça login com GitHub
4. Clique em "New +" → "Web Service"
5. Conecte e selecione repositório `sistema-luvas`
6. Preencha:
   - **Name:** `glovestock`
   - **Language:** `Python`
   - **Start Command:** `gunicorn app:app`
7. Deixe "Free" selecionado e clique "Deploy Web Service"

---

**Em ~2 minutos você terá seu link:** `https://glovestock.onrender.com/pdv`
