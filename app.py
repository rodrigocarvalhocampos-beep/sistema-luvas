import sqlite3
import os
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATABASE = os.path.join(BASE_DIR, 'banco.db')

def obter_conexao():
    conexao = sqlite3.connect(DATABASE)
    conexao.row_factory = sqlite3.Row
    return conexao

def inicializar_banco():
    conexao = obter_conexao()
    cursor = conexao.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS produtos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            preco_venda REAL NOT NULL,
            quantidade_estoque INTEGER NOT NULL
        )
    ''')
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS vendas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            produto_id INTEGER NOT NULL,
            quantidade INTEGER NOT NULL,
            forma_pagamento TEXT NOT NULL,
            valor_total REAL NOT NULL,
            data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (produto_id) REFERENCES produtos (id)
        )
    ''')
    conexao.commit()
    conexao.close()

inicializar_banco()

# --- ROTAS ---

# ROTA INICIAL ATUALIZADA: Agora calcula o resumo financeiro para o relatório
@app.route('/')
def listar_produtos():
    conexao = obter_conexao()
    cursor = conexao.cursor()
    
    # 1. Busca os produtos
    cursor.execute('SELECT * FROM produtos')
    lista_de_produtos = cursor.fetchall()
    
    # 2. Calcula o Faturamento Total e a Quantidade de Vendas
    cursor.execute('SELECT SUM(valor_total) as faturamento, COUNT(id) as total_vendas FROM vendas')
    resultado_financeiro = cursor.fetchone()
    
    # Trata valores caso não existam vendas ainda
    faturamento = resultado_financeiro['faturamento'] if resultado_financeiro['faturamento'] else 0.0
    total_vendas = resultado_financeiro['total_vendas'] if resultado_financeiro['total_vendas'] else 0
    
    conexao.close()
    return render_template('produtos.html', 
                           produtos=lista_de_produtos, 
                           faturamento=faturamento, 
                           total_vendas=total_vendas)

@app.route('/cadastrar', methods=['POST'])
def cadastrar_produto():
    nome = request.form['nome']
    preco = float(request.form['preco'])
    estoque = int(request.form['estoque'])

    conexao = obter_conexao()
    cursor = conexao.cursor()
    cursor.execute('INSERT INTO produtos (nome, preco_venda, Drugquantidade_estoque) VALUES (?, ?, ?)', (nome, preco, estoque))
    cursor.execute('INSERT INTO produtos (nome, preco_venda, quantidade_estoque) VALUES (?, ?, ?)', (nome, preco, estoque))
    conexao.commit()
    conexao.close()
    return redirect(url_for('listar_produtos'))

@app.route('/pdv')
def tela_pdv():
    conexao = obter_conexao()
    cursor = conexao.cursor()
    cursor.execute('SELECT * FROM produtos')
    lista_de_produtos = cursor.fetchall()
    
    cursor.execute('''
        SELECT v.*, p.nome as nome_produto 
        FROM vendas v 
        JOIN produtos p ON v.produto_id = p.id 
        ORDER BY v.id DESC
    ''')
    lista_vendas = cursor.fetchall()
    
    conexao.close()
    return render_template('pdv.html', produtos=lista_de_produtos, vendas=lista_vendas)

@app.route('/vender', methods=['POST'])
def realizar_venda():
    produto_id = int(request.form['produto_id'])
    quantidade = int(request.form['quantidade'])
    forma_pagamento = request.form['forma_pagamento']

    conexao = obter_conexao()
    cursor = conexao.cursor()

    cursor.execute('SELECT preco_venda, quantidade_estoque FROM produtos WHERE id = ?', (produto_id,))
    produto = cursor.fetchone()

    if produto:
        valor_total = produto['preco_venda'] * quantidade
        novo_estoque = produto['quantidade_estoque'] - quantidade

        cursor.execute('''
            INSERT INTO vendas (produto_id, quantidade, forma_pagamento, valor_total)
            VALUES (?, ?, ?, ?)
        ''', (produto_id, quantidade, forma_pagamento, valor_total))

        cursor.execute('UPDATE produtos SET quantidade_estoque = ? WHERE id = ?', (novo_estoque, produto_id))
        conexao.commit()

    conexao.close()
    return redirect(url_for('tela_pdv'))

# Rota para exibir a Landing Page
@app.route('/promocao')
def exibir_landing():
    return render_template('landing.html')

# Rota para salvar o lead (comprador) e disparar o WhatsApp automático
@app.route('/capturar_lead', methods=['POST'])
def capturar_lead():
    nome = request.form['nome']
    whatsapp = request.form['whatsapp']
    empresa = request.form['empresa']
    demanda = request.form['demanda']
    
    # Aqui a engenharia do crescimento acontece:
    # 1. Nós criamos uma mensagem personalizada para o seu WhatsApp
    mensagem_texto = f"Olá, sou o {nome} da empresa {empresa}. Solicito a tabela de atacado para a demanda de {demanda} de Luvas de Vaqueta Mista a R$ 15,00."
    
    # 2. Link direto que abre o seu WhatsApp com a mensagem pronta que o cliente enviará
    # Substitua os zeros pelo SEU número de WhatsApp real (DDI + DDD + Número)
    seu_numero_whatsapp = "5519995759141" 
    
    link_redirecionamento = f"https://api.whatsapp.com/send?phone={seu_numero_whatsapp}&text={id_da_mensagem_se_houver_api...}"
    # Como queremos que abra o seu zap de forma direta e limpa para você fechar a venda:
    import urllib.parse
    texto_codificado = urllib.parse.quote(mensagem_texto)
    link_final = f"https://api.whatsapp.com/send?phone={seu_numero_whatsapp}&text={texto_codificado}"
    
    return redirect(link_final)

if __name__ == '__main__':
    app.run(debug=True)