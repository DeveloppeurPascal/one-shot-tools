unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Outline, DirOutln, StdCtrls, ComCtrls, ShellCtrls;

type
  TForm1 = class(TForm)
    ShellTreeView1: TShellTreeView;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (traiter_dossier (ShellTreeView1.Path)) then
    ShowMessage ('Base correctement cr��e')
  else
    ShowMessage ('Base non cr��e');
  {endif}
end;

end.
