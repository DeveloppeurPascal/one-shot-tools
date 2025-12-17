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
  File last update : 2025-12-10T19:53:26.597+01:00
  Signature : 53e9c6d106792e6881100ca685c91ce31a57d577
  ***************************************************************************
*)

program GenSite2025FixFooterAndLinksProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  Olf.FMX.SelectDirectory in '..\lib-externes\Delphi-FMXExtend-Library\src\Olf.FMX.SelectDirectory.pas',
  udmAdobeStock_186670253 in 'X:\AdobeStock_186670253\udmAdobeStock_186670253.pas' {dmAdobeStock_186670253: TDataModule},
  udmAdobeStock_186670296 in 'X:\AdobeStock_186670296\udmAdobeStock_186670296.pas' {dmAdobeStock_186670296: TDataModule},
  Olf.FMX.TextImageFrame in '..\lib-externes\librairies\src\Olf.FMX.TextImageFrame.pas' {OlfFMXTextImageFrame: TFrame},
  udmAdobeStock_257148021 in 'X:\AdobeStock_257148021\udmAdobeStock_257148021.pas' {dmAdobeStock_257148021: TDataModule},
  udmAdobeStock_310821053 in 'X:\AdobeStock_310821053\udmAdobeStock_310821053.pas' {dmAdobeStock_310821053: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmAdobeStock_186670253, dmAdobeStock_186670253);
  Application.CreateForm(TdmAdobeStock_186670296, dmAdobeStock_186670296);
  Application.CreateForm(TdmAdobeStock_257148021, dmAdobeStock_257148021);
  Application.CreateForm(TdmAdobeStock_310821053, dmAdobeStock_310821053);
  Application.Run;
end.
