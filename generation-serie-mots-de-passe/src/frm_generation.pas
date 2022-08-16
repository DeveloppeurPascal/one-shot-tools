unit frm_generation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Memo.Types;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

function serie_aleatoire: string;
var
  ch : string;
  i : integer;
  n : integer;
begin
  ch := '';
  for i := 1 to 8 do begin
    n := random (26+10);
    if (n < 26) then
      ch := ch + chr (ord ('a')+n)
    else
      ch := ch + chr (ord ('0')+n-26);
    {endif}
  end;
  Result := ch;
end;

function no_space (ch : string) : string;
var
  n : integer;
begin
  repeat
    n := pos (' ', ch);
    if (n > 0) then
      delete (ch, n, 1);
    {endif}
  until (n = 0);
  Result := ch;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  i : integer;
  n : integer;
  ch1, ch2, ch : string;
begin
  for i := 0 to Memo1.Lines.Count-1 do begin
    ch := memo1.lines[i];
    n := pos (#9, ch);
    if (n > 0) then begin
      ch1 := no_space (trim (LowerCase (copy (ch, 1, pred (n)))));
      ch2 := copy (ch, succ (n), length (ch));
      if (ch2 = '') then
        ch2 := serie_aleatoire;
      {endif}
    end else begin
      ch1 := no_space (trim (LowerCase (ch)));
      ch2 := serie_aleatoire;
    end;
    memo1.lines[i] := ch1+#9+ch2;
  end;
  memo1.SelectAll;
  memo1.CopyToClipboard;
  showmessage ('liste copiée dans le presse papier');
end;

initialization
  randomize;
end.
