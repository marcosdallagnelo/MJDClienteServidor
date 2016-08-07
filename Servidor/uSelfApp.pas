unit uSelfApp;

interface

uses System.SysUtils, uIConnection, uFirebirdConnection;

type
  TSelfApp = class
  strict private
    class var Instance: TSelfApp;
  private
    FDirApp: string;
    FConnection: IConnection;
    class procedure ReleaseInstance();

    constructor Create;
    destructor Destroy; override;
  public
    class function GetInstance(): TSelfApp;

    property DirApp: string read FDirApp;
    property Connection: IConnection read FConnection;
  end;

var
  SelfApp: TSelfApp;

const
  NOME_BANCO_DADOS = 'DB.FDB';

implementation

{ TSelfApp }

constructor TSelfApp.Create;
begin
  FDirApp := ExtractFilePath(ParamStr(0));
  FConnection := TFirebirdConnection.Create(FDirApp + NOME_BANCO_DADOS);
end;

destructor TSelfApp.Destroy;
begin
  FConnection := nil;

  inherited;
end;

class function TSelfApp.GetInstance: TSelfApp;
begin
  if not Assigned(Self.Instance) then
    self.Instance := TSelfApp.Create;

  Result := Self.Instance;
end;

class procedure TSelfApp.ReleaseInstance;
begin
  if Assigned(Self.Instance) then
    Self.Instance.Free;
end;

initialization
  SelfApp := TSelfApp.GetInstance();
finalization
  TSelfApp.ReleaseInstance();

end.
