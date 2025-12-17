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
  File last update : 2025-12-10T19:53:26.641+01:00
  Signature : bb02ed74da98927683f3a10c2e647e841b671088
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
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  System.JSON;

type
  TfrmMain = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    function InitSettings: TJSONObject;
    procedure AddPage(PageName: string; Settings: TJSONObject);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  system.Hash,
  System.IOUtils;

const
  CMaxNbPages = 30 + 5;

procedure TfrmMain.AddPage(PageName: string; Settings: TJSONObject);
var
  page: tjsonobject;
  jso, block: tjsonobject;
  jsa, langues, contents: tjsonarray;
  i, j, nb: integer;
begin
  // page_(.*).json
  // https://codeberg.org/PatrickPremartin/Block-Page-Site-Server/src/branch/main/website-data-and-api.md

  langues := settings.GetValue<tjsonarray>('langs');

  page := tjsonobject.Create;
  try
    jsa := tjsonarray.Create;
    for i := 0 to langues.Count - 1 do
    begin
      jso := tjsonobject.Create;
      jso.AddPair('lang', langues[i].GetValue<string>('lang'));
      jso.AddPair('text', 'titre page ' + pagename + ' ' +
        langues[i].GetValue<string>('lang'));
      jso.AddPair('is_public', true);
      jsa.add(jso);
    end;
    page.AddPair('title', jsa);
    page.AddPair('page_name', pagename);
    page.AddPair('is_public', true);
    if random(50) > 25 then
      page.AddPair('theme_file', 'default')
    else
      page.AddPair('theme_file', '');
    if random(50) > 25 then
      page.AddPair('meta_robots', 'noindex')
    else
      page.AddPair('meta_robots', '');

    page.AddPair('metas', tjsonarray.Create);
    page.AddPair('links', tjsonarray.Create);
    page.AddPair('storage', tjsonarray.Create);

    contents := tjsonarray.Create;

    nb := random(20) + 1;
    while nb > 0 do
    begin
      dec(nb);
      case random(5) of
        0: // Add titles H1 to H6
          begin
            j := random(6) + 1;
            block := tjsonobject.Create;
            block.addpair('type', 'title');
            block.addpair('level', j);
            jsa := tjsonarray.Create;
            for i := 0 to langues.Count - 1 do
            begin
              jso := tjsonobject.Create;
              jso.AddPair('lang', langues[i].GetValue<string>('lang'));
              jso.AddPair('text', 'titre niveau ' + j.tostring + ' ' +
                langues[i].GetValue<string>('lang'));
              jso.AddPair('is_public', true);
              jsa.add(jso);
            end;
            block.AddPair('content', jsa);
            block.AddPair('is_public', true);
            contents.Add(block);
          end;
        1: // Add a text
          begin
            block := tjsonobject.Create;
            block.addpair('type', 'text');
            jsa := tjsonarray.Create;
            for i := 0 to langues.Count - 1 do
            begin
              jso := tjsonobject.Create;
              jso.AddPair('lang', langues[i].GetValue<string>('lang'));
              jso.AddPair('text',
                langues[i].GetValue<string>('lang') + '  lorem ipsum' +
                sLineBreak +
                'lorem ipsum');
              jso.AddPair('is_public', true);
              jsa.add(jso);
            end;
            block.AddPair('content', jsa);
            block.AddPair('is_public', true);
            contents.Add(block);
          end;
        2: // Add an image
          begin
            block := tjsonobject.Create;
            block.addpair('type', 'image');
            jsa := tjsonarray.Create;
            for i := 0 to langues.Count - 1 do
            begin
              jso := tjsonobject.Create;
              jso.AddPair('lang', langues[i].GetValue<string>('lang'));
              jso.AddPair('text',
                langues[i].GetValue<string>('lang') + ' alt image');
              case random(6) of
                0: jso.AddPair('url_image',
                    '../img/AdobeStock_45746058-800x800.jpeg');
                1: jso.AddPair('url_image',
                    '../img/AdobeStock_22301470-800x800.jpeg');
                2: jso.AddPair('url_image',
                    '../img/AdobeStock_23717090-800x800.jpeg');
                3: jso.AddPair('url_image',
                    '../img/AdobeStock_26084381-800x800.jpeg');
                4: jso.AddPair('url_image',
                    '../img/AdobeStock_45538247-800x800.jpeg');
              else
                jso.AddPair('url_image', '');
              end;
              if random(20) > 10 then
                jso.AddPair('url', 'page' + random(CMaxNbPages).tostring +
                  '.html')
              else
                jso.AddPair('url', '');
              jso.AddPair('is_public', true);
              jsa.add(jso);
            end;
            block.AddPair('content', jsa);
            block.AddPair('is_public', true);
            contents.Add(block);
          end;
        3: // code HTML
          begin
            block := tjsonobject.Create;
            block.addpair('type', 'html');
            jsa := tjsonarray.Create;
            for i := 0 to langues.Count - 1 do
            begin
              jso := tjsonobject.Create;
              jso.AddPair('lang', langues[i].GetValue<string>('lang'));
              case random(4) of
                0:
                  jso.AddPair('text',
                    '<div style="position: relative; padding-top: 56.25%;"><iframe title="RAD Studio 13 Florence" width="100%" height="100%" src="https://videos.apprendre-delphi.fr/video-playlists/embed/6hiEQyLDiSpJ3v553EP2Gn?playlistPosition=1" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" style="position: absolute; inset: 0px;"></iframe></div>');
                1:
                  jso.AddPair('text',
                    '<div style="position: relative; padding-top: 56.25%;"><iframe title="RAD Studio 13 Florence" width="100%" height="100%" src="https://videos.apprendre-delphi.fr/video-playlists/embed/6hiEQyLDiSpJ3v553EP2Gn?playlistPosition=2" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" style="position: absolute; inset: 0px;"></iframe></div>');
                2:
                  jso.AddPair('text',
                    '<div style="position: relative; padding-top: 56.25%;"><iframe title="RAD Studio 13 Florence" width="100%" height="100%" src="https://videos.apprendre-delphi.fr/video-playlists/embed/6hiEQyLDiSpJ3v553EP2Gn?playlistPosition=3" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" style="position: absolute; inset: 0px;"></iframe></div>');
              else
                jso.AddPair('text',
                  '<div style="position: relative; padding-top: 56.25%;"><iframe title="RAD Studio 13 Florence" width="100%" height="100%" src="https://videos.apprendre-delphi.fr/video-playlists/embed/6hiEQyLDiSpJ3v553EP2Gn?playlistPosition=4" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" style="position: absolute; inset: 0px;"></iframe></div>');
              end;
              jso.AddPair('is_public', true);
              jsa.add(jso);
            end;
            block.AddPair('content', jsa);
            block.AddPair('is_public', true);
            contents.Add(block);
          end;
        4: // ajout d'un bloc de lien
          begin
            block := tjsonobject.Create;
            block.addpair('type', 'link');
            jsa := tjsonarray.Create;
            for i := 0 to langues.Count - 1 do
            begin
              jso := tjsonobject.Create;
              jso.AddPair('lang', langues[i].GetValue<string>('lang'));
              jso.AddPair('text',
                langues[i].GetValue<string>('lang') + ' text du lien');
              if random(20) > 10 then
                jso.AddPair('url', 'page' + random(CMaxNbPages).tostring +
                  '.html')
              else
                jso.AddPair('url', '');
              // picto_url
              // picto_alt
              jso.AddPair('is_public', true);
              jsa.add(jso);
            end;
            block.AddPair('content', jsa);
            block.AddPair('is_public', true);
            contents.Add(block);
          end;
      else
      end;
    end;
    page.AddPair('contents', contents);

    tfile.WriteAllText(tpath.Combine(edit1.Text, 'page_' +
      THashSHA1.GetHashString(pagename) + '.json'), page.ToJSON,
      TEncoding.ASCII); // TODO : UTF8 => BOM pas géré par PHP
  finally
    page.free;
  end;

end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  i, nb: integer;
  settings: TJSONObject;
begin
  if edit1.Text.trim.IsEmpty then
    raise Exception.create('Chemin de destination obligatoire.');

  randomize;

  settings := InitSettings;
  try
    AddPage('index.html', settings);
    AddPage('403-forbidden.html', settings);
    AddPage('404-filenotfound.html', settings);
    nb := random(cmaxnbpages - 5) + 5;
    for i := 1 to nb do
      AddPage('page' + i.tostring + '.html', settings);

    TFile.WriteAllText(tpath.combine(edit1.Text, 'settings.json'),
      settings.ToJSON, tencoding.ASCII); // TODO : UTF8 => BOM pas géré par PHP
  finally
    settings.Free;
  end;

  ShowMessage('Done !');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  edit1.text := 'C:\xampp\htdocs\Link-Website-Server\src\_db-tests';
end;

function TfrmMain.InitSettings: TJSONObject;
var
  jso, copyright: TJSONObject;
  jsa, langues, liste: TJSONArray;
  i, j, nb: integer;
begin
  // settings.json
  // https://codeberg.org/PatrickPremartin/Block-Page-Site-Server/src/branch/main/website-data-and-api.md

  result := TJSONObject.Create;
  langues := tjsonarray.Create;
  jso := tjsonobject.Create;
  jso.AddPair('lang', 'fr');
  jso.AddPair('url', 'img/flags/fr.svg');
  langues.Add(jso);
  jso := tjsonobject.Create;
  jso.AddPair('lang', 'en');
  jso.AddPair('url', 'img/flags/gb.svg');
  langues.Add(jso);
  jso := tjsonobject.Create;
  jso.AddPair('lang', 'it');
  jso.AddPair('url', 'img/flags/it.svg');
  langues.Add(jso);
  jso := tjsonobject.Create;
  jso.AddPair('lang', 'jp');
  jso.AddPair('url', 'img/flags/jp.svg');
  langues.Add(jso);
  result.AddPair('langs', langues);
  result.AddPair('default_lang', 'en');
  result.AddPair('favicon_url', 'test.ico');
  result.AddPair('apple_application_id', '');
  result.AddPair('default_theme_file', 'default');
  result.AddPair('default_meta_robots', 'index,follow,noarchive');

  jsa := tjsonarray.Create;
  for i := 0 to langues.Count - 1 do
  begin
    jso := tjsonobject.Create;
    jso.AddPair('lang', langues[i].GetValue<string>('lang'));
    jso.AddPair('text', 'img_' + langues[i].GetValue<string>('lang'));
    jso.AddPair('url_image', 'img/github-social-preview.jpeg');
    jso.AddPair('is_public', true);
    jsa.add(jso);
  end;
  jso := tjsonobject.Create;
  jso.AddPair('content', jsa);
  jso.AddPair('is_public', true);
  result.AddPair('default_image', jso);
  result.AddPair('metas', tjsonarray.Create);
  result.AddPair('links', tjsonarray.Create);
  result.AddPair('storage', tjsonarray.Create);

  liste := tjsonarray.create;
  jsa := tjsonarray.Create;
  for i := 0 to langues.Count - 1 do
  begin
    jso := tjsonobject.Create;
    jso.AddPair('lang', langues[i].GetValue<string>('lang'));
    jso.AddPair('text', 'Accueil_' + langues[i].GetValue<string>('lang'));
    jso.AddPair('url', 'index.html');
    jso.AddPair('is_public', true);
    jsa.add(jso);
  end;
  liste.add(jsa);
  for j := 1 to random(5) + 5 do
  begin
    jsa := tjsonarray.Create;
    for i := 0 to langues.Count - 1 do
    begin
      nb := random(CMaxNbPages);
      jso := tjsonobject.Create;
      jso.AddPair('lang', langues[i].GetValue<string>('lang'));
      jso.AddPair('text', 'Page_' + nb.tostring + '_' +
        langues[i].GetValue<string>('lang'));
      jso.AddPair('url', 'page' + nb.tostring + '.html');
      jso.AddPair('is_public', true);
      jsa.add(jso);
    end;
    liste.add(jsa);
  end;
  result.AddPair('menu_header', liste);

  liste := tjsonarray.create;
  jsa := tjsonarray.Create;
  for i := 0 to langues.Count - 1 do
  begin
    jso := tjsonobject.Create;
    jso.AddPair('lang', langues[i].GetValue<string>('lang'));
    jso.AddPair('text', 'Accueil_' + langues[i].GetValue<string>('lang'));
    jso.AddPair('url', 'index.html');
    jso.AddPair('is_public', true);
    jsa.add(jso);
  end;
  liste.add(jsa);
  for j := 1 to random(5) + 5 do
  begin
    jsa := tjsonarray.Create;
    for i := 0 to langues.Count - 1 do
    begin
      nb := random(CMaxNbPages);
      jso := tjsonobject.Create;
      jso.AddPair('lang', langues[i].GetValue<string>('lang'));
      jso.AddPair('text', 'Page_' + nb.tostring + '_' +
        langues[i].GetValue<string>('lang'));
      jso.AddPair('url', 'page' + nb.tostring + '.html');
      jso.AddPair('is_public', true);
      jsa.add(jso);
    end;
    liste.add(jsa);
  end;
  result.AddPair('menu_footer', liste);

  copyright := tjsonobject.Create;
  jsa := tjsonarray.Create;
  for i := 0 to langues.Count - 1 do
  begin
    jso := tjsonobject.Create;
    jso.AddPair('lang', langues[i].GetValue<string>('lang'));
    jso.AddPair('text', 'Copyright text_' +
      langues[i].GetValue<string>('lang'));
    jso.AddPair('is_public', true);
    jsa.add(jso);
  end;
  copyright.AddPair('text', jsa);
  copyright.AddPair('created_year', random(30) + 1995);
  jsa := tjsonarray.Create;
  for i := 0 to langues.Count - 1 do
  begin
    jso := tjsonobject.Create;
    jso.AddPair('lang', langues[i].GetValue<string>('lang'));
    jso.AddPair('text', 'Editor name_' + langues[i].GetValue<string>('lang'));
    jso.AddPair('url', 'https://olfsoftware.fr');
    jso.AddPair('is_public', true);
    jsa.add(jso);
  end;
  copyright.AddPair('editors', tjsonarray.create.add(jsa));
  result.AddPair('copyright', copyright);
end;

end.

