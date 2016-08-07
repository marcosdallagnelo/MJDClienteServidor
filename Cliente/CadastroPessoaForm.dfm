object frmCadastroPessoaForm: TfrmCadastroPessoaForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Incluir / Alterar Pessoa'
  ClientHeight = 294
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblId: TLabel
    Left = 19
    Top = 19
    Width = 12
    Height = 13
    Caption = 'Id'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNome: TLabel
    Left = 19
    Top = 67
    Width = 32
    Height = 13
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblProfissao: TLabel
    Left = 19
    Top = 123
    Width = 52
    Height = 13
    Caption = 'Profiss'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNaturalidade: TLabel
    Left = 19
    Top = 178
    Width = 72
    Height = 13
    Caption = 'Naturalidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtId: TEdit
    Left = 19
    Top = 38
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 0
  end
  object edtNome: TEdit
    Left = 19
    Top = 86
    Width = 375
    Height = 21
    BiDiMode = bdLeftToRight
    MaxLength = 50
    ParentBiDiMode = False
    TabOrder = 1
  end
  object edtProfissao: TEdit
    Left = 19
    Top = 142
    Width = 247
    Height = 21
    BiDiMode = bdLeftToRight
    MaxLength = 30
    ParentBiDiMode = False
    TabOrder = 2
  end
  object edtNaturalidade: TEdit
    Left = 19
    Top = 197
    Width = 247
    Height = 21
    BiDiMode = bdLeftToRight
    MaxLength = 30
    ParentBiDiMode = False
    TabOrder = 3
  end
  object btnGravar: TButton
    Left = 117
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 4
    OnClick = btnGravarClick
  end
  object btnSair: TButton
    Left = 221
    Top = 249
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Sair'
    TabOrder = 5
    OnClick = btnSairClick
  end
end
