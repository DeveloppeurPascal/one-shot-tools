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
  File last update : 2025-12-31T20:00:20.000+01:00
  Signature : d777ff1dcfa59357eb47032dd3bf73986aab8be8
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
  FMX.Layouts,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.ListBox;

type
  TfrmMain = class(TForm)
    lbURLs: TListBox;
    edtFolderOfWebsites: TEdit;
    EllipsesEditButton1: TEllipsesEditButton;
    edtPageToCall: TEdit;
    GridPanelLayout1: TGridPanelLayout;
    btnGo: TButton;
    btnSelectAll: TButton;
    btnUnselectAll: TButton;
    procedure edtFolderOfWebsitesChange(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnUnselectAllClick(Sender: TObject);
    procedure EllipsesEditButton1Click(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure LoadList;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  System.Net.HttpClient,
  System.IOUtils,
  Olf.RTL.Params;

procedure TfrmMain.btnGoClick(Sender: TObject);
var
  i: integer;
  site: THTTPClient;
  answer: IHTTPResponse;
  url: string;
begin
  if edtPageToCall.Text.IsEmpty then
    raise exception.Create('Specify the page to call on each URL.');

  tparams.BeginUpdate;
  try
    tparams.setValue('PageToCall', edtPageToCall.Text);
    tparams.setValue('Folder', edtFolderOfWebsites.Text);
  finally
    tparams.EndUpdate;
  end;

  for i := 0 to lbURLs.Count - 1 do
    if lbURLs.ListItems[i].IsChecked then
    begin
      site := thttpclient.Create;
      try
        url := lbURLs.ListItems[i].Text + '/' + edtPageToCall.Text;
        answer := site.Get(url);
        if answer.StatusCode <> 200 then
        begin
          ShowMessage('Error ' + answer.StatusCode.ToString + ' when calling ' + url);
          break;
        end
        else
          lbURLs.ListItems[i].IsChecked := false;
      finally
        site.Free;
      end;
    end;

  ShowMessage('Done');
end;

procedure TfrmMain.btnSelectAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbURLs.Count - 1 do
    lbURLs.ListItems[i].IsChecked := true;
end;

procedure TfrmMain.btnUnselectAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbURLs.Count - 1 do
    lbURLs.ListItems[i].IsChecked := false;
end;

procedure TfrmMain.edtFolderOfWebsitesChange(Sender: TObject);
begin
  LoadList;
end;

procedure TfrmMain.EllipsesEditButton1Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('', '', s) and (not s.IsEmpty) and (tdirectory.exists(s)) then
    edtFolderOfWebsites.Text := s;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  edtPageToCall.Text := tparams.getValue('PageToCall', '');
  edtFolderOfWebsites.Text := tparams.getValue('Folder', '');
end;

procedure TfrmMain.LoadList;
var
  i: integer;
  folders: TStringDynArray;
begin
  if not tdirectory.exists(edtFolderOfWebsites.Text) then
    raise exception.Create('Specify a valid path.');

  lbURLs.BeginUpdate;
  try
    lbURLs.Clear;
    folders := tdirectory.GetDirectories(edtFolderOfWebsites.Text);
    for i := 0 to length(folders) - 1 do
      lbURLs.items.Add('https://' + tpath.GetFileName(folders[i]));
  finally
    lbURLs.EndUpdate;
  end;
end;

initialization
  TParams.InitDefaultFileNameV2('OlfSoftware', 'CallAPageOnManyURL');
end.

