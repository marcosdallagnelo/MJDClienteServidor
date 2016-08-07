program MJD.Cliente;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  uProtocolo in '..\Servidor\uProtocolo.pas',
  uCliente in 'uCliente.pas',
  uMJD.Messages in '..\Servidor\uMJD.Messages.pas',
  uPessoa in '..\Servidor\Model\uPessoa.pas',
  uConfig in '..\Servidor\uConfig.pas',
  uJSONPessoa in '..\Servidor\uJSONPessoa.pas',
  uMessageBox in 'uMessageBox.pas',
  CadastroPessoaForm in 'CadastroPessoaForm.pas' {frmCadastroPessoaForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
