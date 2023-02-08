unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.IOUtils, System.types;

procedure TForm1.FormCreate(Sender: TObject);
var
  l: TStringDynArray;
  i: integer;
  Folder: string;
begin
  Folder := 'C:\Users\patrickpremartin\Documents\img';
  l := tdirectory.GetFiles(Folder);
  for i := 0 to length(l) - 1 do
    if TPath.GetFileName(l[i]).StartsWith('DALL') then
      tfile.Move(l[i], TPath.Combine(Folder, 'dall-e_' + i.tostring +
        TPath.GetExtension(l[i])));
end;

end.
