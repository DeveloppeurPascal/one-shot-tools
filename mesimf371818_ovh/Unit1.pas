unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FireDAC.Stan.StorageJSON,
  FMX.Layouts, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    FDMemTable1: TFDMemTable;
    Button1: TButton;
    FDMemTable1user: TStringField;
    FDMemTable1pass: TStringField;
    Memo3: TMemo;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    Button2: TButton;
    Layout1: TLayout;
    Memo4: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses System.ioutils;

function serie_aleatoire: string;
var
  ch: string;
  i: integer;
  n: integer;
begin
  ch := '';
  for i := 1 to 10 do
  begin
    n := random(26 + 10);
    if (n < 26) then
      ch := ch + chr(ord('a') + n)
    else
      ch := ch + chr(ord('0') + n - 26);
    { endif }
  end;
  Result := ch;
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
  repeat
    n := pos('-', ch);
    if (n > 0) then
      delete(ch, n, 1);
    { endif }
  until (n = 0);
  Result := ch;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  n: integer;
  ch1, ch2, ch: string;
begin
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;
  Memo4.Lines.Clear;
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
    FDMemTable1.Insert;
    FDMemTable1.FieldByName('user').AsString := ch1;
    FDMemTable1.FieldByName('pass').AsString := ch2;
    FDMemTable1.Post;
    // gestion des utilisateurs (FTP et arborescence web)
    Memo2.Lines.add('userdel ' + ch1);
    Memo2.Lines.add('rm -f -R /home/' + ch1);
    Memo2.Lines.add('useradd -m ' + ch1);
    // Memo2.Lines.Add('useradd -m -s /sbin/nologin ' + ch1);
    Memo2.Lines.add('echo -e "' + ch2 + '\n' + ch2 + '" | passwd ' + ch1);
    Memo2.Lines.add('chmod +x /home/' + ch1);
    // gestion de Apache
    Memo3.Lines.add('<VirtualHost *:80>');
    Memo3.Lines.add(#9 + 'ServerAdmin support@olfsoft.com');
    Memo3.Lines.add(#9 + 'DocumentRoot /home/' + ch1 + '/www');
    Memo3.Lines.add(#9 + '<Directory /home/' + ch1 + '/www>');
    Memo3.Lines.add(#9 + #9 + 'AllowOverride all');
    Memo3.Lines.add(#9 + #9 + 'Require all granted');
    Memo3.Lines.add(#9 + '</Directory>');
    Memo3.Lines.add(#9 + 'ServerName ' + ch1 + '.mesimf371818.ovh');
    Memo3.Lines.add(#9 + 'CustomLog /home/' + ch1 + '/log/access_log combined');
    Memo3.Lines.add(#9 + 'ErrorLog /home/' + ch1 + '/log/error_log');
    Memo3.Lines.add('</VirtualHost>');
    // gestion de MySQL
    Memo4.Lines.add('CREATE USER ''' + ch1 +
      '''@''localhost'' IDENTIFIED BY  ''' + ch2 + ''';');
    Memo4.Lines.add('GRANT USAGE ON * . * TO  ''' + ch1 +
      '''@''localhost'' IDENTIFIED BY  ''' + ch2 +
      ''' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;');
    Memo4.Lines.add('CREATE DATABASE IF NOT EXISTS  `' + ch1 + '` ;');
    Memo4.Lines.add('GRANT ALL PRIVILEGES ON  `' + ch1 + '` . * TO  ''' + ch1 + '''@''localhost'';');
  end;
  showmessage('Génération terminée');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;
  Memo4.Lines.Clear;
  FDMemTable1.First;
  while not FDMemTable1.Eof do
  begin
    Memo1.Lines.add(FDMemTable1.FieldByName('user').AsString + #9 +
      FDMemTable1.FieldByName('pass').AsString);
    FDMemTable1.Next;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDMemTable1.ResourceOptions.PersistentFileName :=
    tpath.combine(tpath.GetDocumentsPath, 'MESIMF371818_OVH.json');
  FDMemTable1.ResourceOptions.Persistent := true;
  FDMemTable1.Open;
end;

end.
