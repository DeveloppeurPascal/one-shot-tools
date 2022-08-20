unit uGenPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: integer;
  c: char;
  s: string;
  choix: integer;
begin
  Memo1.Lines.Clear;
  for i := 1 to SpinEdit1.Value do
  begin
    s := '';
    for j := 1 to 10 do
    begin
      choix := Random(26 + 26 + 10);
      case choix of
        0 .. 25:
          c := chr(ord('a') + choix);
        26 .. 51:
          c := chr(ord('A') + choix - 26);
        52 .. 61:
          c := chr(ord('0') + choix - 52);
      end;
      s := s+c;
    end;
    Memo1.Lines.Add(s);
  end;
end;

end.
