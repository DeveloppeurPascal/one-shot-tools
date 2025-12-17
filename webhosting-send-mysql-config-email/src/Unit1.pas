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
  File last update : 2025-07-14T09:18:14.311+02:00
  Signature : b0a6a1e3116ff35071350b2a76805b4384ea6fc0
  ***************************************************************************
*)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    IdSMTP1: TIdSMTP;
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
  user, pass, bdd, serveur, email, host : string;
  n, i : integer;
  ch : string;
  msg : string;
begin
// Utilisateur	Mot de passe	DatabaseName	PMA URL	Email	Site web
  for i := 0 to Memo1.Lines.Count-1 do begin
    ch := Memo1.Lines [i];
    if (ch <> '') then begin
      n := pos (#9, ch);
      user := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      n := pos (#9, ch);
      pass := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      n := pos (#9, ch);
      bdd := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      n := pos (#9, ch);
      serveur := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      n := pos (#9, ch);
      email := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      host := ch;
      if ((user <> '') and (pass <> '') and (serveur <> '') and (email <> '') and (host <> '')) then begin
        msg := 'Bonjour'#10#10+
               'Vous avez demandé à bénéficier d''une base de données MySQL pour votre site '+host+'. Voici les paramètres à utiliser pour s''y connecter:'#10+
               #9'- hôte : sql.'+host+#10+
               #9'- base de données : '+bdd+#10+
               #9'- utilisateur : '+user+#10+
               #9'- mot de passe : '+pass+#10#10+
               'L''interface PHPMyAdmin est disponible à l''adresse http://'+serveur+' en utilisant les mêmes identifiants.'#10#10+
               'En cas de problème, contactez support@HOSTINGSERVICEDOMAIN'#10#10+
               'Merci d''avoir fait appel à nos services.'#10#10+
               '-- '#10+
               'HOSTINGSERVICE'#10+
               'https://www.HOSTINGSERVICEDOMAIN';
        IdSMTP1.QuickSend(edit1.Text, '[HOSTINGSERVICE] paramètres MYSQL de '+bdd+'//'+host, email, '"HOSTINGSERVICE" <support@HOSTINGSERVICEDOMAIN>', msg);
        IdSMTP1.QuickSend(edit1.Text, '[HOSTINGSERVICE] paramètres MYSQL de '+bdd+'//'+host+' (copie)', 'hebergement@HOSTINGSERVICEDOMAIN', '"HOSTINGSERVICE" <support@HOSTINGSERVICEDOMAIN>', msg);
        Memo1.Lines [i] := '=> '+Memo1.Lines [i];
      end;
    end;
  end;
  ShowMessage ('Fin de l''envoi des messages');
end;

end.
