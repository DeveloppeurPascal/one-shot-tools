object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 562
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 179
    Height = 13
    Caption = 'Nombre de mots de passes '#224' g'#233'n'#233'rer'
  end
  object Memo1: TMemo
    Left = 7
    Top = 49
    Width = 577
    Height = 505
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 320
    Top = 8
    Width = 75
    Height = 25
    Caption = 'G'#233'n'#233'rer'
    TabOrder = 1
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 193
    Top = 8
    Width = 121
    Height = 22
    MaxValue = 5000
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
end
