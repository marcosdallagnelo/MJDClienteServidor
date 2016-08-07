unit uConfig;

interface

uses System.SysUtils, System.IniFiles;

type
  TConfigIni = class
  private
    Arquivo: string;
    procedure CriaArquivoPadrao;
    function GetChave(Chave: string): string;
    function GetHost: string;
    function GetPorta: string;
  public
    constructor Create;

    property Host: string read GetHost;
    property Porta: string read GetPorta;
  end;

var
  Config: TConfigIni;

const
  CONFIG_INI_ARQUIVO = 'Config.ini';
  CONFIG_INI_SECAO_GERAL = 'Geral';
  CONFIG_INI_HOST_NAME = 'Host';
  CONFIG_INI_HOST_DEFAULT = 'localhost';
  CONFIG_INI_PORTA_NAME = 'Porta';
  CONFIG_INI_PORTA_DEFAULT = '25000';

implementation

{ TConfigIni }

constructor TConfigIni.Create;
begin
  Arquivo := Format('%s\%s', [ExtractFilePath(ParamStr(0)), CONFIG_INI_ARQUIVO]);
  CriaArquivoPadrao;
end;

procedure TConfigIni.CriaArquivoPadrao;
begin
  if not FileExists(Arquivo) then
  with TIniFile.Create(Arquivo) do
  begin
    try
      WriteString(CONFIG_INI_SECAO_GERAL, CONFIG_INI_HOST_NAME, CONFIG_INI_HOST_DEFAULT);
      WriteString(CONFIG_INI_SECAO_GERAL, CONFIG_INI_PORTA_NAME, CONFIG_INI_PORTA_DEFAULT);
    finally
      Free;
    end;
  end;
end;

function TConfigIni.GetChave(Chave: string): string;
begin
  with TIniFile.Create(Arquivo) do
  begin
    try
      Result := ReadString(CONFIG_INI_SECAO_GERAL, Chave, '');
    finally
      Free;
    end;
  end;
end;

function TConfigIni.GetHost: string;
begin
  Result := GetChave(CONFIG_INI_HOST_NAME);

  if (Result = '') then
    Result := CONFIG_INI_HOST_DEFAULT;
end;

function TConfigIni.GetPorta: string;
begin
  Result := GetChave(CONFIG_INI_PORTA_NAME);

  if (Result = '') then
    Result := CONFIG_INI_PORTA_DEFAULT;
end;

initialization
  Config := TConfigIni.Create();
finalization
  Config.Free();

end.
