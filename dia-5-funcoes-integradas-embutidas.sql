/* Funções de agregação */

-- SUM (soma)
SELECT SUM(valor_total) FROM notas_fiscais;

SELECT SUM(valor_total) FROM notas_fiscais
    WHERE data_emissao LIKE '%2021%';

SELECT SUM(valor_total) FROM notas_fiscais
    WHERE YEAR(data_emissao) = 2021;

SELECT SUM(valor_total) AS 'faturamento bruto' FROM notas_fiscais
    WHERE YEAR(data_emissao) = 2021;



-- MIN (menor valor encontrado)
SELECT MIN(valor_total) FROM notas_fiscais
    WHERE YEAR(data_emissao) = 2021;



-- MAX (maior valor encontrado)
SELECT MAX(valor_total) FROM notas_fiscais
    WHERE YEAR(data_emissao) = 2021;



-- AVG (média simples)
SELECT AVG(valor_total) FROM notas_fiscais
    WHERE YEAR(data_emissao) = 2021;

SELECT AVG(valor_total / quantidade) FROM notas_fiscais
    WHERE grupo_produto = 'animais' AND subgrupo_produto = 'cachorro';



/* Funções escalares e de cadeias de caracteres (strings) */


-- ROUND (arredondamento)
-- Sintaxe: ROUND(número, qtde_casas, operacao)

SELECT ROUND(valor_total) FROM notas_fiscais;

SELECT ROUND(valor_total, 2) FROM notas_fiscais;



-- LENGTH (comprimento)

SELECT LENGTH(nome_cliente) FROM notas_fiscais;



-- UPPER ou UCASE (maiúsculas)

SELECT UCASE(nome_cliente) FROM notas_fiscais;

SELECT UPPER(nome_cliente) FROM notas_fiscais;



-- LOWER e LCASE (minúsculas)

SELECT LCASE(nome_cliente) FROM notas_fiscais;

SELECT LOWER(nome_cliente) FROM notas_fiscais;

SELECT * FROM notas_fiscais
    WHERE LCASE(nome_cliente) LIKE 'pedro%';

SELECT * FROM notas_fiscais
    WHERE LCASE(nome_cliente) LIKE '%pedro%';

SELECT DISTINCT(UCASE(nome_cliente) as CLIENTE
FROM notas_fiscais
    WHERE UCASE(nome_cliente) LIKE '%PEDRO%';



/* Funções de data */

-- Procurar por uma data ou hora
SELECT COUNT(*) FROM notas_fiscais
    WHERE MONTH(data_emissao) = '12';

-- Realizar cálculo de datas
SELECT * FROM contas_a_pagar
    WHERE data_vencimento = (CURRENT_DATE + 1);

-- Realizar cálculo de datas no MySQL
SELECT * FROM contas_a_pagar
    WHERE data_vencimento = DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY);

-- Calcular aging list de títulos vencidos e a vencer (IBM Db2)
SELECT id_titulo, fornecedor, data_vencimento, valor, (CURRENT_DATE - data_vencimento) AS dias_vencto
FROM contas_a_pagar
    WHERE pago = FALSE
    ORDER BY 5 DESC;

-- Calcular aging list de títulos vencidos e a vencer (MySQL)
SELECT id_titulo, fornecedor, data_vencimento, valor, DATEDIFF(CURRENT_DATE, data_vencimento) AS dias_vencto
FROM contas_a_pagar
    WHERE pago = FALSE
    ORDER BY 5 DESC;
