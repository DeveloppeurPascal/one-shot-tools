(* C2PP
  ***************************************************************************

  One Shot Tools

  Copyright 2022-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://oneshottools.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/one-shot-tools

  ***************************************************************************
  File last update : 2025-02-09T11:12:13.669+01:00
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
