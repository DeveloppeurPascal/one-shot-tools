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
