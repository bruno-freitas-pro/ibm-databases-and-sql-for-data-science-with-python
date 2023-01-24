CREATE TABLE Carros (
                     ID_Carro INTEGER PRIMARY KEY NOT NULL,
                     Proprietario VARCHAR(50) NOT NULL,
                     Placa CHAR(7) UNIQUE NOT NULL,
                     Fabricante VARCHAR(20) NOT NULL,
                     Ano_Fabricacao INTEGER NOT NULL,
                     Ano_Modelo INTEGER NOT NULL,
                     Modelo VARCHAR(20) NOT NULL,
                     Novo BOOLEAN NOT NULL,
                     Preco_custo INTEGER NOT NULL,
                     Preco_venda INTEGER,
                     Conservacao VARCHAR(10)
                     );

INSERT INTO Carros (ID_carro, Proprietario, Placa, Fabricante, Ano_Fabricacao, Ano_Modelo, Modelo, Novo, Preco_custo)
VALUES
(1, 'João da Silva', 'AAA1111','Volkswagen', 2017, 2018, 'Polo', 0, 59990),
(2, 'Maria da Silva', 'BBB2222', 'Fiat', 2019, 2020, 'Toro', 0, 49900),
(3, 'Novo', 'Novo', 'Chevrolet', 2022, 2022, 'Cruze', 1, 99890);

-- Criando a visualização
CREATE VIEW
	lista_carros_usados (
						 Modelo,
						 Ano,
						 "Ano Modelo",
						 Marca
						)
AS
SELECT
	Modelo,
	Ano_Fabricacao,
	Ano_Modelo,
	Fabricante
FROM
	Carros
WHERE
	Novo = 0


SELECT * FROM lista_carros_usados

-- Excluir a view
DROP VIEW lista_carros_usados

-- Criar outra view
CREATE OR REPLACE VIEW
	lista_carros_usados (
						 Modelo,
						 "Ano Modelo",
						 )
AS
SELECT
	Modelo,
	Ano_Modelo,
FROM
	Carros
WHERE
	Novo = 0
