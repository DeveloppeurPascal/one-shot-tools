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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  System.IOUtils;

procedure TForm1.AfficheInfos(Const FileName: string);
var
  Node, ProjectNode, ProjectExtensionsNode, BorlandProjectNode, PlatformsNode,
    DeploymentNode, DeployFileNode: IXMLNode;
  i: integer;
  Win32, Win64: boolean;
  ExeWin32, ExeWin64: string;
begin
  log('******************');
  log('* ' + tpath.getfilename(FileName));
  log('******************');
  log('');
  XMLDocument1.LoadFromFile(FileName);

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
        DeploymentNode := BorlandProjectNode.ChildNodes.FindNode('Deployment');
        if assigned(DeploymentNode) then
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
                  ExeWin32 := DeployFileNode.Attributes['LocalName']
                else if Node.Attributes['Name'] = 'Win64' then
                  ExeWin64 := DeployFileNode.Attributes['LocalName'];
              if (not ExeWin32.IsEmpty) and (not ExeWin64.IsEmpty) then
                break;
            end;
          end;
          if ExeWin32.IsEmpty then
            log('No Win32 executable.')
          else if tpath.IsRelativePath(ExeWin32) then
          begin
            ExeWin32 := tpath.Combine(tpath.GetDirectoryName(FileName),
              ExeWin32);
            log('Win32 Executable : ' + ExeWin32);
          end;
          if ExeWin64.IsEmpty then
            log('No Win64 executable.')
          else if tpath.IsRelativePath(ExeWin64) then
          begin
            ExeWin64 := tpath.Combine(tpath.GetDirectoryName(FileName),
              ExeWin64);
            log('Win64 Executable : ' + ExeWin64);
          end;
        end
        else
          log('No Deployment');

        // Quels fichier pour Win32, puis pour Win64 ?
        DeploymentNode := BorlandProjectNode.ChildNodes.FindNode('Deployment');
        if assigned(DeploymentNode) then
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

procedure TForm1.ListerFichiers(Const FileName: string;
  const Plateforme: string; const DeploymentNode: IXMLNode);
var
  Node, DeployFileNode, PlatformNode: IXMLNode;
  i, j: integer;
  FilePath: string;
begin
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
          break;
        end;
      end;
      if assigned(PlatformNode) then
      begin
        log('From : ' + DeployFileNode.Attributes['LocalName']);

        FilePath := DeployFileNode.Attributes['LocalName'];
        if tpath.IsRelativePath(FilePath) then
          log(tpath.Combine(tpath.GetDirectoryName(FileName), FilePath));

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
end;

procedure TForm1.log(Text: string);
begin
  Memo1.lines.add(Text);
end;

end.
