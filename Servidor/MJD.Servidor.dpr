program MJD.Servidor;

uses
  Vcl.SvcMgr,
  Vcl.Forms,
  System.SysUtils,
  srvMJDService in 'srvMJDService.pas' {MJDService: TService},
  uSelfApp in 'uSelfApp.pas',
  uMJD.Messages in 'uMJD.Messages.pas',
  uFirebirdConnection in 'Impl\uFirebirdConnection.pas',
  uIBaseRepository in 'Interface\uIBaseRepository.pas',
  uIConnection in 'Interface\uIConnection.pas',
  uPessoa in 'Model\uPessoa.pas',
  uBaseRepository in 'Repository\uBaseRepository.pas',
  uPessoaRepository in 'Repository\uPessoaRepository.pas',
  asn1util in '..\synapse40\source\lib\asn1util.pas',
  blcksock in '..\synapse40\source\lib\blcksock.pas',
  clamsend in '..\synapse40\source\lib\clamsend.pas',
  dnssend in '..\synapse40\source\lib\dnssend.pas',
  ftpsend in '..\synapse40\source\lib\ftpsend.pas',
  ftptsend in '..\synapse40\source\lib\ftptsend.pas',
  httpsend in '..\synapse40\source\lib\httpsend.pas',
  imapsend in '..\synapse40\source\lib\imapsend.pas',
  nntpsend in '..\synapse40\source\lib\nntpsend.pas',
  pingsend in '..\synapse40\source\lib\pingsend.pas',
  pop3send in '..\synapse40\source\lib\pop3send.pas',
  slogsend in '..\synapse40\source\lib\slogsend.pas',
  smtpsend in '..\synapse40\source\lib\smtpsend.pas',
  snmpsend in '..\synapse40\source\lib\snmpsend.pas',
  sntpsend in '..\synapse40\source\lib\sntpsend.pas',
  ssl_openssl in '..\synapse40\source\lib\ssl_openssl.pas',
  synamisc in '..\synapse40\source\lib\synamisc.pas',
  tlntsend in '..\synapse40\source\lib\tlntsend.pas',
  uServidorThread in 'uServidorThread.pas',
  uConfig in 'uConfig.pas',
  ServidorForm in 'ServidorForm.pas' {frmServidor},
  uProtocolo in 'uProtocolo.pas',
  uJSONPessoa in 'uJSONPessoa.pas',
  ldapsend in '..\synapse40\source\lib\ldapsend.pas';

{$R *.RES}

begin
  if AnsiSameText(ParamStr(1), 'GUI') then
  begin
    Vcl.forms.Application.Initialize;
    Vcl.forms.Application.CreateForm(TfrmServidor, frmServidor);
  Vcl.forms.Application.Run;
  end
  else
  begin
    if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
      Vcl.SvcMgr.Application.Initialize;
    Vcl.SvcMgr.Application.CreateForm(TMJDService, MJDService);
    Vcl.SvcMgr.Application.Run;
  end;
end.
