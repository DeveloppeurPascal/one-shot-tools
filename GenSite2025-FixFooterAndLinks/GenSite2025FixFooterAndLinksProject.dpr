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
  File last update : 2025-12-10T18:29:34.000+01:00
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
