unit uJSONPessoa;

interface

uses Data.DBXJSONReflect, System.Generics.Collections, Data.DBXJSONCommon,
Data.DBXJSON, uPessoa;

type
  TJSONPessoa = class
  public
    function JsonToObject(value: string): TPessoa;
    function JsonToObjectList(value: string): TPessoaList;
    function ObjectToJson(value: TPessoa): string; overload;
    function ObjectToJson(value: TPessoaList): string; overload;
  end;

var
  PessoaListConverter: TObjectsConverter;
  PessoaListReverter: TObjectsReverter;

implementation

function TJSONPessoa.JsonToObject(value: string): TPessoa;
var Json: TJSONObject;
    UnMar: TJSONUnMarshal;
begin
  Json := TJSONObject.ParseJSONValue(value) as TJSONObject;

  UnMar := TJSONUnMarshal.Create;
  try
    Result := UnMar.UnMarshal(Json) as TPessoa;
  finally
    UnMar.Free;
  end;
end;

function TJSONPessoa.ObjectToJson(value: TPessoa): string;
var Mar: TJSONMarshal;
begin
  Mar := TJSONMarshal.Create(TJSONConverter.Create);
  try
    Result := (Mar.Marshal(value) as TJSONObject).ToString();
  finally
    Mar.Free;
  end;
end;

function TJSONPessoa.JsonToObjectList(value: string): TPessoaList;
var Json: TJSONObject;
    UnMar: TJSONUnMarshal;
begin
  Json := TJSONObject.ParseJSONValue(value) as TJSONObject;

  UnMar := TJSONUnMarshal.Create;
  UnMar.RegisterReverter(TPessoaList, 'Pessoas', PessoaListReverter);

  try
    Result := UnMar.UnMarshal(Json) as TPessoaList;
  finally
    UnMar.Free;
  end;
end;

function TJSONPessoa.ObjectToJson(value: TPessoaList): string;
var Mar: TJSONMarshal;
begin
  Mar := TJSONMarshal.Create(TJSONConverter.Create);
  Mar.RegisterConverter(TPessoaList, 'Pessoas', PessoaListConverter);

  try
    Result := (Mar.Marshal(value) as TJSONObject).ToString();
  finally
    Mar.Free;
  end;
end;

initialization

PessoaListConverter := function(Data: TObject; Field: String): TListOfObjects
var
  Pessoas: TPessoas;
  i: integer;
begin
  Pessoas := TPessoaList(Data).Pessoas;
  SetLength(Result, Pessoas.Count);
  if Pessoas.Count > 0 then
    for I := 0 to Pessoas.Count - 1 do
      Result[I] := Pessoas[i];
end;


PessoaListReverter := procedure(Data: TObject; Field: String; Args: TListOfObjects)
var
  obj: TObject;
  Pessoas: TPessoas;
  Pessoa: TPessoa;
begin
  Pessoas := TPessoaList(Data).Pessoas;
  Pessoas.Clear;
  for obj in Args do
  begin
    Pessoa := obj as TPessoa;
    Pessoas.Add(Pessoa);
  end;
end;

end.
