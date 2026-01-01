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
  File last update : 2025-12-31T15:47:32.000+01:00
  Signature : 7e35094b6da2894bda7bc5034f935784f3b7491b
  ***************************************************************************
*)

unit fMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  Olf.FMX.SelectDirectory;

type
  TfrmMain = class(TForm)
    Edit1: TEdit;
    btnStart: TButton;
    EllipsesEditButton1: TEllipsesEditButton;
    Memo1: TMemo;
    OlfSelectDirectoryDialog1: TOlfSelectDirectoryDialog;
    procedure EllipsesEditButton1Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure ProcessFolder(const Path: string; const WebSites: TStringList);
    procedure ProcessSite(const SiteName, SiteURL, Path: string);
    procedure CreateTitleImages(const SiteTitle, SiteURL, Path: string);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  System.IOUtils,
  System.JSON,
  Olf.FMX.TextImageFrame,
  udmAdobeStock_186670253,
  udmAdobeStock_186670296,
  FMX.ImgList,
  FMX.Layouts,
  udmAdobeStock_257148021,
  udmAdobeStock_310821053;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  WebSites: TStringList;
  i: integer;
  s: string;
begin
  WebSites := TStringList.Create;
  try
    ProcessFolder(edit1.Text, Websites);
    if WebSites.Count > 1 then
    begin
      websites.Sort;
      s := '<!DOCTYPE html><html><head><meta charset="UTF-8">' +
      '<meta http-equiv="content-type" content="text/html; charset=UTF-8">' +
      '<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">' +
      '<title>Websites list</title></head><body><h1>Websites list</h1>';
      for i := 0 to websites.Count - 1 do
        s := s + '<p><a href="' + WebSites[i] + '">' + WebSites[i] + '</a></p>';
      s := s + '</body></html>';
      TFile.WriteAllText(tpath.combine(edit1.Text, 'websites.html'), s, TEncoding.UTF8);
    end;
  finally
    WebSites.Free;
  end;
end;

procedure TfrmMain.CreateTitleImages(const SiteTitle, SiteURL, Path: string);
var
  l: TLayout;
  txt: TOlfFMXTextImageFrame;
  bmp: TBitmap;
  ImgPath: string;
  LightFont, DarkFont: TImageList;
begin
  if siteurl.contains('gamolf.fr') then
  begin
    LightFont := dmAdobeStock_310821053.ImageList;
    DarkFont := lightfont;
  end
  else if siteurl.contains('olfsoftware.fr') then
  begin
    LightFont := dmAdobeStock_257148021.ImageList;
    DarkFont := lightfont;
  end
  else
  begin
    LightFont := dmAdobeStock_186670296.ImageList;
    DarkFont := dmAdobeStock_186670253.ImageList;
  end;
  ImgPath := tpath.combine(path, '..', 'img');
  if not tdirectory.Exists(imgpath) then
  begin
    TDirectory.CreateDirectory(ImgPath);
    tfile.Copy(tpath.Combine(path, 'index.php'), tpath.Combine(ImgPath, 'index.php'));
  end;
  l := tlayout.Create(self);
  try
    l.parent := self;
    l.Width := 800;
    l.height := 250;
    txt := TOlfFMXTextImageFrame.Create(self);
    try
      txt.parent := l;
      txt.Align := TAlignLayout.Center;
      txt.AutoSize := true;
      txt.Text := SiteTitle;
      // Title in light font
      txt.height := l.height;
      txt.Font := LightFont;
      txt.Refresh;
      l.height := txt.height;
      bmp := l.MakeScreenshot; // Take current BitmapScale
      // TODO : see how to resize the Bitmap to save it with a 1:1 BMPScale
      l.height := 250;
      try
        if not tfile.Exists(tpath.combine(ImgPath, 'title-light.png')) then
          bmp.SaveToFile(tpath.combine(ImgPath, 'title-light.png'));
      finally
        bmp.free;
      end;
      // Title in dark font
      txt.height := l.height;
      txt.Font := DarkFont;
      txt.Refresh;
      l.height := txt.height;
      bmp := l.MakeScreenshot;
      l.height := 250;
      try
        if not tfile.Exists(tpath.combine(ImgPath, 'title-dark.png')) then
          bmp.SaveToFile(tpath.combine(ImgPath, 'title-dark.png'));
      finally
        bmp.free;
      end;
    finally
      txt.Free;
    end;
  finally
    l.Free;
  end;
end;

procedure TfrmMain.EllipsesEditButton1Click(Sender: TObject);
begin
  if OlfSelectDirectoryDialog1.Execute then
    Edit1.Text := OlfSelectDirectoryDialog1.Directory;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  edit1.Text := 'C:\xampp\htdocs\_____AllProjectsWebSites';
{$ENDIF}
{$IFDEF OSX}
  edit1.Text := '/Users/patrickpremartin/Sites/_FTPSauron';
{$ENDIF}
end;

procedure TfrmMain.ProcessFolder(const Path: string; const WebSites: TStringList);
var
  FolderName, DomainName: string;
  Folders: TStringDynArray;
  i: integer;
begin
  if (not path.IsEmpty) and tdirectory.Exists(path) then
  begin
    FolderName := tpath.GetFileName(path);
    if (FolderName.StartsWith('_db-') and tfile.Exists(tpath.Combine(path, 'settings.json'))) then
    begin
      DomainName := tpath.GetFileName(tpath.GetDirectoryName(Path));
      memo1.lines.add('********************************************');
      memo1.lines.add('> https://' + DomainName);
      memo1.lines.add('> ' + tpath.GetDirectoryName(Path));
      ProcessSite(DomainName, 'https://' + DomainName, Path);
      websites.Add('https://' + DomainName);
    end
    else
    begin
      folders := tdirectory.GetDirectories(path);
      for i := 0 to length(folders) - 1 do
        processfolder(folders[i], WebSites);
    end;
  end;
end;

procedure TfrmMain.ProcessSite(const SiteName, SiteURL, Path: string);
var
  Settings, PrevSettings: string;
  jso: TJSONObject;
  jsa: TJSONArray;
  SiteTitle: string;
  i: integer;
  Key, Value: string;
  Files: TStringDynArray;
  FileName: string;
  PrevPage, Page: string;
begin
  if (not path.IsEmpty) and tdirectory.Exists(path) and tfile.Exists(tpath.Combine(path, 'settings.json')) then
  begin
    PrevSettings := tfile.ReadAllText(tpath.Combine(path, 'settings.json'));
    Settings := PrevSettings.Replace('Nos libraries', 'Nos librairies');
    Settings := Settings.Replace('default_image":{}',
      'default_image":{"content":[{"lang":"en","text":"","url_image":"/img/title-light.png","is_public":true}],"is_public":true}');
    if not SameText(settings, PrevSettings) then
      TFile.WriteAllText(tpath.Combine(path, 'settings.json'), settings, TEncoding.ANSI);
    jso := TJSONObject.ParseJSONValue(settings) as TJSONObject;
    try
      jsa := jso.GetValue<TJSONArray>('storage');
      if assigned(jsa) and (jsa.count > 0) then
        for i := 0 to jsa.count - 1 do
          if (jsa[i] as TJSONObject).TryGetValue<string>('key', key) and SameText(Key, 'site_name') and (jsa[i] as
            TJSONObject).TryGetValue<string>('value', SiteTitle) then
          begin
            CreateTitleImages(SiteTitle, SiteURL, Path);
            break;
          end;
    finally
      jso.Free;
    end;
    Files := TDirectory.GetFiles(path);
    for i := 0 to length(Files) - 1 do
    begin
      FileName := TPath.GetFileName(files[i]);
      if filename.StartsWith('page_') and filename.EndsWith('.json') then
      begin
        PrevPage := tfile.ReadAllText(files[i]);
        Page := PrevPage.Replace('nos logiciel ', 'nos logiciels ');
        if not SameText(Page, PrevPage) then
          TFile.WriteAllText(files[i], Page, TEncoding.ANSI);
      end;
    end;
    FileName := TPath.Combine(path, '..', 'robots.txt');
    if tfile.Exists(filename) then
    begin
      PrevPage := tfile.ReadAllText(filename);
      Page := PrevPage.Replace('sitemap.php', 'sitemap.xml');
      if not SameText(Page, PrevPage) then
        TFile.WriteAllText(filename, Page, TEncoding.ANSI);
    end;
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;
end.

