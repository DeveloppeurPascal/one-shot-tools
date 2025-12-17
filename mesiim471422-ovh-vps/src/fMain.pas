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
  File last update : 2025-07-14T09:18:14.278+02:00
  Signature : b32b0acb2f71702d3c004047578e4df6f2468855
  ***************************************************************************
*)

unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.TabControl;

type
  TForm1 = class(TForm)
    mmoEmailList: TMemo;
    btnGenerer: TButton;
    mmoResult: TMemo;
    mmoMySQL: TMemo;
    mmoPostgreSQL: TMemo;
    TabControl1: TTabControl;
    tiResult: TTabItem;
    tiMySQL: TTabItem;
    tiPostgreSQL: TTabItem;
    procedure btnGenererClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tiResultClick(Sender: TObject);
    procedure tiMySQLClick(Sender: TObject);
    procedure tiPostgreSQLClick(Sender: TObject);
  private
    function getUserFromUserName(user: string; length: integer): string;
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure AjouteAccesPourEmail(email: string;
      result, mysql, postgresql: tstrings);
    function getUrlFromUserName(user: string): string;
    function getFTPHostFromUserName(user: string): string;
    function getMySQLDBNameFromUser(user: string): string;
    function getPostgreSQLDBNameFromUser(user: string): string;
    function getPassword(length: integer): string;
    function getUserNameFromEmail(email: string): string;
    function DuplicateString(s: string; count: integer): string;
    function getPostgreSQLAdminURL: string;
    function getMySQLAdminURL: string;
    function getFTPUserFromUserName(user: string): string;
    function getMySQLUserFromUserName(user: string): string;
    function getPostgreSQLUserFromUserName(user: string): string;
  end;

const
  CDomain = 'xxx.xx'; // your domain URL
  CPMAURL = 'pma.xxx.xx'; // phpMyAdmin URL
  CPGAURL = 'pga.xxx.xx'; // phpPGAdmin URL
{$MESSAGE FATAL 'Personalize this consts before using the program.'}

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AjouteAccesPourEmail(email: string;
  result, mysql, postgresql: tstrings);
var
  user: string;
  FTPUser: string;
  MySQLUser: string;
  MySQLPassword: string;
  MySQLDBName: string;
  PostgreSQLDBName: string;
  PostgreSQLPassword: string;
  PostgreSQLUser: string;
begin
  if not assigned(result) then
    raise exception.Create('Access code list unknown.');
  if not email.IsEmpty then
  begin
    user := getUserNameFromEmail(email);
    result.Add(DuplicateString('*', 70));
    result.Add('');
    result.Add('- Email :');
    result.Add(email);
    result.Add('');
    result.Add('- Site :');
    result.Add(getUrlFromUserName(user));
    result.Add('');
    // FTP
    result.Add(DuplicateString('*', 20));
    result.Add('* FTP');
    result.Add(DuplicateString('*', 20));
    result.Add('');
    result.Add('- Host :');
    result.Add(getFTPHostFromUserName(user));
    result.Add('- Port :');
    result.Add('21 (default)');
    result.Add('- User :');
    FTPUser := getFTPUserFromUserName(user);
    result.Add(FTPUser);
    result.Add('- Password :');
    result.Add(getPassword(random(8) + 8));
    result.Add('- Folder :');
    result.Add('/public_html');
    result.Add('');
    // SFTP
    result.Add(DuplicateString('*', 20));
    result.Add('* SFTP');
    result.Add(DuplicateString('*', 20));
    result.Add('');
    result.Add('- Host :');
    result.Add(getFTPHostFromUserName(user));
    result.Add('- Port :');
    result.Add('22 (default)');
    result.Add('- User :');
    result.Add(FTPUser);
    result.Add('- Password :');
    result.Add(getPassword(random(8) + 8));
    result.Add('- Folder :');
    result.Add('/home/' + FTPUser + '/public_html');
    result.Add('');
    // MariaDB (=> MySQL)
    result.Add(DuplicateString('*', 20));
    result.Add('* MariaDB/MySQL');
    result.Add(DuplicateString('*', 20));
    result.Add('');
    result.Add('- Host :');
    result.Add('localhost');
    result.Add('- Port :');
    result.Add('3306 (default)');
    result.Add('- User :');
    MySQLUser := getMySQLUserFromUserName(user);
    result.Add(MySQLUser);
    result.Add('- Password :');
    MySQLPassword := getPassword(random(8) + 8);
    result.Add(MySQLPassword);
    result.Add('- Database :');
    MySQLDBName := getMySQLDBNameFromUser(user);
    result.Add(MySQLDBName);
    result.Add('');
    result.Add('- Database admin (phpMyAdmin) :');
    result.Add('https://' + CPMAURL + '/');
    result.Add('');
    result.Add('- Database and user create MariaDB/MySQL Script :');
    result.Add('CREATE USER ''' + MySQLUser +
      '''@''localhost'' IDENTIFIED BY ''' + MySQLPassword + ''';');
    mysql.Add('CREATE USER ''' + MySQLUser + '''@''localhost'' IDENTIFIED BY '''
      + MySQLPassword + ''';');
    result.Add('GRANT USAGE ON * . * TO  ''' + MySQLUser +
      '''@''localhost'' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 ' +
      'MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;');
    mysql.Add('GRANT USAGE ON * . * TO  ''' + MySQLUser +
      '''@''localhost'' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 ' +
      'MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;');
    result.Add('CREATE DATABASE IF NOT EXISTS  ' + MySQLDBName +
      ' DEFAULT CHARACTER SET ''utf8mb4'';');
    mysql.Add('CREATE DATABASE IF NOT EXISTS  ' + MySQLDBName +
      ' DEFAULT CHARACTER SET ''utf8mb4'';');
    result.Add('GRANT ALL PRIVILEGES ON ' + MySQLDBName + '.* TO  ''' +
      MySQLUser + '''@''localhost'';');
    mysql.Add('GRANT ALL PRIVILEGES ON ' + MySQLDBName + '.* TO  ''' + MySQLUser
      + '''@''localhost'';');
    result.Add('');
    mysql.Add('');
    // PostgreSQL
    result.Add(DuplicateString('*', 20));
    result.Add('* PostgreSQL');
    result.Add(DuplicateString('*', 20));
    result.Add('');
    result.Add('- Host :');
    result.Add('localhost');
    result.Add('- Port :');
    result.Add('5432 (default)');
    result.Add('- User :');
    PostgreSQLUser := getPostgreSQLUserFromUserName(user);
    result.Add(PostgreSQLUser);
    result.Add('- Password :');
    PostgreSQLPassword := getPassword(random(8) + 8);
    result.Add(PostgreSQLPassword);
    result.Add('- Database :');
    PostgreSQLDBName := getPostgreSQLDBNameFromUser(user);
    result.Add(PostgreSQLDBName);
    result.Add('');
    result.Add('- Database admin (phpPgAdmin) :');
    result.Add('https://' + CPGAURL + '/');
    result.Add('');
    result.Add('- Database and user create PostgreSQL Script :');
    result.Add('CREATE USER ' + PostgreSQLUser + ' PASSWORD ''' +
      PostgreSQLPassword + ''';');
    postgresql.Add('CREATE USER ' + PostgreSQLUser + ' PASSWORD ''' +
      PostgreSQLPassword + ''';');
    result.Add('CREATE DATABASE ' + PostgreSQLDBName + ' OWNER ' +
      PostgreSQLUser + ' ENCODING ''utf8'';');
    postgresql.Add('CREATE DATABASE ' + PostgreSQLDBName + ' OWNER ' +
      PostgreSQLUser + ' ENCODING ''utf8'';');
    result.Add('');
    postgresql.Add('');
  end;
end;

procedure TForm1.btnGenererClick(Sender: TObject);
var
  i: integer;
begin
  TabControl1.ActiveTab := tiResult;
  mmoResult.Lines.Clear;
  mmoMySQL.Lines.Clear;
  // mmoMySQL.Lines.Add(DuplicateString('#', 30));
  // mmoMySQL.Lines.Add('# MySQL Script');
  // mmoMySQL.Lines.Add(DuplicateString('#', 30));
  mmoPostgreSQL.Lines.Clear;
  // mmoPostgreSQL.Lines.Add(DuplicateString('#', 30));
  // mmoPostgreSQL.Lines.Add('# PostgreSQL Script');
  // mmoPostgreSQL.Lines.Add(DuplicateString('#', 30));
  for i := 0 to mmoEmailList.Lines.count - 1 do
  begin
    AjouteAccesPourEmail(mmoEmailList.Lines[i].trim, mmoResult.Lines,
      mmoMySQL.Lines, mmoPostgreSQL.Lines);
  end;
end;

function TForm1.DuplicateString(s: string; count: integer): string;
var
  i: integer;
begin
  result := '';
  for i := 1 to count do
    result := result + s;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  mmoEmailList.Text := 'copy email list here';
  mmoEmailList.SelectAll;
  mmoEmailList.SetFocus;
  TabControl1.ActiveTab := tiResult;
end;

function TForm1.getFTPHostFromUserName(user: string): string;
begin
  result := user + '.' + CDomain;
end;

function TForm1.getFTPUserFromUserName(user: string): string;
begin
  result := getUserFromUserName(user, 15);
end;

function TForm1.getMySQLAdminURL: string;
begin
  result := 'https://pma.' + CDomain + '/';
end;

function TForm1.getMySQLDBNameFromUser(user: string): string;
begin
  result := ('my' + user).Substring(0, 15);
end;

function TForm1.getMySQLUserFromUserName(user: string): string;
begin
  result := getUserFromUserName(user, 15);
end;

function TForm1.getPassword(length: integer): string;
var
  i: integer;
begin
  result := '';
  for i := 1 to length do
  begin
    if (random(2) = 0) then
      randomize;
    case random(3) of
      0:
        result := result + chr(ord('A') + random(26));
      1:
        result := result + chr(ord('a') + random(26));
    else
      result := result + chr(ord('0') + random(10));
    end;
  end;
end;

function TForm1.getPostgreSQLAdminURL: string;
begin
  result := 'https://pga.' + CDomain + '/';
end;

function TForm1.getPostgreSQLDBNameFromUser(user: string): string;
begin
  result := ('pg' + user).Substring(0, 15);
end;

function TForm1.getPostgreSQLUserFromUserName(user: string): string;
begin
  result := getUserFromUserName(user, 15);
end;

function TForm1.getUserFromUserName(user: string; length: integer): string;
begin
  if (user.length > length) then
    result := user.Substring(0, length)
  else
    result := user + getPassword(length - user.length).ToLower;
end;

function TForm1.getUrlFromUserName(user: string): string;
begin
  result := 'https://' + user + '.' + CDomain;
end;

function TForm1.getUserNameFromEmail(email: string): string;
var
  i: integer;
  c: char;
begin
  result := '';
  email := email.ToLower;
  for i := 0 to email.length - 1 do
  begin
    if (i > 15) then
      break;
    c := email.Chars[i];
    if (c = '@') then
      break;
    if CharInSet(c, ['a' .. 'z']) then
      result := result + c
    else if CharInSet(c, ['0' .. '9']) and (result.length > 1) then
      result := result + c;
  end;
  if (result.length < 1) then
    raise exception.Create('No user name for the email "' + email + '".');
end;

procedure TForm1.tiMySQLClick(Sender: TObject);
begin
  mmoMySQL.SelectAll;
  mmoMySQL.CopyToClipboard;
end;

procedure TForm1.tiPostgreSQLClick(Sender: TObject);
begin
  mmoPostgreSQL.SelectAll;
  mmoPostgreSQL.CopyToClipboard;
end;

procedure TForm1.tiResultClick(Sender: TObject);
begin
  mmoResult.SelectAll;
  mmoResult.CopyToClipboard;
end;

initialization

randomize;

end.
