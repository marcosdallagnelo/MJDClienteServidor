unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  uCliente, Vcl.StdCtrls, System.Generics.Collections, uPessoa, uJSONPessoa,
  MidasLib, Data.DB, Datasnap.DBClient;

type
  TfrmMain = class(TForm)
    pnlBotoes: TPanel;
    dbgrdPessoa: TDBGrid;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnListar: TButton;
    dsPessoa: TDataSource;
    cdsPessoa: TClientDataSet;
    cdsPessoaid: TIntegerField;
    cdsPessoanome: TStringField;
    cdsPessoaprofissao: TStringField;
    cdsPessoanaturalidade: TStringField;
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    JSONPessoa: TJSONPessoa;
    Cliente: TCliente<TPessoa>;
    procedure CarregaCDS(APessoas: TPessoas);
    procedure Listar;
    function RegistroSelecionado: Boolean;
    function GetPessoaSelecionada: TPessoa;

    property PessoaSelecionada: TPessoa read GetPessoaSelecionada;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uConfig, uProtocolo, uMessageBox, uMJD.Messages, CadastroPessoaForm;

procedure TfrmMain.btnAlterarClick(Sender: TObject);
begin
  if (RegistroSelecionado()) then
  begin
    Application.CreateForm(TfrmCadastroPessoaForm, frmCadastroPessoaForm);
    frmCadastroPessoaForm.CarregaDados(PessoaSelecionada);
    if frmCadastroPessoaForm.ShowModal() = mrOk then
      Listar();
  end;
end;

procedure TfrmMain.btnExcluirClick(Sender: TObject);
Var Resposta: TProtocoloResposta;
begin
  if (RegistroSelecionado() AND MessageBox.MessageYesNo(rsConfirmaExclusao)) then
  begin
    try
      Resposta := Cliente.ExecuteExcluir(JSONPessoa.ObjectToJson(PessoaSelecionada));
      if (Resposta.Status = spOk) then
        Listar()
      else
        MessageBox.MessageError(Resposta.Mensagem, TStatusProtocoloString[Resposta.Status]);
    except
      on E: Exception do
        MessageBox.MessageError(E.Message);
    end;
  end;
end;

procedure TfrmMain.btnIncluirClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroPessoaForm, frmCadastroPessoaForm);
  if frmCadastroPessoaForm.ShowModal() = mrOk then
    Listar();
end;

procedure TfrmMain.btnListarClick(Sender: TObject);
begin
  Listar();
end;

procedure TfrmMain.CarregaCDS(APessoas: TPessoas);
var Pessoa: TPessoa;
begin
  cdsPessoa.EmptyDataSet();
  for Pessoa in APessoas do
  begin
    cdsPessoa.Append();
    cdsPessoaid.AsInteger := Pessoa.Id;
    cdsPessoanome.AsString := Pessoa.Nome;
    cdsPessoaprofissao.AsString := Pessoa.Profissao;
    cdsPessoanaturalidade.AsString := Pessoa.Naturalidade;
    cdsPessoa.Post();
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cliente.Free();
  JSONPessoa.Free;

  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Cliente := TCliente<TPessoa>.Create(Config.Host, Config.Porta);
  JSONPessoa := TJSONPessoa.Create;

  Listar();
end;

function TfrmMain.GetPessoaSelecionada: TPessoa;
begin
  Result := TPessoa.Create();
  Result.Id := cdsPessoaid.AsInteger;
  Result.Nome := cdsPessoanome.AsString;
  Result.Profissao := cdsPessoaprofissao.AsString;
  Result.Naturalidade := cdsPessoanaturalidade.AsString;
end;

procedure TfrmMain.Listar;
Var Resposta: TProtocoloResposta;
begin
  try
    Resposta := Cliente.ExecuteListar('');
    if (Resposta.Status = spOk) then
      CarregaCDS(JSONPessoa.JsonToObjectList(Resposta.Mensagem).Pessoas)
    else
      MessageBox.MessageError(Resposta.Mensagem, TStatusProtocoloString[Resposta.Status]);
  except
    on E: Exception do
      MessageBox.MessageError(E.Message);
  end;
end;

function TfrmMain.RegistroSelecionado: Boolean;
begin
  Result := not cdsPessoa.IsEmpty;

  if not Result then
    MessageBox.MessageOk(rsSelecioneRegistro);
end;

end.
