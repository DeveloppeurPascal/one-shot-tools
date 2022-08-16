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
  user, pass, serveur, email, host : string;
  n, i : integer;
  ch : string;
  msg : string;
begin
// Utilisateur FTP	Mot de passe	Serveur	Email	Site web
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
      serveur := copy (ch, 1, pred (n));
      delete (ch, 1, n);
      n := pos (#9, ch);
      email := copy (ch, 1, pred (n));
      delete (ch, 1, n);
//      n := pos (#9, ch);
//      host := copy (ch, 1, pred (n));
      host := ch;
      if ((user <> '') and (pass <> '') and (serveur <> '') and (email <> '') and (host <> '')) then begin
        msg := 'Bonjour'#10#10+
               'Pour modifier les pages de votre site http://www.'+host+', vous devez utiliser les paramètres de connexion FTP suivants:'#10+
               #9'- hôte : ftp.'+host+#10+
               #9'- utilisateur : '+user+#10+
               #9'- mot de passe : '+pass+#10#10+
               'Si vous utilisez Frontpage de Microsoft (ou un logiciel fonctionnant de la même façon pour la publication des sites), dans "Fichier" / "Publier le site", indiquez http://www.'+host+' comme nom de destinataire et utilisez les mêmes identifiants et mots de passe que pour le FTP.'#10#10+
               'Si vous utilisez un logiciel permettant une connexion directe (comme un butineur évolué), vous pouvez accéder au serveur avec cette URL : ftp://'+user+':'+pass+'@ftp.'+host+#10#10+
               'Si votre nom de domaine n''est pas encore accessible (en cours de création ou en cours de changement de serveur), vous pouvez remplacer temporairement ftp.'+host+' par '+serveur+' Votre site est en permanence accessible à l''adresse http://'+serveur+'/www.'+host+#10#10+
               'Par défaut, le serveur affichera les pages index.htm ou index.php. Pensez donc à en créer une dans chaque dossier si vous ne voulez pas que vos internautes arrivent sur des pages d''erreur 404 ("page non trouvée").'#10#10+
               'En cas de problème, contactez support@HOTSINGSERVICEDOMAIN'#10#10+
               'Merci d''avoir fait appel à nos services.'#10#10+
               '-- '#10+
               'HOTSINGSERVICE'#10+
               'https://www.HOTSINGSERVICEDOMAIN';
        IdSMTP1.QuickSend(edit1.Text, '[HOTSINGSERVICE] paramètres FTP de '+host, email, '"HOTSINGSERVICE" <support@HOTSINGSERVICEDOMAIN>', msg);
        IdSMTP1.QuickSend(edit1.Text, '[HOTSINGSERVICE] paramètres FTP de '+host+' (copie)', 'hebergement@HOTSINGSERVICEDOMAIN', '"HOTSINGSERVICE" <support@HOTSINGSERVICEDOMAIN>', msg);
        Memo1.Lines [i] := '=> '+Memo1.Lines [i];
      end;
    end;
  end;
  ShowMessage ('Fin de l''envoi des messages');
end;

end.
