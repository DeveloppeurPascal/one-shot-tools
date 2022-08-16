object Form1: TForm1
  Left = 202
  Top = 107
  Width = 355
  Height = 387
  Caption = 'Tirage au sort de gagnants'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 113
    Height = 13
    Caption = 'Les rangs des gagnants'
  end
  object edt_nombre_participants: TLabeledEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Nb participants'
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 0
  end
  object edt_nombre_lots: TLabeledEdit
    Left = 136
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Nb lots'
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 1
  end
  object btn_tirage: TButton
    Left = 264
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Tirage au sort'
    TabOrder = 2
    OnClick = btn_tirageClick
  end
  object mmo_gagnants: TMemo
    Left = 8
    Top = 72
    Width = 329
    Height = 281
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
