program ShowImagesFullscreen;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  fDisplayImages in 'fDisplayImages.pas' {frmDisplayImages},
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
