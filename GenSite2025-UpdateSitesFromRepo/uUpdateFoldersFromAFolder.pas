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
  File last update : 2025-12-17T21:06:32.000+01:00
  Signature : 99b817fc8a0b0e0dd04bb1b58d97d4d6fc06fa67
  ***************************************************************************
*)

unit uUpdateFoldersFromAFolder;

interface

uses
  System.SysUtils;

type
  TLogProc = reference to procedure(const Text: string);

procedure ProcessRootFolder(const RootFolder, FromFolder: string; const AsATest: boolean; const Log: TLogProc);

implementation

uses
  System.Types,
  System.IOUtils;

procedure SynchronizeFolder(const ToFolder, FromFolder: string; const AsATest: boolean; const Log: TLogProc; const
  SiteFolderNbChar, FromFolderNbChar: integer);
var
  SubFolders, Files: TStringDynArray;
  FileName: string;
  ToFile: string;
  I: integer;
begin
  if not tdirectory.Exists(fromfolder) then
    exit;

  if not tdirectory.Exists(tofolder) then
  begin
    log('- create folder "' + ToFolder.Substring(SiteFolderNbChar) + '"');
    if not AsATest then
      tdirectory.CreateDirectory(tofolder);
  end;

  SubFolders := TDirectory.GetDirectories(FromFolder);
  for i := 0 to length(subfolders) - 1 do
    if (not SubFolders[i].StartsWith('_')) and (not SubFolders[i].EndsWith('xxx', true)) then
      SynchronizeFolder(tpath.Combine(ToFolder, tpath.GetFileName(SubFolders[i])), SubFolders[i], asatest, log,
        SiteFolderNbChar, FromFolderNbChar);

  Files := TDirectory.GetFiles(FromFolder);
  for i := 0 to length(files) - 1 do
  begin
    filename := tpath.GetFileName(files[i]);
    if filename.StartsWith('.DS_Store', true) or filename.StartsWith('Thumb', true) or filename.StartsWith('htaccess', true)
      then
      continue;
    ToFile := tpath.Combine(tofolder, filename);
    if (not tfile.Exists(ToFile)) then
    begin
      log('- add file "' + Files[i].Substring(FromFolderNbChar) + '" as "' + ToFile.Substring(SiteFolderNbChar) + '"');
      if not AsATest then
        tfile.Copy(Files[i], ToFile);
    end
    else if tfile.GetLastWriteTime(files[i]) > tfile.GetLastWriteTime(tofile) then
    begin
      log('- update file "' + Files[i].Substring(FromFolderNbChar) + '" as "' + ToFile.Substring(SiteFolderNbChar) + '"');
      if not AsATest then
        tfile.Copy(Files[i], ToFile, True);
    end;
  end;
end;

procedure ProcessFolder(const SiteFolder, FromFolder: string; const AsATest: boolean; const Log: TLogProc);
var
  SubFolders: TStringDynArray;
  FolderName: string;
  SourceFolder: string;
  i: integer;
  p: integer;
begin
  log('Site folder : ' + SiteFolder);

  SynchronizeFolder(SiteFolder, FromFolder, AsATest, log, SiteFolder.Length, FromFolder.Length);

  SubFolders := TDirectory.GetDirectories(SiteFolder);
  for i := 0 to length(subfolders) - 1 do
  begin
    FolderName := tpath.GetFileName(SubFolders[i]);
    SourceFolder := tpath.Combine(FromFolder, FolderName);
    if TDirectory.Exists(Sourcefolder) then
      SynchronizeFolder(subfolders[i], SourceFolder, AsATest, log, SiteFolder.Length, FromFolder.Length)
    else if FolderName.StartsWith('_') then
    begin
      p := foldername.LastIndexOf('-');
      while (p > 0) do
      begin
        FolderName := FolderName.Substring(0, p);
        SourceFolder := tpath.Combine(FromFolder, FolderName + '-xxxxxxx');
        if TDirectory.Exists(Sourcefolder) then
        begin
          SynchronizeFolder(subfolders[i], SourceFolder, AsATest, log, SiteFolder.Length, FromFolder.Length);
          p := -1;
        end
        else
          p := foldername.LastIndexOf('-');
      end;
    end;
  end;

  Log('--------------------------------------------------');
end;

procedure ProcessRootFolder(const RootFolder, FromFolder: string; const AsATest: boolean; const Log: TLogProc);
var
  SiteFolders: TStringDynArray;
  i: integer;
begin
  Log('----------');
  log('Root folder : ' + RootFolder);
  log('From folder : ' + FromFolder);
  if asatest then
    log('*** test only ***');
  Log('----------');

  sitefolders := tdirectory.GetDirectories(RootFolder);
  for i := 0 to length(sitefolders) - 1 do
    ProcessFolder(SiteFolders[i], FromFolder, AsATest, Log);
end;

end.

