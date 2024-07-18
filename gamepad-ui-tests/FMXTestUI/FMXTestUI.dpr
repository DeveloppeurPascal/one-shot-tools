program FMXTestUI;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMainFMXTestUI in 'fMainFMXTestUI.pas' {Form3},
  uJoystickManager in '..\uJoystickManager.pas',
  Gamolf.FMX.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.Joystick.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick.Mac in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Mac.pas',
  Gamolf.RTL.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  iOSapi.GameController in '..\..\lib-externes\Delphi-Game-Engine\src\iOSapi.GameController.pas',
  Macapi.GameController in '..\..\lib-externes\Delphi-Game-Engine\src\Macapi.GameController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
