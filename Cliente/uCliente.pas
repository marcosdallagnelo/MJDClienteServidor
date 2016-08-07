unit uCliente;

interface

uses uProtocolo, System.SysUtils, System.Classes, System.Generics.Collections,
  blcksock, Web.Win.Sockets;

type
  EClienteErro = class(Exception);

  TCliente<T: class> = class
  private
    Socket: TTCPBlockSocket;
    FHost: string;
    FPorta: string;
    function Execute(Protocolo: TOperacaoProtocolo; Mensagem: String): TProtocoloResposta;
    function GetModelName: string;
  public
    constructor Create(const AHost, APorta: string);
    destructor Destroy; override;

    function ExecuteIncluir(Mensagem: String): TProtocoloResposta;
    function ExecuteAlterar(Mensagem: String): TProtocoloResposta;
    function ExecuteExcluir(Mensagem: String): TProtocoloResposta;
    function ExecuteListar(Mensagem: String): TProtocoloResposta;

    property Host: string read FHost;
    property Porta: string read FPorta;
    property ModelName: string read GetModelName;
  end;

implementation


{ TCliente }

uses uMJD.Messages;

constructor TCliente<T>.Create(const AHost, APorta: string);
begin
  FHost := AHost;
  FPorta := APorta;

  Socket := TTCPBlockSocket.create;
end;

destructor TCliente<T>.Destroy;
begin
  Socket.Free;
  inherited;
end;

function TCliente<T>.Execute(Protocolo: TOperacaoProtocolo;
  Mensagem: String): TProtocoloResposta;
var cmd: AnsiString;
begin
  cmd := Format(FORMAT_PROTOCOLO_REQ + CRLF, [TOperacaoProtocoloString[Protocolo],
    ModelName, Mensagem]);

  try
    Socket.Connect(Host, Porta);

    if (Socket.LastError <> 0) then
      raise EClienteErro.CreateFmt(rsConexaoFalhou, [Socket.LastErrorDesc, Socket.GetErrorDescEx]);

    Socket.SendString(cmd);

    if Socket.CanRead(50000) then
    begin
      Result := TProtocoloResposta.CreateFromString(Socket.RecvString(1000));
    end
    else
      raise EClienteErro.Create(rsServidorNaoRespondendo);
  finally
    Socket.CloseSocket();
    Socket.Purge;
  end;
end;

function TCliente<T>.ExecuteAlterar(Mensagem: String): TProtocoloResposta;
begin
  Result := Execute(opAlterar, Mensagem);
end;

function TCliente<T>.ExecuteExcluir(Mensagem: String): TProtocoloResposta;
begin
  Result := Execute(opExcluir, Mensagem);
end;

function TCliente<T>.ExecuteIncluir(Mensagem: String): TProtocoloResposta;
begin
  Result := Execute(opIncluir, Mensagem);
end;

function TCliente<T>.ExecuteListar(Mensagem: String): TProtocoloResposta;
begin
  Result := Execute(opListar, Mensagem);
end;

function TCliente<T>.GetModelName: string;
begin
  Result := StringReplace(T.ClassName, 'T', '', []);
end;

end.
