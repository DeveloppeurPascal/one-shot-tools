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
  File last update : 2025-12-17T20:22:24.000+01:00
  Signature : cae9b78e70a91d455efbbcf66a17a7c33032a436
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
  FMX.StdCtrls,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Controls.Presentation,
  FMX.Edit;

type
  TfrmMain = class(TForm)
    edtRootFolder: TEdit;
    edtBlockPageSiteServerFolder: TEdit;
    btnProcess: TButton;
    Memo1: TMemo;
    cbLogOnlyNoChange: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
  private
  protected
    procedure AddLog(const text: string);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  System.IOUtils,
  uUpdateFoldersFromAFolder;

procedure TfrmMain.AddLog(const text: string);
begin
  memo1.lines.Add(text);
  memo1.GoToTextEnd;
end;

procedure TfrmMain.btnProcessClick(Sender: TObject);
begin
  edtRootFolder.Text := edtRootFolder.Text.Trim;
  if edtRootFolder.Text.IsEmpty then
    raise exception.create('Website root folder is needed !');
  if not tdirectory.Exists(edtRootFolder.Text) then
    raise exception.Create('Root folder doesn''t exist !');

  edtBlockPageSiteServerFolder.Text := edtBlockPageSiteServerFolder.Text.Trim;
  if edtBlockPageSiteServerFolder.Text.IsEmpty then
    raise exception.create('Block Page Site Server folder is needed !');
  if not tdirectory.Exists(edtBlockPageSiteServerFolder.Text) then
    raise exception.Create('Block Page Site Server folder doesn''t exist !');

  ProcessRootFolder(edtRootFolder.Text, edtBlockPageSiteServerFolder.Text, cbLogOnlyNoChange.IsChecked, procedure(const text:
      string)
    begin
      addlog(text);
    end);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  edtRootFolder.Text := 'W:\_FTPSauron';
  edtBlockPageSiteServerFolder.Text := 'C:\xampp\htdocs\Block-Page-Site-Server\src';
  cbLogOnlyNoChange.IsChecked := true;
end;

end.

