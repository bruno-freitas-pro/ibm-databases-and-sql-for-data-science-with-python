#Instalar o sqlite3
!pip install sqlite3

import sqlite3
import pandas as pd

### Criando a conexão ###

conexao = sqlite3.connect('Carros.db')

objeto_cursor = conexao.cursor()

### Criar uma tabela ###

# Apagar a tabela carros, caso ela exista
objeto_cursor.execute("DROP TABLE IF EXISTS Carros")

# Criar a tabela carros
tabela="""CREATE TABLE IF NOT EXISTS Carros(
Numero_Serie VARCHAR(20) PRIMARY KEY NOT NULL,
Modelo VARCHAR(20) NOT NULL,
Fabricante VARCHAR(20) NOT NULL);"""
objeto_cursor.execute(tabela)
print("A tabela está pronta para uso!")

#Inserir algumas linhas na tabela
objeto_cursor.execute ('''INSERT INTO Carros(Numero_Serie, Modelo, Fabricante)
VALUES
('A1111', 'Gol', 'Volkswagen'),
('B2468', 'Palio', 'Fiat'),
('C1357', 'Onix', 'Chevrolet');'''
)

#Fazer uma consulta e imprimir os resultados em tela
instrucao = '''SELECT * FROM Carros'''
objeto_cursor.execute(instrucao)
Print("Dados da tabela inteira")
tabela_inteira = objeto_cursor.fetchall()
for linha_tabela in tabela_inteira:
    print(linha_tabela)

#Consultar linhas específicas de uma tabela
instrucao = '''SELECT * FROM Carros'''
objeto_cursor.execute(instrucao)
Print("Primeiras duas linhas da tabela")
duas_linhas = objeto_cursor.fetchmany(2)
for linha_tabela in duas_linhas:
    print(linha_tabela)

#Criar um DataFrame com os dados
df = pd.read_sql_query("SELECT * FROM Carros;", conexao)
print(df)

conexao.close()
