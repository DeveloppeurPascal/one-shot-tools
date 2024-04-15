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
  System.IOUtils, fDisplayImages;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if not TDirectory.Exists(Edit1.Text) then
    raise exception.Create('Folder "' + Edit1.Text + '" doesn''t exist !');

  TfrmDisplayImages.Execute(Edit1.Text);
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
  Edit1.Text := tpath.getpicturespath;
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

end.
