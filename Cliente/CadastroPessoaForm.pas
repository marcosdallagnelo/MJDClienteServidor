unit CadastroPessoaForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uPessoa;

type
  TfrmCadastroPessoaForm = class(TForm)
    edtId: TEdit;
    lblId: TLabel;
    edtNome: TEdit;
    lblNome: TLabel;
    lblProfissao: TLabel;
    edtProfissao: TEdit;
    lblNaturalidade: TLabel;
    edtNaturalidade: TEdit;
    btnGravar: TButton;
    btnSair: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
  private
    function GetIsIncluir: Boolean;
    function GetPessoa: TPessoa;
    property IsIncluir: Boolean read GetIsIncluir;
    property Pessoa: TPessoa read GetPessoa;
  public
    procedure CarregaDados(APessoa: TPessoa);
  end;

var
  frmCadastroPessoaForm: TfrmCadastroPessoaForm;

implementation

{$R *.dfm}

uses uCliente, uMessageBox, uMJD.Messages, uProtocolo, uJSONPessoa,
  uConfig;

procedure TfrmCadastroPessoaForm.btnGravarClick(Sender: TObject);
var Cliente: TCLiente<TPessoa>;
    Resposta: TProtocoloResposta;
    JSONPessoa: TJSONPessoa;
    teste: string;
    Pes: TPessoa;
begin
  if (edtNome.Text = '') then
  begin
    MessageBox.MessageOk(rsInformeNome);
    if edtNome.CanFocus then
      edtNome.SetFocus();
    Exit;
  end;

  JSONPessoa := TJSONPessoa.Create;
  teste := JSONPessoa.ObjectToJson(Pessoa);
  Pes := JSONPessoa.JsonToObject(teste);
  try
    Cliente := TCLiente<TPessoa>.Create(Config.Host, Config.Porta);
    try
      try
        if (IsIncluir) then
          Resposta := Cliente.ExecuteIncluir(JSONPessoa.ObjectToJson(Pessoa))
        else
          Resposta := Cliente.ExecuteAlterar(JSONPessoa.ObjectToJson(Pessoa));

        if (Resposta.Status = spErro) then
          MessageBox.MessageError(Resposta.Mensagem)
        else
        begin
          Close;
          ModalResult := mrOk;
        end;
      except
        on E: Exception do
          MessageBox.MessageError(E.Message);
      end;
    finally
      Cliente.Free();
    end;
  finally
    JSONPessoa.Free;
  end;
end;

procedure TfrmCadastroPessoaForm.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPessoaForm.CarregaDados(APessoa: TPessoa);
begin
  edtId.Text := IntToStr(APessoa.Id);
  edtNome.Text := APessoa.Nome;
  edtProfissao.Text := APessoa.Profissao;
  edtNaturalidade.Text := APessoa.Naturalidade;
end;

procedure TfrmCadastroPessoaForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TfrmCadastroPessoaForm.GetIsIncluir: Boolean;
begin
  Result := (edtId.Text = '');
end;

function TfrmCadastroPessoaForm.GetPessoa: TPessoa;
begin
  Result := TPessoa.Create();
  try
    Result.Id := StrToInt(edtId.Text);
  except
    Result.Id := 0;
  end;

  Result.Nome := edtNome.Text;
  Result.Profissao := edtProfissao.Text;
  Result.Naturalidade := edtNaturalidade.Text;
end;

end.
