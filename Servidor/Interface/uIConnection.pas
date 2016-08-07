unit uIConnection;

interface

uses System.SysUtils, Data.DB, Data.SqlExpr;

type
  EConnectionError = class(Exception);

  IConnection = interface['{25F58270-BAF0-41D9-A4FC-63D74F65C868}']
    function GetConnection: TSQLConnection;
    function GetQuery: TSQLQuery;
  end;

implementation

end.
