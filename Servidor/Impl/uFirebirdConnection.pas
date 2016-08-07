unit uFirebirdConnection;

interface

uses uIConnection, Data.DB, Data.SqlExpr, System.SysUtils, Data.DBXFirebird;

type
  TFirebirdConnection = class(TInterfacedObject, IConnection)
  private
    FConnection: TSQLConnection;
    function GetConnection: TSQLConnection;
  public
    constructor Create(EndDB: string);
    destructor Destroy; override;

    function GetQuery: TSQLQuery;
    property Connection: TSQLConnection read GetConnection;
  end;

implementation

{ TOIFirebirdConnection }

uses uMJD.Messages;

constructor TFirebirdConnection.Create(EndDB: string);
begin
  FConnection := TSQLConnection.Create(nil);
  FConnection.Close;
  FConnection.ConnectionName := '';
  FConnection.DriverName := 'Firebird';
  FConnection.GetDriverFunc := 'getSQLDriverINTERBASE';
  FConnection.LibraryName := 'dbxfb.dll';
  FConnection.LoadParamsOnConnect := False;
  FConnection.LoginPrompt := false;
  FConnection.VendorLib := 'fbclient.dll';

  FConnection.Params.Clear;
  FConnection.Params.Add('DriverName=Firebird');
  FConnection.Params.Add(Format('Database=%s', [EndDB]));
  FConnection.Params.Add('RoleName=RoleName');
  FConnection.Params.Add('User_Name=sysdba');
  FConnection.Params.Add('Password=masterkey');
  FConnection.Params.Add('ServerCharSet=win1252');
  FConnection.Params.Add('SQLDialect=3');
  FConnection.Params.Add('ErrorResourceFile=');
  FConnection.Params.Add('LocaleCode=0000');
  FConnection.Params.Add('BlobSize=-1');
  FConnection.Params.Add('CommitRetain=False');
  FConnection.Params.Add('WaitOnLocks=True');
  FConnection.Params.Add('IsolationLevel=ReadCommitted');
  FConnection.Params.Add('Trim Char=False');

  try
    try
      FConnection.Open;
    except
      on e: exception do
        raise EConnectionError.CreateFmt(rsErroConexaoBD, [e.Message]);
    end;
  finally
    FConnection.Close;
  end;
end;

destructor TFirebirdConnection.Destroy;
begin
  FConnection.Close();
  FConnection.Free();

  inherited;
end;

function TFirebirdConnection.GetConnection: TSQLConnection;
begin
  Result := FConnection;
end;

function TFirebirdConnection.GetQuery: TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  Result.SQLConnection := Connection;
end;

end.
