# MJDClienteServidor
Exemplo de projeto cliente-servidor desenvolvido em delphi XE3, banco dados firebird 2.5 embedded, biblioteca synapse e serialização em JSON dos dados trafegados.<br />
O projeto servidor é um serviço windows, que recebe as requisições via TCP numa ip/porta, processa e persiste no banco dados. Para executar em debug, passa o parâmetro GUI ao iniciar.<br />
O projeto cliente utiliza monta as requisições e envia para o servidor através de um proxy.<br />
As informações trafegadas são serializado/deserizalido em JSON com a biblioteca nativa DBXJSON.<br />