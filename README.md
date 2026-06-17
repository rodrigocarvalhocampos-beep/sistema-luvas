# Sistema Vendas Luvas - Setup rápido

Instruções rápidas para Windows (PowerShell):

1. Instale Python (recomendado 3.11/3.12) a partir de: https://www.python.org/downloads/windows/
   - Durante a instalação, marque **Add Python to PATH**.

2. Abra PowerShell e verifique a instalação:
```powershell
python --version
py --version
where python
```

3. Crie e ative um virtualenv no diretório do projeto:
```powershell
cd "C:\Users\rodrigo.campos\Desktop\Sistema_vendas_luvas"
python -m venv venv
# Ativar no PowerShell
.\venv\Scripts\Activate.ps1
# Se houver bloqueio de execução de scripts, permita temporariamente:
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

4. Instale dependências:
```powershell
pip install --upgrade pip
pip install -r requirements.txt
```

5. Rode a aplicação:
```powershell
python app.py
```
O Flask deve aparecer rodando em http://127.0.0.1:5000/

6. Problemas comuns:
- "Python não foi encontrado": reinstale e marque "Add Python to PATH" ou adicione `C:\Python...` ao PATH manualmente.
- Erro ao ativar venv no PowerShell: usar `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` temporariamente.

Se quiser, eu posso tentar executar os comandos de verificação (`python --version`, `where python`) aqui depois que você instalar o Python.
