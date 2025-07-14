(* C2PP
  ***************************************************************************

  One Shot Tools

  Copyright 2022-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://oneshottools.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/one-shot-tools

  ***************************************************************************
  File last update : 2025-02-09T11:12:13.669+01:00
  Signature : 58cf2530ac282c8fad676edb75d193c5b675357d
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
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Controls.Presentation;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Layout1: TLayout;
    EllipsesEditButton1: TEllipsesEditButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
    procedure EllipsesEditButton1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

Uses
  System.IOUtils,
  fDisplayImages,
  Olf.RTL.Params;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if not TDirectory.Exists(Edit1.Text) then
    raise exception.Create('Folder "' + Edit1.Text + '" doesn''t exist !');

  tparams.setValue('PP', Edit1.Text);
  tparams.setValue('SF', CheckBox1.IsChecked);
  tparams.Save;

  TfrmDisplayImages.Execute(Edit1.Text, CheckBox1.IsChecked);
end;

procedure TfrmMain.EllipsesEditButton1Click(Sender: TObject);
var
  Folder: string;
begin
  Folder := Edit1.Text;
  if SelectDirectory('Choose an images directory.', '', Folder) then
    Edit1.Text := Folder;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Edit1.Text := tparams.getValue('PP', tpath.getpicturespath);
  CheckBox1.IsChecked := tparams.getValue('SF', true);
  Edit1.SetFocus;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkEscape then
    close;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
tparams.InitDefaultFileNameV2('OlfSoftware', 'ShowImgFullScreen', true);

end.
