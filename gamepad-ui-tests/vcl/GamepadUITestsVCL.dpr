program GamepadUITestsVCL;

uses
  Vcl.Forms,
  fMainVCL in 'fMainVCL.pas' {Form2},
  Gamolf.RTL.Joystick.DirectInput.Win in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.VCL.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.VCL.Joystick.pas',
  Gamolf.RTL.Joystick.Deprecated in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Deprecated.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
