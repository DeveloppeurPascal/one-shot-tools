program GamepadUITestsVCL;

uses
  Vcl.Forms,
  fMainVCL in 'fMainVCL.pas' {Form2},
  uJoystickManager in '..\uJoystickManager.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.VCL.Joystick in 'Gamolf.VCL.Joystick.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
