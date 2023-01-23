-- Selecionar uma tabela inteira
SELECT nome, sobrenome, data_nascimento FROM tabela1;

-- Selecionar linhas específicas de uma tabela
SELECT * FROM tabela1
    WHERE nome='Bruno';

-- Contar as linhas
SELECT COUNT(*) FROM tabela1;

-- Contar apenas as linhas que correspondem a um determinado filtro
SELECT COUNT(nome) FROM tabela1
    WHERE nome='Bruno';

-- Imprimir resultado sem linhas duplicadas
SELECT DISTINCT(nome) FROM tabela1;

-- Limitar a quantidade de linhas da saída
SELECT * FROM tabela1 LIMIT 50;

-- Selecionar as 3 primeiras linhas de uma tabela que correspondem a uma condição específica
SELECT * FROM tabela1
    WHERE nome='Isabela' LIMIT 3;
