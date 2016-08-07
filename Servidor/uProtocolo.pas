unit uProtocolo;

interface

uses System.Classes, System.SysUtils, Synautil;

type
  EProtocoloError = class(Exception);
  TOperacaoProtocolo = (opIncluir = 1, opAlterar, opExcluir, opListar);

  TProtocoloRequisicao = class
  private
    FOperacao: TOperacaoProtocolo;
    FModel: string;
    FMensagem: string;
  public
    class function CreateFromString(cmd: string): TProtocoloRequisicao;
    class function GetOperacaoFromString(ATipo: string): TOperacaoProtocolo;

    property Operacao: TOperacaoProtocolo read FOperacao;
    property Model: string read FModel;
    property Mensagem: string read FMensagem;
  end;

  TStatusProtocolo = (spOk = 1, spErro);

  TProtocoloResposta = class
  private
    FStatus: TStatusProtocolo;
    FMensagem: string;
  public
    class function CreateFromString(cmd: string): TProtocoloResposta;

    property Status: TStatusProtocolo read FStatus;
    property Mensagem: string read FMensagem;
  end;

const
  OPERACAO_INCLUIR = 'INCLUIR';
  OPERACAO_ALTERAR = 'ALTERAR';
  OPERACAO_EXCLUIR = 'EXCLUIR';
  OPERACAO_LISTAR = 'LISTAR';

  FORMAT_PROTOCOLO_REQ = '%s_%s %s';
  FORMAT_PROTOCOLO_RESP = '%s %s';

  STATUS_OK = 'OK';
  STATUS_ERRO = 'ERRO';

  TOperacaoProtocoloString: array[TOperacaoProtocolo] of string = (OPERACAO_INCLUIR,
    OPERACAO_ALTERAR, OPERACAO_EXCLUIR, OPERACAO_LISTAR);

  TStatusProtocoloString: array[TStatusProtocolo] of string = (STATUS_OK,
    STATUS_ERRO);

implementation

{ TProtocolo }

uses uMJD.Messages;

class function TProtocoloRequisicao.CreateFromString(cmd: string): TProtocoloRequisicao;
var Parte, Operacao: string;
begin
  if (cmd = '') then
    raise EProtocoloError.Create(rsProtocoloNaoInformado);

  Result := TProtocoloRequisicao.Create();

  Parte := Fetch(cmd, ' ');
  Operacao := Fetch(Parte, '_');
  Result.FOperacao := TProtocoloRequisicao.GetOperacaoFromString(Operacao);

  Result.FModel := Fetch(Parte, '_');
  Result.FMensagem := cmd;
end;

class function TProtocoloRequisicao.GetOperacaoFromString(
  ATipo: string): TOperacaoProtocolo;
begin
  if AnsiSameText(ATipo, OPERACAO_INCLUIR) then
    Result := opIncluir
  else if AnsiSameText(ATipo, OPERACAO_ALTERAR) then
    Result := opAlterar
  else if AnsiSameText(ATipo, OPERACAO_EXCLUIR) then
    Result := opExcluir
  else if AnsiSameText(ATipo, OPERACAO_LISTAR) then
    Result := opListar
  else
    raise EProtocoloError.CreateFmt(rsOperacaoNaoSuportada, [ATipo]);
end;

{ TProtocoloResposta }

class function TProtocoloResposta.CreateFromString(
  cmd: string): TProtocoloResposta;
var Parte: string;
begin
  if (cmd = '') then
    raise EProtocoloError.Create(rsProtocoloNaoInformado);

  Result := TProtocoloResposta.Create();

  Parte := Fetch(cmd, ' ');

  if AnsiSameText(Parte, STATUS_OK) then
    Result.FStatus := spOk
  else if AnsiSameText(Parte, STATUS_ERRO) then
    Result.FStatus := spErro
  else
    raise EProtocoloError.CreateFmt(rsStatusNaoSuportado, [Parte]);

  Result.FMensagem := cmd;
end;

end.
