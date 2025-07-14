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
  File last update : 2025-02-09T11:12:13.319+01:00
  Signature : 501d5bf1e2541cf38a8da2e786851c9bd53083b9
  ***************************************************************************
*)

unit Unit5;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    edtRootPath: TEdit;
    edtGroupProjName: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses
  System.Types,
  System.IOUtils;

procedure TForm5.Button1Click(Sender: TObject);
  procedure FindDProjIn(const Path: string; var DProjList: TStringList);
  var
    lst: TStringDynArray;
    i: integer;
  begin
    if tpath.GetFileName(Path).ToLower = 'lib-externes' then
      exit;
    lst := tdirectory.GetFiles(Path);
    for i := 0 to length(lst) - 1 do
      if lst[i].ToLower.EndsWith('.dproj') then
        DProjList.Add(lst[i]);
    lst := tdirectory.GetDirectories(Path);
    for i := 0 to length(lst) - 1 do
      if tdirectory.Exists(lst[i]) then
        FindDProjIn(lst[i], DProjList);
  end;

var
  DProjList: TStringList;
  i: integer;
begin
  DProjList := TStringList.Create;
  try
    Memo1.lines.Clear;
    if tdirectory.Exists(edtRootPath.Text) then
      FindDProjIn(edtRootPath.Text, DProjList);
    for i := 0 to DProjList.Count - 1 do
      Memo1.lines.Add(DProjList[i]);
  finally
    DProjList.free;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  GroupProj: TStringList;
  i: integer;
  Project: string;
  ProjectName: string;
  Targets, CleanTargets, MakeTargets: string;
  GroupProjFilename: string;
begin
  GroupProj := TStringList.Create;
  try
    GroupProj.Add
      ('<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">');
    GroupProj.Add('<PropertyGroup>');
    GroupProj.Add('<ProjectGuid>' + tguid.NewGuid.ToString + '</ProjectGuid>');
    GroupProj.Add('</PropertyGroup>');
    GroupProj.Add('<ItemGroup>');
    for i := 0 to Memo1.lines.Count - 1 do
    begin
      Project := Memo1.lines[i].trim;
      if (not Project.IsEmpty) and tfile.Exists(Project) then
      begin
        GroupProj.Add('<Projects Include="' + Project.Substring
          (length(edtRootPath.Text) + 1) + '">');
        GroupProj.Add('<Dependencies/>');
        GroupProj.Add('</Projects>');
      end;
    end;
    GroupProj.Add('</ItemGroup>');
    GroupProj.Add('<ProjectExtensions>');
    GroupProj.Add
      ('<Borland.Personality>Default.Personality.12</Borland.Personality>');
    GroupProj.Add('<Borland.ProjectType/>');
    GroupProj.Add('<BorlandProject>');
    GroupProj.Add('<Default.Personality/>');
    GroupProj.Add('</BorlandProject>');
    GroupProj.Add('</ProjectExtensions>');
    Targets := '';
    for i := 0 to Memo1.lines.Count - 1 do
    begin
      Project := Memo1.lines[i].trim;
      if (not Project.IsEmpty) and tfile.Exists(Project) then
      begin
        ProjectName := tpath.GetFileNameWithoutExtension(Project);
        // TODO : check if the name is already in targets list
        GroupProj.Add('<Target Name="' + ProjectName + '">');
        GroupProj.Add('<MSBuild Projects="' + Project.Substring
          (length(edtRootPath.Text) + 1) + '"/>');
        GroupProj.Add('</Target>');
        GroupProj.Add('<Target Name="' + ProjectName + ':Clean">');
        GroupProj.Add('<MSBuild Projects="' + Project.Substring
          (length(edtRootPath.Text) + 1) + '" Targets="Clean"/>');
        GroupProj.Add('</Target>');
        GroupProj.Add('<Target Name="' + ProjectName + ':Make">');
        GroupProj.Add('<MSBuild Projects="' + Project.Substring
          (length(edtRootPath.Text) + 1) + '" Targets="Make"/>');
        GroupProj.Add('</Target>');
        if Targets.IsEmpty then
        begin
          Targets := ProjectName;
          CleanTargets := ProjectName + ':Clean';
          MakeTargets := ProjectName + ':Make';
        end
        else
        begin
          Targets := Targets + ';' + ProjectName;
          CleanTargets := CleanTargets + ';' + ProjectName + ':Clean';
          MakeTargets := MakeTargets + ';' + ProjectName + ':Make';
        end;
      end;
    end;
    GroupProj.Add('<Target Name="Build">');
    GroupProj.Add('<CallTarget Targets="' + Targets + '"/>');
    GroupProj.Add('</Target>');
    GroupProj.Add('<Target Name="Clean">');
    GroupProj.Add('<CallTarget Targets="' + CleanTargets + '"/>');
    GroupProj.Add('</Target>');
    GroupProj.Add('<Target Name="Make">');
    GroupProj.Add('<CallTarget Targets="' + MakeTargets + '"/>');
    GroupProj.Add('</Target>');
    GroupProj.Add
      ('<Import Project="$(BDS)\Bin\CodeGear.Group.Targets" Condition="Exists(''$(BDS)\Bin\CodeGear.Group.Targets'')"/>');
    GroupProj.Add('</Project>');
    Memo1.lines.Add(GroupProj.Text);
    i := 1;
    GroupProjFilename := tpath.Combine(edtRootPath.Text, edtGroupProjName.Text +
      '.groupproj');
    repeat
      if tfile.Exists(GroupProjFilename) then
      begin
        GroupProjFilename := tpath.Combine(edtRootPath.Text,
          edtGroupProjName.Text + i.ToString + '.groupproj');
        inc(i);
      end
      else
      begin
        GroupProj.SaveToFile(GroupProjFilename);
        break;
      end;
    until false;
  finally
    GroupProj.free;
  end;
end;

end.
