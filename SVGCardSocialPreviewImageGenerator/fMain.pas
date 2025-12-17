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
  File last update : 2025-07-14T15:53:37.246+02:00
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
