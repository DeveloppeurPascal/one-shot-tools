unit fMainUIItemsList;

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
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  uJoystickManager,
  uUIElements, Gamolf.RTL.Joystick;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    GamepadManager1: TGamepadManager;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure GamepadManager1NewGamepadDetected(const GamepadID: Integer);
    procedure GamepadManager1GamepadLost(const GamepadID: Integer);
    procedure GamepadManager1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure GamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    UIItems: TUIItemsList;
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.Button1Click(Sender: TObject);
begin
  showmessage((Sender as TButton).text);
end;

procedure TForm4.FormCreate(Sender: TObject);
  procedure AddItem(const Control: TControl);
  var
    LItem: TControl;
    UIItem: TUIItem;
  begin
    LItem := Control;
    UIItem := UIItems.AddUIItem(LItem.LocalToAbsolute(trectf.create(0, 0,
      LItem.Width, LItem.Height)),
      procedure(const Sender: TObject)
      begin
        // showmessage(LItem.ClassName + ' ' + LItem.name);
        if assigned(LItem.OnClick) then
          LItem.OnClick(LItem);
      end);
    UIItem.tagobject := LItem;
    UIItem.OnPaintProc := procedure(const Sender: TObject)
      var
        item: TUIItem;
      begin
        if (Sender is TUIItem) then
        begin
          item := Sender as TUIItem;
          if assigned(item.tagobject) then
          begin
            if item.IsFocused then
            begin
              if item.tagobject is tshape then
                (item.tagobject as tshape).Stroke.dash := tstrokedash.DashDotdot
              else if (item.tagobject is TControl) then
                (item.tagobject as TControl).SetFocus;
            end
            else if item.tagobject is tshape then
              (item.tagobject as tshape).Stroke.dash := tstrokedash.Solid
            else if (item.tagobject is TControl) then
              (item.tagobject as TControl).resetFocus;
          end;
        end;
      end;
  end;

var
  i: Integer;
  item: TUIItem;
begin
  Label1.Visible := false;

  UIItems := TUIItemsList.create;

  for i := 0 to ComponentCount - 1 do
    if (components[i] is TButton) or (components[i] is TRectangle) then
      AddItem(components[i] as TControl);

  item := UIItems.GetElementByTagObject(Button1);
  item.BottomItem := UIItems.GetElementByTagObject(Rectangle2);
  item.rightItem := UIItems.GetElementByTagObject(Rectangle3);
  item.GamePadButtons := [TJoystickButtons.x];
  item.KeyShortcuts.Add(0, 'x', []);

  item := UIItems.GetElementByTagObject(Button2);
  item.leftItem := UIItems.GetElementByTagObject(Rectangle3);
  item.BottomItem := UIItems.GetElementByTagObject(Rectangle1);
  item.GamePadButtons := [TJoystickButtons.y];
  item.KeyShortcuts.Add(0, 'y', []);

  item := UIItems.GetElementByTagObject(Button3);
  item.leftItem := UIItems.GetElementByTagObject(Rectangle2);
  item.rightItem := UIItems.GetElementByTagObject(Rectangle1);
  item.topItem := UIItems.GetElementByTagObject(Rectangle3);
  item.GamePadButtons := [TJoystickButtons.Menu];
  item.KeyShortcuts.Add(vkhome, #0, []);

  UIItems.GetElementByTagObject(Button2).SetFocus;

  // TODO : r�percuter les changements de focus des �l�ments d'interface vers les �l�ments de la liste
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
  UIItems.free;
end;

procedure TForm4.FormKeyDown(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
var
  item: TUIItem;
begin
  UIItems.KeyDown(Key, KeyChar, Shift);
  if (Key = vkEscape) or (Key = vkHardwareBack) then
  begin
    // Traiter le CANCEL ou retour � l'�cran pr�c�dent
    Close;
  end
  else if (Key = vkReturn) then
  begin
    item := UIItems.Focused;
    if assigned(item) then
      item.DoClick
    else
    begin
      // traiter le RETURN
    end;
  end
  else if (Key = 0) and (KeyChar = ' ') then
  begin
    item := UIItems.Focused;
    if assigned(item) then
      item.DoClick
    else
    begin
      // traiter la touche ESPACE
    end;
  end;
end;

procedure TForm4.GamepadManager1ButtonDown(const GamepadID: Integer;
const Button: TJoystickButtons);
var
  handled: boolean;
  item: TUIItem;
begin
  UIItems.GamepadButtonDown(Button, handled);
  if not handled then
    if (Button = TJoystickButtons.a) then
    begin
      item := UIItems.Focused;
      if assigned(item) then
        item.DoClick
      else
      begin
        // traiter le RETURN ou �quivalent
      end;
    end
    else if (Button = TJoystickButtons.b) then
    begin
      Close; // fermeture du programme
      // faire le CANCEL ou �quivalent de ESC
    end
    else
    begin
      // fait un truc sur le bouton qui n'a pas �t� intercept�
    end;
end;

procedure TForm4.GamepadManager1DirectionPadChange(const GamepadID: Integer;
const Value: TJoystickDPad);
begin
  if not UIItems.GamepadMove(Value) then
  begin
    // Prendre en charge le mouvement car non trait� par la librairie UI
  end;
end;

procedure TForm4.GamepadManager1GamepadLost(const GamepadID: Integer);
begin
  Label1.Visible := GamepadManager1.ConnectedGamepadCount > 0;
end;

procedure TForm4.GamepadManager1NewGamepadDetected(const GamepadID: Integer);
begin
  Label1.Visible := GamepadManager1.ConnectedGamepadCount > 0;
end;

procedure TForm4.Rectangle3Click(Sender: TObject);
begin
  showmessage((Sender as tcomponent).name);
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}

end.