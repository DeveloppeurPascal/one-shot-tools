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
  File last update : 2025-07-14T09:18:14.225+02:00
  Signature : aa2ecc78964e809ae3dd69dd4599299f6e560425
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
  FMX.Memo.Types,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Layouts,
  FMX.StdCtrls,
  Xml.xmldom,
  Xml.XMLIntf,
  Xml.XMLDoc;

type
  TForm1 = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    XMLDocument1: TXMLDocument;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure AfficheInfos(Const FileName: string);
    procedure ListerFichiers(Const FileName: string; Const Plateforme: string;
      Const DeploymentNode: IXMLNode);
    procedure log(Text: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  Win.Registry,
  System.IOUtils,
  Olf.RTL.PathAliases,
  Olf.RTL.DPROJReader;

procedure TForm1.AfficheInfos(Const FileName: string);
var
  Node, ProjectNode, ProjectExtensionsNode, BorlandProjectNode, PlatformsNode,
    DeploymentNode, DeployFileNode: IXMLNode;
  i: integer;
  Win32, Win64: boolean;
  ExeWin32, ExeWin64: string;
  AliasList: TKeyValueList;
begin
  AliasList := TKeyValueList.create;
  try
    if tpath.IsRelativePath(tpath.GetDirectoryName(FileName)) then
      AliasList.Add('PROJECTDIR',
        tpath.GetFullPath(tpath.GetDirectoryName(FileName)))
    else
      AliasList.Add('PROJECTDIR', tpath.GetDirectoryName(FileName));

    log('******************');
    log('* ' + tpath.getfilename(FileName));
    log('******************');
    log('');
    XMLDocument1.LoadFromFile(FileName);

    // showmessage(XMLDocument1.Node.NodeName);
    // log(XMLDocument1.Xml.Text);
    ProjectNode := XMLDocument1.ChildNodes.FindNode('Project');
    if assigned(ProjectNode) then
    begin
      if ProjectNode.HasAttribute('xmlns') then
        log(ProjectNode.Attributes['xmlns'])
      else
        log('Project doesn''t have XMLNS attribute.');
      ProjectExtensionsNode := ProjectNode.ChildNodes.FindNode
        ('ProjectExtensions');
      if assigned(ProjectExtensionsNode) then
      begin
        BorlandProjectNode := ProjectExtensionsNode.ChildNodes.FindNode
          ('BorlandProject');
        if assigned(BorlandProjectNode) then
        begin

          // Plateformes actives : Win32, Win64 ou les deux ?
          PlatformsNode := BorlandProjectNode.ChildNodes.FindNode('Platforms');
          if assigned(PlatformsNode) then
          begin
            Win32 := false;
            Win64 := false;
            for i := 0 to PlatformsNode.ChildNodes.Count - 1 do
            begin
              Node := PlatformsNode.ChildNodes[i];
              if Node.HasAttribute('value') and
                (Node.Attributes['value'] = 'Win32') then
                Win32 := Node.NodeValue;
              if Node.HasAttribute('value') and
                (Node.Attributes['value'] = 'Win64') then
                Win64 := Node.NodeValue;
            end;
            log('Platform Win32 : ' + Win32.ToString);
            log('Platform Win64 : ' + Win64.ToString);
          end
          else
            log('No Platforms');

          // Quel est le programme principal et où est-il ? (exe Win32/Win64)
          DeploymentNode := BorlandProjectNode.ChildNodes.FindNode
            ('Deployment');
          if assigned(DeploymentNode) and DeploymentNode.HasAttribute('Version')
            and (DeploymentNode.Attributes['Version'] = 4) then
          // TODO : prendre en charge autres versions du déploiement en XE (bof, mais why not) et 10.x
          begin
            ExeWin32 := '';
            ExeWin64 := '';
            for i := 0 to DeploymentNode.ChildNodes.Count - 1 do
            begin
              DeployFileNode := DeploymentNode.ChildNodes[i];
              if (DeployFileNode.NodeName = 'DeployFile') and
                DeployFileNode.HasAttribute('Configuration') and
                (DeployFileNode.Attributes['Configuration'] = 'Release') and
                DeployFileNode.HasAttribute('Class') and
                (DeployFileNode.Attributes['Class'] = 'ProjectOutput') and
                DeployFileNode.HasAttribute('LocalName') then
              begin
                Node := DeployFileNode.ChildNodes.FindNode('Platform');
                if assigned(Node) and Node.HasAttribute('Name') then
                  if (Node.Attributes['Name'] = 'Win32') then
                  begin
                    AliasList.AddOrSetValue('Platform',
                      Node.Attributes['Name']);
                    AliasList.AddOrSetValue('Configuration',
                      DeployFileNode.Attributes['Configuration']);
                    ExeWin32 := ReplaceAliasesInPath
                      (DeployFileNode.Attributes['LocalName'], AliasList,
                      false, '23.0',
                      function(const AAlias: string): string
                      begin
                        if AAlias = 'SKIADIR' then
                          result := 'c:\temp'
                        else
                          result := '';
                      end);
                  end
                  else if Node.Attributes['Name'] = 'Win64' then
                  begin
                    AliasList.AddOrSetValue('Platform',
                      Node.Attributes['Name']);
                    AliasList.AddOrSetValue('Configuration',
                      DeployFileNode.Attributes['Configuration']);
                    ExeWin64 := ReplaceAliasesInPath
                      (DeployFileNode.Attributes['LocalName'], AliasList,
                      false, '23.0',
                      function(const AAlias: string): string
                      begin
                        if AAlias = 'SKIADIR' then
                          result := 'c:\temp'
                        else
                          result := '';
                      end);
                  end;
                if (not ExeWin32.IsEmpty) and (not ExeWin64.IsEmpty) then
                  break;
              end;
            end;
            if ExeWin32.IsEmpty then
              log('No Win32 executable.')
            else
              log('Win32 Executable : ' + ExeWin32);
            if ExeWin64.IsEmpty then
              log('No Win64 executable.')
            else
              log('Win64 Executable : ' + ExeWin64);
          end
          else
            log('No Deployment');

          // Quels fichier pour Win32, puis pour Win64 ?
          DeploymentNode := BorlandProjectNode.ChildNodes.FindNode
            ('Deployment');
          if assigned(DeploymentNode) and DeploymentNode.HasAttribute('Version')
            and (DeploymentNode.Attributes['Version'] = 4) then
          // TODO : prendre en charge autres versions du déploiement en XE (bof, mais why not) et 10.x
          begin
            if Win32 then
              ListerFichiers(FileName, 'Win32', DeploymentNode);
            if Win64 then
              ListerFichiers(FileName, 'Win64', DeploymentNode);
          end
          else
            log('No Deployment');
        end
        else
          log('No BorlandProject');
      end
      else
        log('No ProjectExtensions');
    end
    else
      log('No Project');

    log('');
    log('');
    log('');

  finally
    AliasList.free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  AfficheInfos
    ('C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\ebs\src\ExeBulkSigning.dproj');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AfficheInfos
    ('C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\Sporgloo\src-game\Sporgloo.dproj');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  AfficheInfos
    ('C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\Sporgloo\src-server\SporglooServer.dproj');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AfficheInfos('..\..\DisplayDPROJContent.dproj');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  DPROJReader: TOlfDPROJReader;

  procedure ShowInfos(const APlatform: string;
  const AConfiguration: string = 'Release');
  var
    ProgramFilePath: string;
    DeployFileList: TOlfFilesToDeployList;
    i: integer;
  begin
    log(APlatform + ' OK');
    ProgramFilePath := DPROJReader.GetProjectExecutable(APlatform,
      AConfiguration);
    if ProgramFilePath.IsEmpty then
      log('No program for "' + AConfiguration + '" configuration.')
    else
    begin
      log('Program (' + AConfiguration + ') : ' + ProgramFilePath);
      DPROJReader.BDSVersion := '23.0';
      DPROJReader.onGetPathForAliasFunc :=
          function(Const AAlias: string): string
        begin
          if AAlias = 'SKIADIR' then
            result := 'c:\temp'
          else
            result := '';
        end;
      DeployFileList := DPROJReader.GetFilesToDeploy(APlatform, AConfiguration);
      try
        for i := 0 to DeployFileList.Count - 1 do
        begin
          log('- File : ' + DeployFileList[i].FromFileName);
          log('=> from folder : ' + DeployFileList[i].FromPath);
          log('=> to folder : ' + DeployFileList[i].toPath);
          log('=> as : ' + DeployFileList[i].ToFileName);
          log('=> overwrite : ' + DeployFileList[i].Overwrite.ToString);
        end;
      finally
        DeployFileList.free;
      end;
    end;
  end;

begin
  if OpenDialog1.Execute and tfile.Exists(OpenDialog1.FileName) and
    (tpath.GetExtension(OpenDialog1.FileName).tolower = '.dproj') then
  begin
    Memo1.lines.Clear;
    DPROJReader := TOlfDPROJReader.create(OpenDialog1.FileName);
    try
      if DPROJReader.HasPlatform('Win32') then
        ShowInfos('Win32')
      else
        log('No Win32');
      if DPROJReader.HasPlatform('Win64') then
        ShowInfos('Win64')
      else
        log('No Win64');
      if DPROJReader.HasPlatform('WinARM') then
        ShowInfos('WinARM')
      else
        log('No WinARM');
      if DPROJReader.HasPlatform('Linux64') then
        ShowInfos('Linux64')
      else
        log('No Linux64');
    finally
      DPROJReader.free;
    end;
  end;
end;

procedure TForm1.ListerFichiers(Const FileName: string;
const Plateforme: string; const DeploymentNode: IXMLNode);
var
  Node, DeployFileNode, PlatformNode: IXMLNode;
  i, j: integer;
  FilePath: string;
  AliasList: TKeyValueList;
begin
  AliasList := TKeyValueList.create;
  try
    if tpath.IsRelativePath(tpath.GetDirectoryName(FileName)) then
      AliasList.Add('PROJECTDIR',
        tpath.GetFullPath(tpath.GetDirectoryName(FileName)))
    else
      AliasList.Add('PROJECTDIR', tpath.GetDirectoryName(FileName));

    log('');
    log('**********');
    log('* Liste des fichiers à déployer pour ' + Plateforme);
    log('**********');
    log('');
    for i := 0 to DeploymentNode.ChildNodes.Count - 1 do
    begin
      DeployFileNode := DeploymentNode.ChildNodes[i];
      if (DeployFileNode.NodeName = 'DeployFile') and
        DeployFileNode.HasAttribute('Configuration') and
        (DeployFileNode.Attributes['Configuration'] = 'Release') and
        DeployFileNode.HasAttribute('LocalName') then
      begin
        PlatformNode := nil;
        for j := 0 to DeployFileNode.ChildNodes.Count - 1 do
        begin
          Node := DeployFileNode.ChildNodes[j];
          if (Node.NodeName = 'Platform') and Node.HasAttribute('Name') and
            (Node.Attributes['Name'] = Plateforme) then
          begin
            PlatformNode := Node;
            AliasList.AddOrSetValue('Platform', Node.Attributes['Name']);
            AliasList.AddOrSetValue('Configuration',
              DeployFileNode.Attributes['Configuration']);
            break;
          end;
        end;
        if assigned(PlatformNode) then
        begin
          log('From : ' + DeployFileNode.Attributes['LocalName']);

          log(ReplaceAliasesInPath(DeployFileNode.Attributes['LocalName'],
            AliasList, false, '23.0',
            function(const AAlias: string): string
            begin
              if AAlias = 'SKIADIR' then
                result := 'c:\temp'
              else
                result := '';
            end));

          Node := PlatformNode.ChildNodes.FindNode('RemoteDir');
          if assigned(Node) and (Node.NodeValue <> '.\') then
            log('To : ' + Node.NodeValue)
          else
            log('To : ');
          Node := PlatformNode.ChildNodes.FindNode('RemoteName');
          if assigned(Node) then
            log('As : ' + Node.NodeValue)
          else
            log('As : ' + tpath.getfilename(DeployFileNode.Attributes
              ['LocalName']));
          Node := PlatformNode.ChildNodes.FindNode('Overwrite');
          if assigned(Node) then
            log('Avec écrasement')
          else
            log('Copie si absent');
          log('');
        end;
      end;
    end;

  finally
    AliasList.free;
  end;
end;

procedure TForm1.log(Text: string);
begin
  Memo1.lines.Add(Text);
end;

initialization

ReportMemoryLeaksOnShutdown := true;

end.
