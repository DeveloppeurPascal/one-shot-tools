﻿/// <summary>
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
/// File last update : 2025-02-05T21:09:26.293+01:00
/// Signature : 0859dc5ab1252fd6f8dc017c892cb8d56c5f8270
/// ***************************************************************************
/// </summary>

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
 
