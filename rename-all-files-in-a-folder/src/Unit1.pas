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
  File last update : 2025-07-14T09:18:14.290+02:00
  Signature : be13e8be19ad7ee558ee5f1f9960fff7712f2441
  ***************************************************************************
*)

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
