unit ServidorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uServidorThread,
  Data.DBXFirebird, Data.DB, Data.SqlExpr;

type
  TfrmServidor = class(TForm)
    btnIniciar: TButton;
    btnParar: TButton;
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
  private
    Servidor: TServidorThread;
  public
    { Public declarations }
  end;

var
  frmServidor: TfrmServidor;

implementation

{$R *.dfm}

procedure TfrmServidor.btnIniciarClick(Sender: TObject);
begin
  Servidor := TServidorThread.Create(True);
  Servidor.FreeOnTerminate := True;
  Servidor.Start();
end;

procedure TfrmServidor.btnPararClick(Sender: TObject);
begin
  Servidor.Terminate();
end;

end.
