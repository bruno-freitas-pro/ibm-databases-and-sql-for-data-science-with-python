CREATE DATABASE teste;

USE teste;

CREATE TABLE carros (
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

INSERT INTO carros (ID_carro, Proprietario, Placa, Fabricante, Ano_Fabricacao, Ano_Modelo, Modelo, Novo, Preco_custo)
VALUES
(1, 'João da Silva', 'AAA1111','Volkswagen', 2017, 2018, 'Polo', 0, 59990),
(2, 'Maria da Silva', 'BBB2222', 'Fiat', 2019, 2020, 'Toro', 0, 49900),
(3, 'Novo', 'Novo', 'Chevrolet', 2022, 2022, 'Cruze', 1, 99890);




/* Criar e armazenar o procedimento de consulta */

DELIMITER //                    -- Alteramos o delimitador de final para '//'
CREATE PROCEDURE RETRIEVE_ALL() -- Criamos o procedimento
BEGIN                           -- Começamos as instruções depois de BEGIN
  
  SELECT *  FROM carros;        -- A instrução que queremos rodar
  
END //                          -- Aqui terminam as instruções
DELIMITER ;                     -- Alteramos novamente o delimitador ao que estava configurado antes




/* Testar */

CALL RETRIEVE_ALL;



/* Conferir todos os procedimentos existentes */
SHOW PROCEDURE STATUS;

SHOW PROCEDURE STATUS [LIKE 'seu termo de pesquisa' | WHERE condição_buscada];

SHOW PROCEDURE STATUS
  WHERE UPPER(Db) = 'TESTE';




/* Criar o procedimento que calcula e salva os preços dos carros */

DELIMITER @
CREATE PROCEDURE INSERT_CAR_PRICE (IN id_carro_procedure INTEGER, IN Estado_conservacao VARCHAR(10))

BEGIN
  -- Estado_conservacao será atualizado independentemente do preço aplicado
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
  
END @

DELIMITER ;




/*  Testar tudo */

CALL RETRIEVE_ALL;

CALL INSERT_CAR_PRICE(1, 'bom');
CALL INSERT_CAR_PRICE(2, 'otimo');
CALL INSERT_CAR_PRICE(3, 'novo');

CALL RETRIEVE_ALL;
