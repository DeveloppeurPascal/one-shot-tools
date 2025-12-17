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
  Signature : 4291b75dcb98576a4d47067fc6dfd7299bf40cce
  ***************************************************************************
*)

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
    for j := 1 to 12 + random(7) do
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
      s := s + c;
    end;
    Memo1.Lines.Add(s);
  end;
end;

end.
