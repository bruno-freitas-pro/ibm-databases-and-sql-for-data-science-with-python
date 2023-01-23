/* INSERT */

-- Uma linha por vez
INSERT INTO tabela1 (id_cliente, cpf, sobrenome, telefone, nome)
    VALUES
        (1, '111.111.111-11', 'Freitas', '(288)555-0153', 'Bruno');

-- Várias linhas por vez
INSERT INTO tabela1 (id_cliente, nome, sobrenome, telefone, cpf)
    VALUES
        (1, 'Bruno', 'Freitas', '(288)555-0153', '111.111.111-11'),
        (2, 'Isabela', 'Capetti', '(212)555-2368', '222.222.222-22');

/* UPDATE */

UPDATE tabela1
SET telefone='(288)555-0134',
    sobrenome='da Silva Freitas'
    WHERE id_cliente=1;

-- NUNCA, NUNCA, NUNCA FAZER UPDATE SEM WHERE. SUJEITO A DEMISSÃO.

/* DELETE */

-- Apagar linhas específicas
DELETE FROM tabela1 WHERE id_cliente IN (1, 2);

-- NUNCA, NUNCA, NUNCA FAZER DELETE SEM WHERE. A DEMISSÃO É MUITO PROVÁVEL.
