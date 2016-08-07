unit uPessoaRepository;

interface

uses uBaseRepository, uPessoa, System.Generics.Collections, System.SysUtils,
  System.Classes, System.Generics.Defaults;

type
  TPessoaRepository = class(TBaseRepository<TPessoa>)
  public
    procedure Incluir(model: TPessoa); override;
    procedure Alterar(model: TPessoa); override;
    procedure Excluir(model: TPessoa); override;
    function Listar: TPessoas; override;
  end;

const
  SQL_INCLUIR_PESSOA = 'INSERT INTO pessoa(nome, profissao, naturalidade)VALUES(%s, %s, %s)';
  SQL_ALTERAR_PESSOA = 'UPDATE pessoa SET nome = %s, profissao = %s, naturalidade = %s WHERE id = %d';
  SQL_EXCLUIR_PESSOA = 'DELETE FROM pessoa WHERE id = %d';
  SQL_LISTAR_PESSOA = 'SELECT id, nome, profissao, naturalidade FROM pessoa';

implementation

{ TPessoaRepository }

procedure TPessoaRepository.Alterar(model: TPessoa);
begin
  DoExecSQL(Format(SQL_ALTERAR_PESSOA, [QuotedStr(model.Nome),
    QuotedStr(model.Profissao), QuotedStr(model.Naturalidade),
    model.Id]));
end;

procedure TPessoaRepository.Excluir(model: TPessoa);
begin
  DoExecSQL(Format(SQL_EXCLUIR_PESSOA, [model.Id]));
end;

procedure TPessoaRepository.Incluir(model: TPessoa);
begin
  DoExecSQL(Format(SQL_INCLUIR_PESSOA, [QuotedStr(model.Nome),
    QuotedStr(model.Profissao), QuotedStr(model.Naturalidade)]));
end;

function TPessoaRepository.Listar: TPessoas;
var Pessoa: TPessoa;
begin
  Result := TPessoas.Create;

  with Connection.GetQuery() do
  begin
    try
      SQL.Text := SQL_LISTAR_PESSOA;

      try
        Open;
      except
        raise
      end;

      while not Eof do
      begin
        Pessoa := TPessoa.Create();
        Pessoa.Id := FieldByName('id').AsInteger;
        Pessoa.Nome := FieldByName('nome').AsString;
        Pessoa.Profissao := FieldByName('profissao').AsString;
        Pessoa.Naturalidade := FieldByName('naturalidade').AsString;
        Result.Add(Pessoa);

        Next;
      end;
    finally
      Close;
      Free;
    end;
  end;
end;

end.
