# CHECKLIST — Pausa e Retomada

## Parar (hoje)
- Parar servidor local: no terminal que executa o Flask pressione `Ctrl+C`.
- (Opcional) Desativar venv:

```powershell
# (opcional)
deactivate
```

- Commit & push do trabalho atual (execute na pasta do projeto):

```powershell
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"
& "C:\Program Files\Git\cmd\git.exe" add -A
& "C:\Program Files\Git\cmd\git.exe" commit -m "WIP: pausando trabalho"
& "C:\Program Files\Git\cmd\git.exe" push
```

- Observação: não é necessário parar o serviço no Render — ele continua online.

## Retomar (amanhã)
1. Atualizar o repositório local:

```powershell
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"
& "C:\Program Files\Git\cmd\git.exe" pull
```

2. Ativar o virtualenv:

```powershell
.\venv\Scripts\Activate.ps1
```

3. Instalar dependências (se necessário):

```powershell
.\venv\Scripts\python.exe -m pip install -r requirements.txt
```

4. Rodar localmente:

```powershell
.\venv\Scripts\python.exe app.py
```

- Abra no navegador: `http://127.0.0.1:5000`

## Verificações rápidas
- Verifique o status do deploy no painel do Render: https://dashboard.render.com
- Se usou um PAT e quer limpar credenciais, abra "Credential Manager" no Windows e remova entradas GitHub.

## Nota de segurança
- Nunca cole tokens (PAT) em chats ou arquivos públicos. Revogue tokens expostos imediatamente.

---
Feito por automação — retome quando estiver pronto.