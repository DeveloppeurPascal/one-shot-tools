program DisplayDPROJContent;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {Form1},
  Olf.RTL.DPROJReader in '..\lib-externes\librairies\src\Olf.RTL.DPROJReader.pas',
  Olf.RTL.PathAliases in '..\lib-externes\librairies\src\Olf.RTL.PathAliases.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
