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
  File last update : 2025-07-14T09:18:14.295+02:00
  Signature : 179e70a7f05f73816d45f16a6c79841c845f2c78
  ***************************************************************************
*)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    edt_nombre_participants: TLabeledEdit;
    edt_nombre_lots: TLabeledEdit;
    btn_tirage: TButton;
    mmo_gagnants: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_tirageClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
end;

procedure TForm1.btn_tirageClick(Sender: TObject);
var
   i : integer;
   rang : integer;
   nb_lots, nb_participants: integer;
   lst_gagnants : string;
begin
  lst_gagnants := '';
  nb_lots := StrToInt (edt_nombre_lots.Text);
  nb_participants := StrToInt (edt_nombre_participants.Text);
  if (nb_lots > nb_participants) then
    nb_lots := nb_participants;
  {endif}
  mmo_gagnants.Lines.Clear;
  for i := 1 to nb_lots do begin
    repeat
      rang := succ (random (nb_participants*5) mod nb_participants);
    until (pos ('/'+IntToStr(rang)+'/', lst_gagnants) = 0);
    lst_gagnants := lst_gagnants + '/'+IntToStr(rang)+'/';
    mmo_gagnants.Lines.Add('Gagnant du lot '+IntToStr (i)+' : '+IntToStr (rang));
  end;
end;

end.
