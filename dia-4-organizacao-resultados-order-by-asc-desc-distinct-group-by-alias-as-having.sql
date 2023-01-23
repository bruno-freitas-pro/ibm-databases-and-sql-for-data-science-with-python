/* Ordenar os resultados */

-- Ordernar com base em uma coluna específica, usando o nome da coluna
SELECT * FROM livros
    ORDER BY titulo;


-- Ordenar com base em uma coluna específica, usando o número ordinal da coluna
SELECT * FROM livros
    ORDER BY 4; -- ASC (ordem ascendente) é um comando implícito


-- Ordenar do final para o início (descendente)
SELECT * FROM livros
    ORDER BY data_registro DESC;


-- Ordenar com base em mais de uma coluna
SELECT * FROM livros
    ORDER BY ano DESC, titulo DESC;


/* Selecionar resultados não duplicados */
SELECT DISTINCT(autor) FROM livros
    ORDER BY 1;


/* Agrupar resultados com base nos resultados de uma coluna específica */
SELECT autor, COUNT(autor) FROM livros
    GROUP BY autor;

/* Criar aliases */
SELECT autor AS "Nome do autor", COUNT(autor) AS  "qtde. livros" FROM livros
    GROUP BY autor;

/* Filtrar após agrupar */
SELECT autor AS "Nome do autor", COUNT(autor) AS  "qtde. livros" FROM livros
    GROUP BY autor
    HAVING COUNT(autor) >= 3;

-- WHERE faz o filtro ANTES de agrupar
-- HAVING faz o filtro DEPOIS de agrupar
