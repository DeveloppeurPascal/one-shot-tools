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
