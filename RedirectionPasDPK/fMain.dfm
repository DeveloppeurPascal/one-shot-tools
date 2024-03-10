object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Redirect Pas&DPK Files After A Folder Tree Change'
  ClientHeight = 120
  ClientWidth = 819
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 809
    Height = 15
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Label1'
    ExplicitWidth = 34
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 30
    Width = 809
    Height = 15
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Label2'
    ExplicitWidth = 34
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 55
    Width = 809
    Height = 15
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Label2'
    ExplicitWidth = 34
  end
  object btnEraseFromFolderFiles: TButton
    AlignWithMargins = True
    Left = 5
    Top = 80
    Width = 809
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Erase "From Folder" files'
    TabOrder = 0
    OnClick = btnEraseFromFolderFilesClick
  end
end
