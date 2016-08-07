unit uServidorThread;

interface

uses
  Classes, blcksock, sockets, Synautil, SysUtils;

type
  TServidorThread = class(TThread)
  private
    procedure ProcessaConexao(ASocket: TTCPBlockSocket);
    function Retorno(Protocolo, Msg: string): string;
    function RetornoOK(MsgOk: string): string;
    function RetornoErro(MsgErro: string): string;
  protected
    procedure Execute; override;
  public
  end;

implementation

uses uConfig, uProtocolo, uJSONPessoa, uPessoa, uPessoaRepository;

procedure TServidorThread.Execute;
var
  ListenerSocket, ConnectionSocket: TTCPBlockSocket;
begin
  ListenerSocket := TTCPBlockSocket.Create;
  ConnectionSocket := TTCPBlockSocket.Create;

  ListenerSocket.CreateSocket;
  ListenerSocket.setLinger(True, 10);
  ListenerSocket.bind('0.0.0.0', Config.Porta);
  ListenerSocket.listen;

  while not Self.Terminated do
  begin
    if ListenerSocket.canread(1000) then
    begin
      ConnectionSocket.Socket := ListenerSocket.accept;
      ProcessaConexao(ConnectionSocket);
      ConnectionSocket.CloseSocket;
      ConnectionSocket.Purge;
    end;
  end;

  ListenerSocket.Free;
  ConnectionSocket.Free;
end;

procedure TServidorThread.ProcessaConexao(ASocket: TTCPBlockSocket);
var
  cmd, CmdRet: String;
  Protocolo: TProtocoloRequisicao;
  JSONPessoa: TJSONPessoa;
begin
  CmdRet := '';
  JSONPessoa := TJSONPessoa.Create();

  cmd := ASocket.RecvString(1000);

  try
    Protocolo := TProtocoloRequisicao.CreateFromString(cmd);

    with TPessoaRepository.Create() do
    begin
      case Protocolo.Operacao of
        opIncluir: Incluir(JSONPessoa.JsonToObject(Protocolo.Mensagem));
        opAlterar: Alterar(JSONPessoa.JsonToObject(Protocolo.Mensagem));
        opExcluir: Excluir(JSONPessoa.JsonToObject(Protocolo.Mensagem));
        opListar:
        begin
          CmdRet := JSONPessoa.ObjectToJson(TPessoaList.CreateInit(Listar()));
        end;
      end;
      ;
    end;

    ASocket.SendString(RetornoOK(CmdRet));
  except
    On E: Exception do
      ASocket.SendString(RetornoErro(E.Message));
  end;
end;

function TServidorThread.Retorno(Protocolo, Msg: string): string;
begin
  Result := Format(FORMAT_PROTOCOLO_RESP + CRLF, [Protocolo, Msg]);
end;

function TServidorThread.RetornoErro(MsgErro: string): string;
begin
  Result := Retorno(STATUS_ERRO, MsgErro);
end;

function TServidorThread.RetornoOK(MsgOk: string): string;
begin
  Result := Retorno(STATUS_OK, MsgOk);
end;

end.
