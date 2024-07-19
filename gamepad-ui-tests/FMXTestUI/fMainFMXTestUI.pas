unit fMainFMXTestUI;

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
  uJoystickManager,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  Gamolf.RTL.Joystick,
  FMX.Layouts;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GamepadManager1: TGamepadManager;
    Gamepad1: TGamepad;
    GridPanelLayout1: TGridPanelLayout;
    procedure GamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure GamepadManager1NewGamepadDetected(const GamepadID: Integer);
    procedure Gamepad1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure Gamepad1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ClickOnFocused;
    procedure GoLeft;
    procedure GoRight;
    procedure GoUp;
    procedure GoDown;
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
begin
  showmessage((Sender as TButton).text);
end;

procedure TForm3.ClickOnFocused;
// var
// key: word;
// keychar: char;
begin
  // key := 13;
  // keychar := #0;
  // KeyDown(key, keychar, []);
  if assigned(Focused) and (Focused is TControl) and
    assigned((Focused as TControl).OnClick) then
    (Focused as TControl).OnClick(Focused as TControl);
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  if true then
  begin
    Button1.SetFocus;

    for i := 0 to GridPanelLayout1.RowCollection.Count *
      GridPanelLayout1.ColumnCollection.Count - 1 do
      with TButton.create(self) do
      begin
        parent := GridPanelLayout1;
        align := talignlayout.Client;
        margins.Left := 5;
        margins.right := 5;
        margins.top := 5;
        margins.bottom := 5;
        text := 'Cell' + i.ToString;
        OnClick := Button1Click;
      end;
  end
  else
  begin
    for i := ComponentCount - 1 downto 0 do
      if components[i] is TControl then
        components[i].free;

    for i := 1 to 20 do
      with TButton.create(self) do
      begin
        parent := self;
        align := talignlayout.None;
        width := random(50) + 20;
        height := random(50) + 20;
        position.x := random(trunc(self.clientwidth - width));
        position.y := random(trunc(self.clientheight - height));
        text := i.ToString;
        OnClick := Button1Click;
        if not assigned(self.ActiveControl) then
          SetFocus;
      end;
  end;
end;

procedure TForm3.Gamepad1ButtonDown(const GamepadID: Integer;
  const Button: TJoystickButtons);
begin
  if Button = TJoystickButtons.a then
    // tthread.queue(nil,
    // procedure
    // begin
    ClickOnFocused;
  // end);
end;

procedure TForm3.Gamepad1DirectionPadChange(const GamepadID: Integer;
  const Value: TJoystickDPad);
begin
  case Value of
    TJoystickDPad.right:
      GoRight;
    TJoystickDPad.bottom:
      GoDown;
    TJoystickDPad.Left:
      GoLeft;
    TJoystickDPad.top:
      GoUp;
  end;
end;

procedure TForm3.GamepadManager1ButtonDown(const GamepadID: Integer;
  const Button: TJoystickButtons);
begin
  if Button = TJoystickButtons.B then
    tthread.queue(nil,
      procedure
      begin
        close;
      end);
end;

procedure TForm3.GamepadManager1NewGamepadDetected(const GamepadID: Integer);
begin
  if ((not Gamepad1.IsConnected) or (Gamepad1.id < 0)) then
    Gamepad1.id := GamepadID;;
end;

procedure TForm3.GoDown;
var
  Source, Target, c: TControl;
  SourceBounds, TargetBounds, CBounds: TRectF;
  i: Integer;
begin
  // if assigned(Focused) and (Focused is TControl) then
  if assigned(ActiveControl) then
  begin
    // Source := Focused as TControl;
    Source := ActiveControl;
    // SourceBounds := Source.LocalToAbsolute(Source.BoundsRect);
    SourceBounds := Source.LocalToAbsolute(rectf(0, 0, Source.width,
      Source.height));
    Target := nil;
    for i := 0 to ComponentCount - 1 do
      // if (Components[i] is TControl) then
      if (components[i] is TButton) then
      // TGridPanelLayout est dans les TControl
      begin
        c := components[i] as TControl;
        // CBounds := c.LocalToAbsolute(c.BoundsRect);
        CBounds := c.LocalToAbsolute(rectf(0, 0, c.width, c.height));
        if (CBounds.top > SourceBounds.top) and
          (CBounds.Left <= SourceBounds.right) and
          (CBounds.right >= SourceBounds.Left) then
          if not assigned(Target) then
          begin
            Target := c;
            TargetBounds := CBounds;
          end
          else if (TargetBounds.top > CBounds.top) then
          begin
            Target := c;
            TargetBounds := CBounds
          end;
      end;
    // TODO : si pas de target, chercher le premier élément en dessous (idéalement le plus proche), même s'il ne "touche" pas l'actuel
    if assigned(Target) then
      Target.SetFocus;
  end;
end;

procedure TForm3.GoLeft;
var
  Source, Target, c: TControl;
  SourceBounds, TargetBounds, CBounds: TRectF;
  i: Integer;
begin
  // if assigned(Focused) and (Focused is TControl) then
  if assigned(ActiveControl) then
  begin
    // Source := Focused as TControl;
    Source := ActiveControl;
    // SourceBounds := Source.LocalToAbsolute(Source.BoundsRect);
    SourceBounds := Source.LocalToAbsolute(rectf(0, 0, Source.width,
      Source.height));
    Target := nil;
    for i := 0 to ComponentCount - 1 do
      // if (Components[i] is TControl) then
      if (components[i] is TButton) then
      // TGridPanelLayout est dans les TControl
      begin
        c := components[i] as TControl;
        // CBounds := c.LocalToAbsolute(c.BoundsRect);
        CBounds := c.LocalToAbsolute(rectf(0, 0, c.width, c.height));
        if (CBounds.Left < SourceBounds.Left) and
          (CBounds.top <= SourceBounds.bottom) and
          (CBounds.bottom >= SourceBounds.top) then
          if not assigned(Target) then
          begin
            Target := c;
            TargetBounds := CBounds
          end
          else if (TargetBounds.Left < CBounds.Left) then
          begin
            Target := c;
            TargetBounds := CBounds
          end;
      end;
    // TODO : si pas de target, chercher le premier élément à gauche (idéalement le plus proche), même s'il ne "touche" pas l'actuel
    if assigned(Target) then
      Target.SetFocus;
  end;
end;

procedure TForm3.GoRight;
var
  Source, Target, c: TControl;
  SourceBounds, TargetBounds, CBounds: TRectF;
  i: Integer;
begin
  // if assigned(Focused) and (Focused is TControl) then
  if assigned(ActiveControl) then
  begin
    // Source := Focused as TControl;
    Source := ActiveControl;
    // SourceBounds := Source.LocalToAbsolute(Source.BoundsRect);
    SourceBounds := Source.LocalToAbsolute(rectf(0, 0, Source.width,
      Source.height));
    Target := nil;
    for i := 0 to ComponentCount - 1 do
      // if (Components[i] is TControl) then
      if (components[i] is TButton) then
      // TGridPanelLayout est dans les TControl
      begin
        c := components[i] as TControl;
        // CBounds := c.LocalToAbsolute(c.BoundsRect);
        CBounds := c.LocalToAbsolute(rectf(0, 0, c.width, c.height));
        if (CBounds.Left > SourceBounds.Left) and
          (CBounds.top <= SourceBounds.bottom) and
          (CBounds.bottom >= SourceBounds.top) then
          if not assigned(Target) then
          begin
            Target := c;
            TargetBounds := CBounds
          end
          else if (TargetBounds.Left > CBounds.Left) then
          begin
            Target := c;
            TargetBounds := CBounds
          end;
      end;
    // TODO : si pas de target, chercher le premier élément à droite (idéalement le plus proche), même s'il ne "touche" pas l'actuel
    if assigned(Target) then
      Target.SetFocus;
  end;
end;

procedure TForm3.GoUp;
var
  Source, Target, c: TControl;
  SourceBounds, TargetBounds, CBounds: TRectF;
  i: Integer;
begin
  // if assigned(Focused) and (Focused is TControl) then
  if assigned(ActiveControl) then
  begin
    // Source := Focused as TControl;
    Source := ActiveControl;
    // SourceBounds := Source.LocalToAbsolute(Source.BoundsRect);
    SourceBounds := Source.LocalToAbsolute(rectf(0, 0, Source.width,
      Source.height));
    Target := nil;
    for i := 0 to ComponentCount - 1 do
      // if (Components[i] is TControl) then
      if (components[i] is TButton) then
      // TGridPanelLayout est dans les TControl
      begin
        c := components[i] as TControl;
        // CBounds := c.LocalToAbsolute(c.BoundsRect);
        CBounds := c.LocalToAbsolute(rectf(0, 0, c.width, c.height));
        if (CBounds.top < SourceBounds.top) and
          (CBounds.Left <= SourceBounds.right) and
          (CBounds.right >= SourceBounds.Left) then
          if not assigned(Target) then
          begin
            Target := c;
            TargetBounds := CBounds
          end
          else if (TargetBounds.top < CBounds.top) then
          begin
            Target := c;
            TargetBounds := CBounds
          end;
      end;
    // TODO : si pas de target, chercher le premier élément au dessus (idéalement le plus proche), même s'il ne "touche" pas l'actuel
    if assigned(Target) then
      Target.SetFocus;
  end;
end;

end.
