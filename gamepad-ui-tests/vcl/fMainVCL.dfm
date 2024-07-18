object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 0
    Top = 296
    Width = 624
    Height = 145
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 208
    Top = 96
    Width = 50
    Height = 50
    Caption = 'Panel1'
    TabOrder = 1
  end
  object GamepadManager1: TGamepadManager
    OnNewGamepadDetected = GamepadManager1NewGamepadDetected
    OnButtonDown = GamepadManager1ButtonDown
    Left = 320
    Top = 80
  end
  object Gamepad1: TGamepad
    OnButtonDown = Gamepad1ButtonDown
    OnDirectionPadChange = Gamepad1DirectionPadChange
    OnLost = Gamepad1Lost
    Left = 400
    Top = 128
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 488
    Top = 120
  end
  object GameLoop: TTimer
    Interval = 16
    OnTimer = GameLoopTimer
    Left = 488
    Top = 192
  end
end
