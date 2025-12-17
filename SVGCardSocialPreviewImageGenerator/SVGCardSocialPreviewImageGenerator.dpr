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
  File last update : 2025-07-14T15:53:37.248+02:00
  Signature : ceb09d1a7388f1f78c2b60f5658ff89d1111bb6d
  ***************************************************************************
*)

program SVGCardSocialPreviewImageGenerator;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  fMain in 'fMain.pas' {Form1},
  uSVGCardsDelphi12WithSkia in '..\lib-externes\SVG-cards\lib-Delphi\SVG-Skia4Delphi\uSVGCardsDelphi12WithSkia.pas',
  Olf.Skia.SVGToBitmap in '..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  udmAdobeStock_526775911 in 'X:\AdobeStock_526775911\udmAdobeStock_526775911.pas' {dmAdobeStock_526775911: TDataModule},
  Olf.FMX.TextImageFrame in '..\lib-externes\librairies\src\Olf.FMX.TextImageFrame.pas' {OlfFMXTextImageFrame: TFrame};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TdmAdobeStock_526775911, dmAdobeStock_526775911);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
