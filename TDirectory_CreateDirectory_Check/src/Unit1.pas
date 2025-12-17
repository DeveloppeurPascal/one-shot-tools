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
  File last update : 2025-07-14T09:18:14.295+02:00
  Signature : 701edd6148ec35bea356e4b6e1608a366ecdf601
  ***************************************************************************
*)

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Layouts, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Objects;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    greenled: TFillRGBEffect;
    redled: TFillRGBEffect;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
    function ExtendFolder(BaseFolder: string): string;
    procedure PlayWithFolder(Folder: string; SecondTime: boolean = false);
    procedure SetFolderError(const Value: boolean);
  public
    { Déclarations publiques }
    property FolderError: boolean write SetFolderError;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses System.IOUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FolderError := false;
  Memo1.Lines.Add('*** GetHomePath ***');
  PlayWithFolder(ExtendFolder(tpath.GetHomePath));
  Memo1.Lines.Add('*** GetPublicPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetPublicPath));
  Memo1.Lines.Add('*** GetLibraryPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetLibraryPath));
  Memo1.Lines.Add('*** GetTempPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetTempPath));
  Memo1.Lines.Add('*** GetDocumentsPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetDocumentsPath));
  Memo1.Lines.Add('*** GetDownloadsPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetDownloadsPath));
  Memo1.Lines.Add('*** GetPicturesPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetPicturesPath));
  Memo1.Lines.Add('*** GetMusicPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetMusicPath));
  Memo1.Lines.Add('*** GetMoviesPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetMoviesPath));
  Memo1.Lines.Add('*** GetSharedDocumentsPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetSharedDocumentsPath));
  Memo1.Lines.Add('*** GetSharedDownloadsPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetSharedDownloadsPath));
  Memo1.Lines.Add('*** GetSharedPicturesPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetSharedPicturesPath));
  Memo1.Lines.Add('*** GetSharedMusicPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetSharedMusicPath));
  Memo1.Lines.Add('*** GetSharedMoviesPath ***');
  PlayWithFolder(ExtendFolder(tpath.GetSharedMoviesPath));
end;

function TForm1.ExtendFolder(BaseFolder: string): string;
begin
  result := tpath.Combine(tpath.Combine(BaseFolder, 'MyCompany'), 'MyApp');
end;

procedure TForm1.PlayWithFolder(Folder: string; SecondTime: boolean);
begin
  Memo1.Lines.Add(Folder);
  if (not tdirectory.Exists(Folder)) then
  begin
    if SecondTime then
    begin
      Memo1.Lines.Add('=> *** ERROR *** TDirectory.CreateDirectory failed');
      FolderError := true;
    end
    else
    begin
      Memo1.Lines.Add('=> doesn''t exists');
      tdirectory.CreateDirectory(Folder);
      Memo1.Lines.Add('=> TDirectory.CreateDirectory done');
      PlayWithFolder(Folder, true);
      exit;
    end;
  end
  else
  begin
    Memo1.Lines.Add('=> exists');
    tdirectory.Delete(Folder);
    if tdirectory.Exists(Folder) then
    begin
      Memo1.Lines.Add('=> *** ERROR *** TDirectory.Delete failed');
      FolderError := true;
    end
    else
      Memo1.Lines.Add('=> TDirectory.Delete succeeded');
    tdirectory.Delete(tpath.Combine(Folder, '..'));
    if tdirectory.Exists(tpath.Combine(Folder, '..')) then
    begin
      Memo1.Lines.Add('=> *** ERROR *** TDirectory.Delete (./..) failed');
      FolderError := true;
    end
    else
      Memo1.Lines.Add('=> TDirectory.Delete (./..) succeeded');
  end;
  Memo1.Lines.Add('----------');
  Memo1.Lines.Add('');
end;

procedure TForm1.SetFolderError(const Value: boolean);
begin
  redled.Enabled := Value;
  greenled.Enabled := not Value;
end;

end.
