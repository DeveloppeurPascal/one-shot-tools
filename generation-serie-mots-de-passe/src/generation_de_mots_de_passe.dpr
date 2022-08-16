program generation_de_mots_de_passe;

uses
  System.StartUpCopy,
  FMX.Forms,
  frm_generation in 'frm_generation.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
