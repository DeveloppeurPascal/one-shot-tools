unit fMainVCL;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Gamolf.RTL.Joystick,
  Gamolf.RTL.Joystick.Deprecated;

type
  TForm2 = class(TForm)
    GamepadManager1: TGamepadManager;
    Gamepad1: TGamepad;
    Memo1: TMemo;
    Panel1: TPanel;
    Timer1: TTimer;
    GameLoop: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Gamepad1Lost(const GamepadID: Integer);
    procedure GamepadManager1NewGamepadDetected(const GamepadID: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Gamepad1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure GameLoopTimer(Sender: TObject);
    procedure Gamepad1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure GamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
  private
    { Déclarations privées }
    Timer1TagFloat: Single;
    Timer1TagString: string;
    procedure AddLog(const Txt: string);
  public
    { Déclarations publiques }
    vx, vy: Integer;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.AddLog(const Txt: string);
begin
  tthread.queue(nil,
    procedure
    begin
      Memo1.lines.Insert(0, Txt);
    end);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  vx := 0;
  vy := 0;
end;

procedure TForm2.GameLoopTimer(Sender: TObject);
begin
  Panel1.left := Panel1.left + vx;
  Panel1.top := Panel1.top + vy;
end;

procedure TForm2.Gamepad1ButtonDown(const GamepadID: Integer;
const Button: TJoystickButtons);
begin
  AddLog('Button down : ' + ord(Button).tostring);
end;

procedure TForm2.Gamepad1DirectionPadChange(const GamepadID: Integer;
const Value: TJoystickDPad);
begin
  case Value of
    TJoystickDPad.top:
      begin
        vx := 0;
        vy := -1;
      end;
    TJoystickDPad.TopRight:
      begin
        vx := 1;
        vy := -1;
      end;
    TJoystickDPad.Right:
      begin
        vx := 1;
        vy := 0;
      end;
    TJoystickDPad.RightBottom:
      begin
        vx := 1;
        vy := 1;
      end;
    TJoystickDPad.Bottom:
      begin
        vx := 0;
        vy := 1;
      end;
    TJoystickDPad.BottomLeft:
      begin
        vx := -1;
        vy := 1;
      end;
    TJoystickDPad.left:
      begin
        vx := -1;
        vy := 0;
      end;
    TJoystickDPad.LeftTop:
      begin
        vx := -1;
        vy := -1;
      end;
    TJoystickDPad.Center:
      begin
        vx := 0;
        vy := 0;
      end;
  end;
end;

procedure TForm2.Gamepad1Lost(const GamepadID: Integer);
begin
  AddLog('lost ' + Gamepad1.id.tostring);
  Gamepad1.id := -1;
end;

procedure TForm2.GamepadManager1ButtonDown(const GamepadID: Integer;
const Button: TJoystickButtons);
begin
  if Button = TJoystickButtons.B then
    tthread.queue(nil,
      procedure
      begin
        close;
      end);
end;

procedure TForm2.GamepadManager1NewGamepadDetected(const GamepadID: Integer);
begin
  if ((not Gamepad1.IsConnected) or (Gamepad1.id < 0)) then
  begin
    Gamepad1.id := GamepadID;
    AddLog('new gamepad ' + GamepadID.tostring);
  end
  else
    AddLog('found gamepad ' + GamepadID.tostring);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if (Timer1.tag <> TGamepadDevicesManager.current.GamepadCount) or
    (Timer1TagFloat <> TGamepadDevicesManager.current.ConnectedGamepadCount)
  then
  begin
    Timer1.tag := TGamepadDevicesManager.current.GamepadCount;
    Timer1TagFloat := TGamepadDevicesManager.current.ConnectedGamepadCount;
    AddLog('Gamepads : ' + Timer1TagFloat.tostring + '/' + Timer1.tag.tostring);
  end;
  if (Timer1TagString <> Gamepad1.id.tostring) then
  begin
    Timer1TagString := Gamepad1.id.tostring;
    AddLog('GamepadID : ' + Timer1TagString);
  end;
end;

end.
