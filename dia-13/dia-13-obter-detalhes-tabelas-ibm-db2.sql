-- Listar as tabelas que estão no banco de dados
SELECT * FROM syscat.tables;


-- Listar tabelas específicas
SELECT TABSCHEMA, TABNAME, CREATE_TIME
    FROM syscat.tables
    WHERE TABSCHEMA= ‘ABC12345’;


-- Listar as colunas de uma tabela específica
SELECT * FROM syscat.columns
    WHERE TABNAME= ‘gatos’

-- Listar dados específicos de tabelas específicas
SELECT DISTINCT(name), coltype, length
    FROM sysibm.syscolumns
    WHERE tbname = ‘gatos’
