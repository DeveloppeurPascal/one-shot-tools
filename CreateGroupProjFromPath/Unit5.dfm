object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object edtRootPath: TEdit
    Left = 80
    Top = 16
    Width = 465
    Height = 23
    TabOrder = 0
    Text = 'edtRootPath'
    TextHint = 'Path where storing the GroupProj file'
  end
  object edtGroupProjName: TEdit
    Left = 80
    Top = 83
    Width = 465
    Height = 23
    TabOrder = 2
    Text = 'edtGroupProjName'
  end
  object Memo1: TMemo
    Left = 0
    Top = 168
    Width = 624
    Height = 273
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
    WordWrap = False
  end
  object Button1: TButton
    Left = 80
    Top = 45
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 80
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
end
