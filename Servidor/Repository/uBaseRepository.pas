unit uBaseRepository;

interface

uses uIConnection, System.Generics.Collections, uIBaseRepository;

type
  TBaseRepository<T: class> = class(TInterfacedObject, IBaseRepository<T>)
  private
    FConnection: IConnection;
  protected
    procedure DoExecSQL(Comando: string);
  public
    constructor Create;
    procedure Incluir(model: T); virtual; abstract;
    procedure Alterar(model: T); virtual; abstract;
    procedure Excluir(model: T); virtual; abstract;
    function Listar: TObjectList<T>; virtual; abstract;
    property Connection: IConnection read FConnection;
  end;

implementation

{ TBaseRepository }

uses uSelfApp;

constructor TBaseRepository<T>.Create;
begin
  FConnection := SelfApp.Connection;
end;

procedure TBaseRepository<T>.DoExecSQL(Comando: string);
begin
  with Connection.GetQuery() do
  begin
    try
      SQL.Text := Comando;
      ExecSQL();
    finally
      Close;
      Free();
    end;
  end;
end;

end.
