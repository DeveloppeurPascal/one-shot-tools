unit fDisplayImages;

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
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.Objects;

type
  TfrmDisplayImages = class(TForm)
    Label1: TLabel;
    GlowEffect1: TGlowEffect;
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
  private
    ImageIndex: integer;
    ImagesList: TStringList;
    FShowImageFilename: boolean;
    procedure SetImagesPath(const Value: string);
    procedure SetShowImageFilename(const Value: boolean);
  protected
    procedure ShowPicture(Const FileName: string);
    procedure ShowNext;
    procedure ShowPrevious;
    procedure GoMainForm;
  public
    property ImagesPath: string write SetImagesPath;
    property ShowImageFilename: boolean read FShowImageFilename
      write SetShowImageFilename;
    class procedure Execute(Const AImagesPath: string;
      const AShowImageFilename: boolean);
  end;

implementation

{$R *.fmx}

uses
  System.IOUtils;

{ TfrmDisplayImages }

class procedure TfrmDisplayImages.Execute(const AImagesPath: string;
  const AShowImageFilename: boolean);
var
  frm: TfrmDisplayImages;
begin
  if not TDirectory.Exists(AImagesPath) then
    raise exception.Create('Folder "' + AImagesPath + '" doesn''t exist !');

  frm := TfrmDisplayImages.Create(application.MainForm);
  try
    frm.ImagesPath := AImagesPath;
    frm.ShowImageFilename := AShowImageFilename;
    frm.Show;
    // ShowModal is not compatible with FullScreen on macOS (15/04/2024)
    // frm.ShowModal;
  finally
    // frm.Free;
  end;
end;

procedure TfrmDisplayImages.FormCreate(Sender: TObject);
begin
  ImagesList := TStringList.Create;
  ImageIndex := -1;
  Timer1.Enabled := false;
end;

procedure TfrmDisplayImages.FormDestroy(Sender: TObject);
begin
  ImagesList.Free;
end;

procedure TfrmDisplayImages.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  case Key of
    vkUp, vkLeft:
      begin
        Key := 0;
        ShowPrevious;
      end;
    vkRight, vkDown:
      begin
        Key := 0;
        ShowNext;
      end;
    vkEscape, vkReturn:
      begin
        Key := 0;
        GoMainForm;
      end;
  end;
end;

procedure TfrmDisplayImages.GoMainForm;
begin
  // close;
  tthread.ForceQueue(nil,
    procedure
    begin
      Self.Free;
    end);
end;

procedure TfrmDisplayImages.SetImagesPath(const Value: string);
var
  Tab: TStringDynArray;
  i: integer;
  LowerFileName: string;
begin
  if not TDirectory.Exists(Value) then
    raise exception.Create('Folder "' + Value + '" doesn''t exist !');

  Tab := TDirectory.GetFiles(Value);
  ImagesList.clear;
  for i := 0 to length(Tab) - 1 do
    if tfile.Exists(Tab[i]) then
    begin
      LowerFileName := Tab[i].tolower;
      if LowerFileName.EndsWith('.jpg') or LowerFileName.EndsWith('.png') then
        ImagesList.add(Tab[i]);
    end;

  if ImagesList.Count < 1 then
    raise exception.Create('No picture to display in this folder.');

  ImageIndex := -1;

  ShowNext;
end;

procedure TfrmDisplayImages.SetShowImageFilename(const Value: boolean);
begin
  FShowImageFilename := Value;
end;

procedure TfrmDisplayImages.ShowNext;
begin
  inc(ImageIndex);

  if ImageIndex >= ImagesList.Count then
    ImageIndex := ImagesList.Count - 1;

  ShowPicture(ImagesList[ImageIndex])
end;

procedure TfrmDisplayImages.ShowPicture(const FileName: string);
begin
  if not tfile.Exists(FileName) then
    raise exception.Create('Image "' + FileName + '" doesn''t exist !');

  Image1.Bitmap.LoadFromFile(FileName);
  Label1.Text := tpath.GetFileName(FileName);
  Label1.Visible := FShowImageFilename;
  if Label1.Visible then
  begin
    Timer1.tag := 1000;
    Timer1.Enabled := true;
  end;
end;

procedure TfrmDisplayImages.ShowPrevious;
begin
  dec(ImageIndex);

  if (ImageIndex < 0) then
    ImageIndex := 0;

  ShowPicture(ImagesList[ImageIndex])
end;

procedure TfrmDisplayImages.Timer1Timer(Sender: TObject);
begin
  Timer1.tag := Timer1.tag - Timer1.Interval;
  if Timer1.tag < 1 then
  begin
    Timer1.Enabled := false;
    Label1.Visible := false;
  end;
end;

end.
