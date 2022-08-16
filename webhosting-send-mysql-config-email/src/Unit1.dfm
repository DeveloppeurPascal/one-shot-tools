object Form1: TForm1
  Left = 211
  Top = 106
  Width = 870
  Height = 640
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
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 849
    Height = 393
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 24
    Top = 544
    Width = 825
    Height = 57
    Lines.Strings = (
      
        'Placer la liste des comptes dont on veut informer les utilisateu' +
        'rs: 6 colonnes par ligne'
      ''
      
        'Utilisateur'#9'Mot de passe'#9'Base de donn'#233'es MySQL'#9'Serveur'#9'Email'#9'Sit' +
        'e web'#9)
    TabOrder = 3
  end
  object Button1: TButton
    Left = 144
    Top = 408
    Width = 161
    Height = 25
    Caption = 'envoyer les messages'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 408
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'smtp.free.fr'
  end
  object IdSMTP1: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    Left = 320
    Top = 432
  end
end
