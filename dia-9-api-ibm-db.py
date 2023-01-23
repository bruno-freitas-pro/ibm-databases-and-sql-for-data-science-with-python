!pip install --force-reinstall ibm_db==3.1.0 ibm_db_sa==0.3.3
!pip uninstall sqlalchemy==1.4 -y && pip install sqlalchemy==1.3.24
!pip install ipython-sql

import ibm_db

#Informar os dados
dsn_hostname = # e.g.: "54a2f15b-5c0f-46df-8954-7e38e612c2bd.c1ogj3sd0tgtu0lqde00.databases.appdomain.cloud"
dsn_uid = # e.g. "abc12345"
dsn_pwd = # e.g. "7dBZ3wWt9XN6$o0J"

dsn_driver = "{IBM DB2 ODBC DRIVER}"
dsn_database = # e.g. "BLUDB"
dsn_port = # e.g. "32733" 
dsn_protocol = # i.e. "TCPIP"
dsn_security = #i.e. "SSL"


#Criar a conexão ao banco de dados
dsn = (
    "DRIVER={{IBM DB2 ODBC DRIVER}};"
    "DATABASE={0};"
    "HOSTNAME={1};"
    "PORT={2};"
    "PROTOCOL=TCPIP;"
    "UID={3};"
    "PWD={4};").format(dsn_database, dsn_hostname, dsn_port, dsn_uid, dsn_pwd)

try:
    conn = ibm_db.connect(dsn, "nome_de_usuario", "senha")
    print ("Conectado!")

except:
    print ("Ocorreu um erro ao tentar conectar ao servidor.")



#Obter os metadados do servidor
servidor = ibm_db.server_info(conn)

print ("Nome do SGBD:", servidor.DBMS_NAME)
print ("Versão do SGBD:", servidor.DBMS_VER)
print ("Nome do banco de dados:", servidor.DB_NAME)

#Obter os metadados do cliente e do driver
client = ibm_db.client_info(conn)

print ("Nome do driver:             ", client.DRIVER_NAME) 
print ("Versão do driver:           ", client.DRIVER_VER)
print ("Nome da fonte de dados:     ", client.DATA_SOURCE_NAME)
print ("Versão do Driver ODBC:      ", client.DRIVER_ODBC_VER)
print ("Versão do ODBC:             ", client.ODBC_VER)
print ("Conformidade do ODBC a SQL: ", client.ODBC_SQL_CONFORMANCE)
print ("Codificação do aplicativo:  ", client.APPL_CODEPAGE)
print ("Codificação da conexão:     ", client.CONN_CODEPAGE)

ibm_db.close(conn)
