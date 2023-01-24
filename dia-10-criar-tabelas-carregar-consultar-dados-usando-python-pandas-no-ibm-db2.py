import pandas
import ibm_db_dbi

criar_tabela = ibm_db.exec_immediate(conn,
"CREATE TABLE Carros(
Numero_Serie VARCHAR(20) PRIMARY KEY NOT NULL,
Modelo VARCHAR(20) NOT NULL,
Fabricante VARCHAR(20) NOT NULL);"
)

inserir_dados = ibm_db.exec_immediate(conn,
"INSERT INTO Carros(Numero_Serie, Modelo, Fabricante)
VALUES
('A1111', 'Gol', 'Volkswagen'),
('B2468', 'Palio', 'Fiat'),
('C1357', 'Onix', 'Chevrolet');"
)

listar_carros = ibm_db.exec_immediate(conn,
"SELECT * FROM Carros;")

ibm_db.fetch_both(listar_carros)

pandasConnection = ibm_db_dbi.Connection(conn)

df = pandas.read_sql('SELECT * FROM Carros', pandasConnection)

#imprimir o dataframe inteiro
print(df)

#imprimir só a primeira linha
print(df[0])

#imprimir só uma coluna
print(df.Modelo)

#imprimir só a primeira linha da coluna 'Modelo'
print(df.Modelo[0])

#Conferir a quantidade de linhas e colunas do DataFrame
print(df.shape)

ibm_db.close(conn)
