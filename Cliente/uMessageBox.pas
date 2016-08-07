unit uMessageBox;

interface

uses Forms, Windows, SysUtils;

type
  MessageBox = class
  public
    class procedure MessageOk(const Msg: string); overload; virtual;
    class procedure MessageOk(const Msg: string; const Caption: string); overload; virtual;
    class procedure MessageOkFmt(const Msg: string; const Args: array of const); overload; virtual;
    class procedure MessageOkFmt(const Msg: string; const Args: array of const; const Caption: string); overload; virtual;
    class procedure MessageError(const Msg: string); overload; virtual;
    class procedure MessageError(const Msg: string; const Caption: string); overload; virtual;
    class procedure MessageErrorFmt(const Msg: string; const Args: array of const); overload; virtual;
    class procedure MessageErrorFmt(const Msg: string; const Args: array of const; const Caption: string); overload; virtual;
    class function MessageYesNo(const Msg: string): Boolean; overload; virtual;
    class function MessageYesNo(const Msg: string; const Caption: string): Boolean; overload; virtual;
    class function MessageYesNoFmt(const Msg: string; const Args: array of const): Boolean; overload; virtual;
    class function MessageYesNoFmt(const Msg: string; const Caption: string; const Args: array of const): Boolean; overload; virtual;
  end;

implementation

const
  INFORMATION = 'Informação';
  ERROR = 'Error';

{ MessageBox }

class procedure MessageBox.MessageError(const Msg, Caption: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Caption), MB_OK + MB_ICONERROR);
end;

class procedure MessageBox.MessageError(const Msg: string);
begin
  MessageError(Msg, ERROR);
end;

class procedure MessageBox.MessageErrorFmt(const Msg: string;
  const Args: array of const; const Caption: string);
begin
  MessageError(Format(Msg, Args), Caption);
end;

class procedure MessageBox.MessageErrorFmt(const Msg: string;
  const Args: array of const);
begin
  MessageError(Format(Msg, Args));
end;

class procedure MessageBox.MessageOk(const Msg, Caption: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Caption), MB_OK + MB_ICONINFORMATION);
end;

class procedure MessageBox.MessageOk(const Msg: string);
begin
  MessageOk(Msg, INFORMATION);
end;

class procedure MessageBox.MessageOkFmt(const Msg: string;
  const Args: array of const; const Caption: string);
begin
  MessageOk(Format(Msg, Args), Caption);
end;

class procedure MessageBox.MessageOkFmt(const Msg: string;
  const Args: array of const);
begin
  MessageOk(Format(Msg, Args));
end;

class function MessageBox.MessageYesNo(const Msg, Caption: string): Boolean;
begin
  Result := (Application.MessageBox(PChar(Msg), PChar(Caption), MB_YESNO + MB_ICONQUESTION) = ID_YES);
end;

class function MessageBox.MessageYesNo(const Msg: string): Boolean;
begin
  Result := MessageYesNo(Msg, INFORMATION);
end;

class function MessageBox.MessageYesNoFmt(const Msg, Caption: string;
  const Args: array of const): Boolean;
begin
  Result := MessageYesNo(Format(Msg, Args), Caption);
end;

class function MessageBox.MessageYesNoFmt(const Msg: string;
  const Args: array of const): Boolean;
begin
  Result := MessageYesNo(Format(Msg, Args));
end;

end.
