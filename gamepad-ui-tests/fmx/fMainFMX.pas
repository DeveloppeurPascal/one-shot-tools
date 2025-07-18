(* C2PP
  ***************************************************************************

  One Shot Tools

  Copyright 2022-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://oneshottools.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/one-shot-tools

  ***************************************************************************
  File last update : 2025-02-09T11:12:13.649+01:00
  Signature : d07b7e799a5efd81a6d928dbd1ac559af29b8ac1
  ***************************************************************************
*)

unit fMainFMX;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Memo.Types,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  Gamolf.RTL.Joystick,
  FMX.Objects,
  Gamolf.RTL.Joystick.Deprecated;

type
  TForm1 = class(TForm)
    GamepadManager1: TGamepadManager;
    Gamepad1: TGamepad;
    Memo1: TMemo;
    Timer1: TTimer;
    Rectangle1: TRectangle;
    GameLoop: TTimer;
    procedure Gamepad1Lost(const GamepadID: Integer);
    procedure GamepadManager1NewGamepadDetected(const GamepadID: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Gamepad1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure FormCreate(Sender: TObject);
    procedure GameLoopTimer(Sender: TObject);
    procedure Gamepad1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure GamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
  private
    { Déclarations privées }
    procedure AddLog(const Txt: string);
  public
    { Déclarations publiques }
    vx, vy: Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AddLog(const Txt: string);
begin
  tthread.queue(nil,
    procedure
    begin
      Memo1.lines.Insert(0, Txt);
      Memo1.GoToTextBegin;
    end);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  vx := 0;
  vy := 0;
end;

procedure TForm1.GameLoopTimer(Sender: TObject);
begin
  Rectangle1.Position.x := Rectangle1.Position.x + vx;
  Rectangle1.Position.y := Rectangle1.Position.y + vy;
end;

procedure TForm1.Gamepad1ButtonDown(const GamepadID: Integer;
const Button: TJoystickButtons);
begin
  AddLog('Button down : ' + ord(Button).tostring);
end;

procedure TForm1.Gamepad1DirectionPadChange(const GamepadID: Integer;
const Value: TJoystickDPad);
begin
  case Value of
    TJoystickDPad.Top:
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
    TJoystickDPad.Left:
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

procedure TForm1.Gamepad1Lost(const GamepadID: Integer);
begin
  AddLog('lost ' + Gamepad1.id.tostring);
  Gamepad1.id := -1;
end;

procedure TForm1.GamepadManager1ButtonDown(const GamepadID: Integer;
const Button: TJoystickButtons);
begin
  if Button = TJoystickButtons.B then
    tthread.queue(nil,
      procedure
      begin
        close;
      end);
end;

procedure TForm1.GamepadManager1NewGamepadDetected(const GamepadID: Integer);
begin
  if ((not Gamepad1.IsConnected) or (Gamepad1.id < 0)) then
  begin
    Gamepad1.id := GamepadID;
    AddLog('new gamepad ' + GamepadID.tostring);
  end
  else
    AddLog('found gamepad ' + GamepadID.tostring);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (Timer1.tag <> TGamepadDevicesManager.current.GamepadCount) or
    (Timer1.TagFloat <> TGamepadDevicesManager.current.ConnectedGamepadCount)
  then
  begin
    Timer1.tag := TGamepadDevicesManager.current.GamepadCount;
    Timer1.TagFloat := TGamepadDevicesManager.current.ConnectedGamepadCount;
    AddLog('Gamepads : ' + Timer1.TagFloat.tostring + '/' +
      Timer1.tag.tostring);
  end;
  if (Timer1.tagstring <> Gamepad1.id.tostring) then
  begin
    Timer1.tagstring := Gamepad1.id.tostring;
    AddLog('GamepadID : ' + Timer1.tagstring);
  end;
end;

end.
