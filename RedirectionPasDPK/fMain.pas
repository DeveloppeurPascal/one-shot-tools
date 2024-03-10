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
    { D�clarations priv�es }
  public
    { D�clarations publiques }
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
  ShowMessage('Fichier(s) modifi�(s) : ' + nb.tostring);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'From folder : ' + FromFolder;
  Label2.Caption := 'To folder : ' + ToFolder;
  Label3.Caption := 'Rel path (used in redirection) : ' + RelPath;
end;

end.
