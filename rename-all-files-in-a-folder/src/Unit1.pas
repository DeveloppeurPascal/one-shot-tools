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
/// File last update : 2025-02-05T21:09:26.310+01:00
/// Signature : 87d5bf30f08d7b8ad480e2f93b422fb99dde12fe
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.IOUtils, System.types;

procedure TForm1.FormCreate(Sender: TObject);
var
  l: TStringDynArray;
  i: integer;
  Folder: string;
begin
  Folder := 'C:\Users\patrickpremartin\Documents\img';
  l := tdirectory.GetFiles(Folder);
  for i := 0 to length(l) - 1 do
    if TPath.GetFileName(l[i]).StartsWith('DALL') then
      tfile.Move(l[i], TPath.Combine(Folder, 'dall-e_' + i.tostring +
        TPath.GetExtension(l[i])));
end;

end.
