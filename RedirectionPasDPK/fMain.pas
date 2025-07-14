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
  File last update : 2025-02-09T11:12:13.326+01:00
  Signature : e28a7bf247964eaf79ce23a799cf34ef6c35fffe
  ***************************************************************************
*)

unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

const
  /// <summary>
  /// Folder containing files to erase and deprecate.
  /// </summary>
  FromFolder =
    'C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\librairies';
  /// <summary>
  /// Folder where the new files has been copied (before using this program)
  /// </summary>
  ToFolder =
    'C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\librairies\src';
  /// <summary>
  /// Relative path between FromFolder and ToFolder (used with $i directive)
  /// </summary>
  /// <remarks>
  /// Don't forget the final "\", the file name will just be added to this const.
  /// </remarks>
  RelPath = 'src\';

type
  TfrmMain = class(TForm)
    btnEraseFromFolderFiles: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnEraseFromFolderFilesClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  System.IOUtils;

procedure TfrmMain.btnEraseFromFolderFilesClick(Sender: TObject);
var
  Files: TArray<string>;
  i: integer;
  Ext: string;
  FileName: string;
  nb: integer;
  DeletionDate: TDateTime;
  DeletionDateStr: string;
begin
  DeletionDate := TDateTime.Today;
  DeletionDate.AddYear(1);
  DeletionDateStr := formatdatetime('yyyy-mm-dd', DeletionDate);
  nb := 0;
  Files := tdirectory.GetFiles(FromFolder);
  for i := 0 to length(Files) - 1 do
  begin
    Ext := tpath.GetExtension(Files[i]).ToLower;
    FileName := tpath.GetFileName(Files[i]);
    if (Ext = '.pas') or (Ext = '.dpk') or (Ext = '.dpr') then
    begin
      // PAS => unit
      // DPK => Delphi package
      // DPR => Delphi program
      tfile.WriteAllText(Files[i], '{$I ''' + RelPath + FileName + '''}' +
        slinebreak +
        '{$message warn ''This file is deprecated. It will be deleted after the '
        + DeletionDateStr + '. Use "' + RelPath + FileName +
        '" instead of it.''}');
      inc(nb);
    end;
  end;
  ShowMessage('Fichier(s) modifié(s) : ' + nb.tostring);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'From folder : ' + FromFolder;
  Label2.Caption := 'To folder : ' + ToFolder;
  Label3.Caption := 'Rel path (used in redirection) : ' + RelPath;
end;

end.
