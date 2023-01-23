/* Consultas baseadas em múltiplas tabelas */

-- Filtrar apenas livros que já têm o seu autor devidamente cadastrado

SELECT * FROM livros
    WHERE id_autor_livro IN
    (SELECT id_autor FROM autores);



-- Encontrar todos os livros escritos por autores brasileiros

SELECT * FROM livros
    WHERE id_autor_livro IN
    (SELECT id_autor FROM autores
        WHERE pais_autor = 'BR');



-- Encontrar todos os livros escritos por autores brasileiros ou norte-americanos

SELECT * FROM livros
    WHERE id_autor_livro IN
    (SELECT id_autor FROM autores
        WHERE pais_autor IN ('BR', 'US'));

/* JOIN */

-- CROSS JOIN implícito
SELECT * FROM livros, autores;

-- INNER JOIN implícito
SELECT * FROM livros, autores
    WHERE livros.id_autor_livro = autores.id_autor;

-- Reduzindo o tamanho da consulta usando aliases
SELECT * FROM livros L, autores A
    WHERE L.id_autor_livro = A.id_autor;

SELECT L.id_livro, A.nome_autor FROM livros L, autores A
    WHERE L.id_autor_livro = A.id_autor;
