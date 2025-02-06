/// <summary>
/// ***************************************************************************
///
/// One Shot Tools
///
/// Copyright 2022-2024 Patrick PREMARTIN under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// projects for a unique (or very little number of) usage
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://oneshottools.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/one-shot-tools
///
/// ***************************************************************************
/// File last update : 2025-02-05T21:09:26.324+01:00
/// Signature : 51c94e810a05d1d0c97e09e8d250c3be463d3f4b
/// ***************************************************************************
/// </summary>

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
