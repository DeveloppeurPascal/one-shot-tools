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
  Signature : 60d4d042d242bdb989d270b3f0f4e95097027cf1
  ***************************************************************************
*)

unit Unit2;

interface

function traiter_dossier (dossier: string): boolean;

implementation
uses
  Dialogs,SysUtils;

function traiter_dossier (dossier: string): boolean;
var
  s : TSearchRec;
  f1, f2 : TextFile;
  sortie_ouverte : boolean;
  ch : string;
  table : string;
  n : integer;
  n2, n3 : integer;
begin
  sortie_ouverte := false;
  if (0 = FindFirst(dossier+'\*.csv', faAnyFile, s)) then repeat
    table := 'wsp_'+LowerCase (copy (s.Name, 1, length(s.Name)-length ('.csv')));
    AssignFile (f1, dossier+'\'+s.Name);
    Reset (f1);
    if not eof (f1) then begin
      readln (f1, ch);
      if (not sortie_ouverte) then begin
        AssignFile (f2, dossier+'\base-sql-'+FormatDateTime('yyyymmddhhnnsszzz', Now)+'.txt');
        Rewrite (f2);
        sortie_ouverte := true;
      end;
      if (pos ('driver={SQL Server};server=SERVERNAME;uid=USERNAME;pwd=PASSWORD;database=DATABASENAME', ch)>0) then
        delete (ch, 1, length ('driver={SQL Server};server=SERVERNAME;uid=USERNAME;pwd=PASSWORD;database=DATABASENAME'));
      {endif}
      ch := lowercase (ch);
      writeln (f2, 'drop table if exists '+table+';');
      write (f2, 'create table '+table+' (');
      n := pos (',', ch);
      while (n > 0) do begin
        n2 := pos ('cle_', ch);
        n3 := pos ('id_', ch);
        if (((n2 < n) and (n2 > 0)) or ((n3 < n) and (n3 > 0))) then
          write (f2, copy (ch, 1, pred (n))+' integer not null default "0", ')
        else
          write (f2, copy (ch, 1, pred (n))+' text not null default "", ');
        {endif}
        delete (ch, 1, n);
        n := pos (',', ch);
      end;
      n2 := pos ('cle_', ch);
      n3 := pos ('id_', ch);
      if (((n2 < n) and (n2 > 0)) or ((n3 < n) and (n3 > 0))) then
        writeln (f2, ch+' integer not null default "0");')
      else
        writeln (f2, ch+' text not null default "");');
      {endif}
      writeln (f2, 'LOAD DATA INFILE '''+StringReplace (dossier+'\'+s.name, '\', '\\', [rfReplaceAll])+''' INTO TABLE `'+table+'` FIELDS TERMINATED BY '','' OPTIONALLY ENCLOSED BY ''"'' LINES TERMINATED BY ''\r\n'';');
    end;
    CloseFile (f1);
  until (0 <> FindNext (s));
  FindClose (s);
  if (sortie_ouverte) then begin
    CloseFile (f2);
    Result := True;
  end else
    Result := False;
  {endif}
end;

end.
 
