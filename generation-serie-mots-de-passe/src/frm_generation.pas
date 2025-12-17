(* C2PP
  ***************************************************************************

  One Shot Tools
  Copyright (c) 2022-2025 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://oneshottools.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/one-shot-tools

  ***************************************************************************
  File last update : 2025-07-14T09:18:14.262+02:00
  Signature : 86d7a14a2dcedc6e98af2d3cd45d6c333fa17797
  ***************************************************************************
*)

unit frm_generation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
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
  i: integer;
  c: char;
  choix: integer;
begin
  result := '';
  for i := 1 to 12 + random(7) do
  begin
    choix := random(26 + 26 + 10);
    case choix of
      0 .. 25:
        c := chr(ord('a') + choix);
      26 .. 51:
        c := chr(ord('A') + choix - 26);
      52 .. 61:
        c := chr(ord('0') + choix - 52);
    end;
    result := result + c;
  end;
end;

function no_space(ch: string): string;
var
  n: integer;
begin
  repeat
    n := pos(' ', ch);
    if (n > 0) then
      delete(ch, n, 1);
    { endif }
  until (n = 0);
  result := ch;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  i: integer;
  n: integer;
  ch1, ch2, ch: string;
begin
  for i := 0 to Memo1.Lines.Count - 1 do
  begin
    ch := Memo1.Lines[i];
    n := pos(#9, ch);
    if (n > 0) then
    begin
      ch1 := no_space(trim(LowerCase(copy(ch, 1, pred(n)))));
      ch2 := copy(ch, succ(n), length(ch));
      if (ch2 = '') then
        ch2 := serie_aleatoire;
      { endif }
    end
    else
    begin
      ch1 := no_space(trim(LowerCase(ch)));
      ch2 := serie_aleatoire;
    end;
    Memo1.Lines[i] := ch1 + #9 + ch2;
  end;
  Memo1.SelectAll;
  Memo1.CopyToClipboard;
  showmessage('liste copiée dans le presse papier');
end;

initialization

randomize;

end.
