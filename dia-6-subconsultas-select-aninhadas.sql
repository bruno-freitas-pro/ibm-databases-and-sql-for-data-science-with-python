/* Introdução às subconsultas */

-- Consultar quais são os trabalhadores que possuem salário maior do que a média da empresa
-- Jeito que não funciona

SELECT * FROM empregados
    WHERE salario > AVG(salario);

-- Jeito que funciona

SELECT id_empregado, nome, sobrenome, salario FROM empregados
    WHERE salario > (SELECT AVG(salario) FROM empregados);

/* Expressões colunares */

-- Imprimir a média salarial da empresa em cada uma das linhas, possibilitando comparar com o salário do colaborador

-- Jeito que não funciona
SELECT id_empregado, salario,
   AVG(salario)
        AS salario_medio
   FROM empregados;

-- Jeito que funciona
SELECT id_empregado, salario,
    (SELECT AVG(salario) FROM empregados)
        AS salario_medio
    FROM empregados;



/* Subconsulta dentro de FROM */

-- Criar uma consulta que exponha apenas os dados não sensíveis dos empregados (no futuro entenderemos como usar VIEWS, que são formas melhores de fazer isso)
SELECT * FROM (SELECT id_empregado, nome, sobrenome, id_gerente, id_departamento
               FROM empregados)
               AS empregados_lgpd;
