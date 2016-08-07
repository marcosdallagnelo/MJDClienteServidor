object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Teste1 - Cliente - Cadastro de Pessoa'
  ClientHeight = 520
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 816
    Height = 51
    Align = alTop
    TabOrder = 0
    object btnIncluir: TButton
      Left = 16
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnAlterar: TButton
      Left = 104
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 192
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnListar: TButton
      Left = 280
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Listar'
      TabOrder = 3
      OnClick = btnListarClick
    end
  end
  object dbgrdPessoa: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 816
    Height = 457
    Align = alClient
    DataSource = dsPessoa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsPessoa: TDataSource
    DataSet = cdsPessoa
    Left = 368
    Top = 208
  end
  object cdsPessoa: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 152
    Data = {
      7D0000009619E0BD0100000018000000040000000000030000007D0002696404
      00010000000000046E6F6D650100490000000100055749445448020002003200
      0970726F66697373616F0100490000000100055749445448020002001E000C6E
      61747572616C69646164650100490000000100055749445448020002001E0000
      00}
    object cdsPessoaid: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'id'
    end
    object cdsPessoanome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 50
    end
    object cdsPessoaprofissao: TStringField
      DisplayLabel = 'Profiss'#227'o'
      FieldName = 'profissao'
      Size = 30
    end
    object cdsPessoanaturalidade: TStringField
      DisplayLabel = 'Naturalidade'
      FieldName = 'naturalidade'
      Size = 30
    end
  end
end
