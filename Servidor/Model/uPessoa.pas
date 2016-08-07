unit uPessoa;

interface

uses System.Generics.Collections;

type
  TPessoa = class
  strict private
    FNaturalidade: String;
    FId: Integer;
    FNome: String;
    FProfissao: String;
    procedure SetId(const Value: Integer);
    procedure SetNaturalidade(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetProfissao(const Value: String);
  public
    property Id: Integer read FId write SetId;
    property Nome: String read FNome write SetNome;
    property Profissao: String read FProfissao write SetProfissao;
    property Naturalidade: String read FNaturalidade write SetNaturalidade;
  end;

  TPessoas = TObjectList<TPessoa>;

  TPessoaList = class
  public
    Pessoas: TPessoas;
    constructor Create();
    destructor Destroy; override;

    class function CreateInit(APessoas: TPessoas): TPessoaList;
  end;

implementation

{ TPessoa }

procedure TPessoa.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TPessoa.SetNaturalidade(const Value: String);
begin
  FNaturalidade := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPessoa.SetProfissao(const Value: String);
begin
  FProfissao := Value;
end;

{ TPessoList }

constructor TPessoaList.Create();
begin
  Pessoas := TPessoas.Create;
end;

class function TPessoaList.CreateInit(APessoas: TPessoas): TPessoaList;
begin
  Result := TPessoaList.Create();
  Result.Pessoas := APessoas;
end;

destructor TPessoaList.Destroy;
begin
  Pessoas.Free();
  inherited;
end;

end.
