/* LIKE */

-- String que contém 'Harry Potter'
SELECT titulo, autor FROM livros
     WHERE titulo LIKE 'Harry Potter%';

-- String que contém múltiplos caracteres desconhecidos
SELECT titulo FROM livros
     WHERE titulo LIKE 'S%tio do % Amarelo';

/* BETWEEN */

-- Intervalo numérico
SELECT titulo, ano FROM livros
     WHERE ano BETWEEN 1950 and 2000;

/* OR */

SELECT titulo, autor FROM livros
     WHERE autor='George R. R. Martin'
     OR    autor='Miguel de Cervantes'
     OR    autor='C. S. Lewis'
     OR    autor='Agatha Christie';

/* IN */
SELECT titulo, autor FROM livros
     WHERE autor IN ('George R. R. Martin',
                     'Miguel de Cervantes',
                     'C. S. Lewis',
                     'Agatha Christie');
