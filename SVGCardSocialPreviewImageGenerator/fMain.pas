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
  File last update : 2025-07-14T15:50:56.000+02:00
  Signature : 8dfcdc81da519393f72364ba66dd674b65eea23f
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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  Olf.FMX.TextImageFrame;

type
  TForm1 = class(TForm)
    btnAddCards: TButton;
    lSocialPreview: TLayout;
    btnCaptureImage: TButton;
    OlfFMXTextImageFrame1: TOlfFMXTextImageFrame;
    procedure btnAddCardsClick(Sender: TObject);
    procedure btnCaptureImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.IOUtils,
  uSVGCardsDelphi12WithSkia,
  udmAdobeStock_526775911;

procedure TForm1.btnAddCardsClick(Sender: TObject);
const
  CardWidth = 170;
  CardHeight = 248;
var
  img: timage;
  nb: integer;
  ratio: single;
begin
  lSocialPreview.BeginUpdate;
  try
    nb := random(20) + 1;
    while (nb > 0) do
    begin
      img := timage.Create(self);
      img.BeginUpdate;
      try
        ratio := (10 + random(10) - 5) / 10; // 0,5 - 1,5
        img.width := CardWidth * ratio;
        img.height := CardHeight * ratio;
        img.position.x := random(trunc(lSocialPreview.width + img.width)) -
          img.width;
        img.position.y := random(trunc(lSocialPreview.height + img.height)) -
          img.height;
        img.Parent := lSocialPreview;
        img.Bitmap.Assign
          (TSVGCards.Bitmap(TSVGCardsIndex(random(TSVGCards.Count)), img.width,
          img.height, 1));
        if (random(100) > 50) then
          img.RotationAngle := random(360);
      finally
        img.EndUpdate;
      end;
      dec(nb);
    end;
    OlfFMXTextImageFrame1.BringToFront;
  finally
    lSocialPreview.EndUpdate;
  end;
end;

procedure TForm1.btnCaptureImageClick(Sender: TObject);
var
  bmp: tbitmap;
begin
  bmp := lSocialPreview.MakeScreenshot;
  try
    bmp.SaveToFile(tpath.combine(tpath.GetDocumentsPath,
      'SVGCards-' + bmp.width.ToString + 'x' + bmp.height.ToString + '.png'));
  finally
    bmp.free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Typo not available on public repository,
  // you can buy it from https://stock.adobe.com
  OlfFMXTextImageFrame1.Font := dmAdobeStock_526775911.ImageList;
  OlfFMXTextImageFrame1.AutoSize := true;
  OlfFMXTextImageFrame1.Text := 'SVG Cards';
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
randomize;

end.
