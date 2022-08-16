object Form1: TForm1
  Left = 202
  Top = 107
  Width = 585
  Height = 410
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ShellTreeView1: TShellTreeView
    Left = 0
    Top = 0
    Width = 577
    Height = 337
    ObjectTypes = [otFolders]
    Root = 'rfDesktop'
    UseShellImages = True
    Align = alTop
    AutoRefresh = False
    Indent = 19
    ParentColor = False
    RightClickSelect = True
    ShowRoot = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 216
    Top = 352
    Width = 273
    Height = 25
    Caption = 'Cr'#233'er la base SQL '#224' partir des CSV de ce dossier'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 496
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Quitter'
    TabOrder = 2
    OnClick = Button2Click
  end
end
