object frmServidor: TfrmServidor
  Left = 0
  Top = 0
  Caption = 'Teste da Thread do Servidor'
  ClientHeight = 99
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnIniciar: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = btnIniciarClick
  end
  object btnParar: TButton
    Left = 136
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = btnPararClick
  end
end
