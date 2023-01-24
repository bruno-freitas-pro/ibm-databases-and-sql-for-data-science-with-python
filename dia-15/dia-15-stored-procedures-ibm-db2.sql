/* Chamar a planilha carros inteira */

#SET TERMINATOR @
CREATE PROCEDURE RETRIEVE_ALL -- Nome do procedimento a ser armazenado

LANGUAGE SQL                  -- A linguagem que será utilizada na declaração
READS SQL DATA                -- A rotina lê dados da tabela

DYNAMIC RESULT SETS 1         -- Número máximo de conjuntos de resultados que serão retornados para a aplicação que fez a consulta

BEGIN                         -- Aqui começa o procedimento

  DECLARE C1 CURSOR           -- O cursor C1 manuseia o conjunto de resultados, recuperando linha a linha da tabela
  WITH RETURN FOR             -- A rotina deve retornar os registros recuperados como um conjunto de resultados para a aplicação que fez a consulta

  SELECT * FROM Carros;       -- A consulta em si

  OPEN C1;                    -- Mantém o CURSOR C1 aberto, para que o conjunto de resultados seja entregue à aplicação que fez a chamada

END                           -- Aqui termina o procedimento
@                             -- Aqui termina a rotina

/* Criar um procedimento que calcula o preço de venda do carro */

CREATE PROCEDURE INSERT_CAR_PRICE (IN id_carro_procedure INTEGER, IN Estado_conservacao VARCHAR(10))

LANGUAGE SQL
BEGIN
  --Estado_conservacao será atualizado independentemente do preço aplicado
  UPDATE carros
    SET Conservacao = UPPER(Estado_conservacao)
    WHERE id_carro = id_carro_procedure;

  IF UPPER(Estado_conservacao) = 'NOVO' THEN
    UPDATE carros
    SET Preco_venda = Preco_custo * 1.30
    WHERE id_carro = id_carro_procedure;
  ELSEIF UPPER(Estado_conservacao) = 'OTIMO' THEN
    UPDATE carros
    SET Preco_venda = Preco_custo * 1.15
    WHERE id_carro = id_carro_procedure;
  ELSEIF UPPER(Estado_conservacao) = 'BOM' THEN
    UPDATE carros
    SET Preco_venda = Preco_custo * 1.07
    WHERE id_carro = id_carro_procedure;
  END IF;
END
@

-- Testar se funcionou

CALL RETRIEVE_ALL;

CALL INSERT_CAR_PRICE(1, 'bom');
CALL INSERT_CAR_PRICE(2, 'otimo');
CALL INSERT_CAR_PRICE(3, 'novo');

CALL RETRIEVE_ALL;

