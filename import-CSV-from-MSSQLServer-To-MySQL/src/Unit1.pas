/// <summary>
/// ***************************************************************************
///
/// One Shot Tools
///
/// Copyright 2022-2024 Patrick PREMARTIN under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// projects for a unique (or very little number of) usage
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://oneshottools.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/one-shot-tools
///
/// ***************************************************************************
/// File last update : 2025-02-05T21:09:26.293+01:00
/// Signature : aa5129a7754fe0d8da6b06b932f28a352140c21e
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Outline, DirOutln, StdCtrls, ComCtrls, ShellCtrls;

type
  TForm1 = class(TForm)
    ShellTreeView1: TShellTreeView;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (traiter_dossier (ShellTreeView1.Path)) then
    ShowMessage ('Base correctement créée')
  else
    ShowMessage ('Base non créée');
  {endif}
end;

end.
