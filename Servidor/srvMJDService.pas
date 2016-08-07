unit srvMJDService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, uServidorThread;

type
  TMJDService = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    Servidor: TServidorThread;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  MJDService: TMJDService;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MJDService.Controller(CtrlCode);
end;

function TMJDService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMJDService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Servidor := TServidorThread.Create(True);
  Servidor.FreeOnTerminate := True;
  Servidor.Start();
end;

procedure TMJDService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Servidor.Terminate();
end;

end.
