unit uUIElements;

interface

uses
  System.Classes,
  System.Types,
  System.SysUtils,
  System.Generics.Collections,
  Gamolf.RTL.Joystick;

type
  TNotifyProc = reference to procedure(const Sender: TObject);

  TJoystickButtonsSet = set of TJoystickButtons;
  // TODO : à mettre sur Gamolf.RTL.Joystick

{$IF Defined(FRAMEWORK_FMX)}
  TUIItemBounds = TRectF;
{$ELSE IF Defined(FRAMEWORK_VCL)}
  TUIItemBounds = TRect;
{$ELSE}

  TUIItemBounds = record
    Left, Top, Right, Bottom: integer;
  end;
{$ENDIF}

  TUIItemsList = class;

  TUIKeyShortCut = class(TInterfacedObject)
  protected
  private
    FKey: Word;
    FShift: TShiftState;
    FKeyChar: WideChar;
    procedure SetKey(const Value: Word);
    procedure SetKeyChar(const Value: WideChar);
    procedure SetShift(const Value: TShiftState);
  public
    property Key: Word read FKey write SetKey;
    property KeyChar: WideChar read FKeyChar write SetKeyChar;
    property Shift: TShiftState read FShift write SetShift;
    // TODO : pouvoir gérer un texte associé à chaque raccourci (permettant de les lister depuis le layout en cours dans la liste des zones afin de les proposer à l'écran)
  end;

  TUIKeyShortCutList = class(TInterfacedObject)
  private
    FList: TObjectList<TUIKeyShortCut>;
  protected
  public
    procedure Add(const Key: Word; const KeyChar: WideChar;
      const Shift: TShiftState); virtual;
    procedure Remove(const Key: Word; const KeyChar: WideChar;
      const Shift: TShiftState); virtual;
    function Exists(const Key: Word; const KeyChar: WideChar;
      const Shift: TShiftState): boolean; virtual;
    constructor Create;
    destructor Destroy; override;
  end;

  TUIItem = class(TInterfacedObject)
  private
    FOwner: TUIItemsList;
    FLayoutIndex: integer;
    FIsFocused: boolean;
    FBottomItem: TUIItem;
    FTopItem: TUIItem;
    FLeftItem: TUIItem;
    FRightItem: TUIItem;
    FGamePadButtons: TJoystickButtonsSet;
    FOnClickProc: TNotifyProc;
    FBounds: TUIItemBounds;
    FOnClick: TNotifyEvent;
    FKeyShortcuts: TUIKeyShortCutList;
    FTagBool: boolean;
    FTagFloat: single;
    FTagString: string;
    FTagObject: TObject;
    FTag: integer;
    FOnPaintProc: TNotifyProc;
    FOnPaint: TNotifyEvent;
    procedure SetBottomItem(const Value: TUIItem);
    procedure SetGamePadButtons(const Value: TJoystickButtonsSet);
    procedure SetLeftItem(const Value: TUIItem);
    procedure SetOnClick(const Value: TNotifyEvent);
    procedure SetOnClickProc(const Value: TNotifyProc);
    procedure SetBounds(const Value: TUIItemBounds);
    procedure SetRightItem(const Value: TUIItem);
    procedure SetTopItem(const Value: TUIItem);
    procedure SetTag(const Value: integer);
    procedure SetTagBool(const Value: boolean);
    procedure SetTagFloat(const Value: single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
    procedure SetIsFocused(const Value: boolean);
    procedure SetOnPaint(const Value: TNotifyEvent);
    procedure SetOnPaintProc(const Value: TNotifyProc);
  protected
    procedure Paint(const AIsFocused: boolean); virtual;
    constructor Create(const AOwner: TUIItemsList); overload;
    constructor Create(const AOwner: TUIItemsList;
      const AOnClickProc: TNotifyProc); overload;
    constructor Create(const AOwner: TUIItemsList;
      const AOnClick: TNotifyEvent); overload;
    constructor Create(const AOwner: TUIItemsList; const ABounds: TUIItemBounds;
      const AOnClickProc: TNotifyProc = nil); overload;
    constructor Create(const AOwner: TUIItemsList; const ABounds: TUIItemBounds;
      const AOnClick: TNotifyEvent); overload;
  public
    property Bounds: TUIItemBounds read FBounds write SetBounds;
    property RightItem: TUIItem read FRightItem write SetRightItem;
    property BottomItem: TUIItem read FBottomItem write SetBottomItem;
    property LeftItem: TUIItem read FLeftItem write SetLeftItem;
    property TopItem: TUIItem read FTopItem write SetTopItem;
    property IsFocused: boolean read FIsFocused write SetIsFocused;
    property GamePadButtons: TJoystickButtonsSet read FGamePadButtons
      write SetGamePadButtons;
    // TODO : pouvoir gérer un texte associé à chaque bouton (permettant de les lister depuis le layout en cours dans la liste des zones afin de les proposer à l'écran)
    property KeyShortcuts: TUIKeyShortCutList read FKeyShortcuts;
    property OnClick: TNotifyEvent read FOnClick write SetOnClick;
    property OnClickProc: TNotifyProc read FOnClickProc write SetOnClickProc;
    property OnPaint: TNotifyEvent read FOnPaint write SetOnPaint;
    property OnPaintProc: TNotifyProc read FOnPaintProc write SetOnPaintProc;
    property Tag: integer read FTag write SetTag;
    property TagBool: boolean read FTagBool write SetTagBool;
    property TagFloat: single read FTagFloat write SetTagFloat;
    property TagObject: TObject read FTagObject write SetTagObject;
    property TagString: string read FTagString write SetTagString;
    procedure DoClick; virtual;
    procedure DoPaint; virtual;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar;
      const Shift: TShiftState); virtual;
    /// <remarks>
    /// If Handled is True, the button won't be propagated to the gamepad devices and components
    /// </remarks>
    procedure GamepadButtonDown(const Button: TJoystickButtons;
      var Handled: boolean); virtual;
    procedure SetFocus;
    destructor Destroy; override;
  end;

  // TODO : fournir une info indiquant si on a des éléments sur le niveau en cours (avec un cache pour ne pas le recalculer à chaque fois)
  // => calculer le nombre d'éléments disponibles quand on change de niveau
  // => faire un + ou - selon les ajouts/suppressions d'éléments au niveau en cours
  // => ajouter une fonction "hasUIItems()" qui travaille par rapport au nombre d'éléments sur le niveau de layout en cours
  // TODO : ajouter GoToNext / GoToPrevious et la gestion de TAB et Shift+TAB plus un TabOrder sur les éléments du niveau courant (par défaut leur ordre d'ajout à la liste)
  TUIItemsList = class(TInterfacedObject)
  private
    FList: TList<TUIItem>;
    FLayoutIndex: integer;
  protected
    procedure RemoveItem(const AItem: TUIItem);
    procedure ExtractItem(const AItem: TUIItem);
  public
    procedure NewLayout;
    procedure RemoveLayout;
    function Focused: TUIItem;
    constructor Create;
    destructor Destroy; override;
    function AddUIItem(const ABounds: TUIItemBounds;
      const AOnClickProc: TNotifyProc = nil): TUIItem; overload; virtual;
    function AddUIItem(const ABounds: TUIItemBounds;
      const AOnClick: TNotifyEvent): TUIItem; overload; virtual;
    function AddUIItem(const AOnClickProc: TNotifyProc = nil): TUIItem;
      overload; virtual;
    function AddUIItem(const AOnClick: TNotifyEvent): TUIItem;
      overload; virtual;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar;
      const Shift: TShiftState); virtual;
    /// <remarks>
    /// If Handled is True, the button won't be propagated to the gamepad devices and components
    /// </remarks>
    procedure GamepadButtonDown(const Button: TJoystickButtons;
      var Handled: boolean); virtual;
    function GetElementByTagObject(const ATagObject: TObject): TUIItem;
    function GoToRight: boolean;
    function GoToDown: boolean;
    function GoToLeft: boolean;
    function GoToUp: boolean;
    function GamepadMove(const DirectionPad: TJoystickDPad): boolean;
  end;

implementation

uses
{$IF Defined(FRAMEWORK_FMX)}
  FMX.Controls,
{$ELSE IF Defined(FRAMEWORK_VCL)}
{$ENDIF}
  System.UITypes;
{ TUIItem }

constructor TUIItem.Create(const AOwner: TUIItemsList);
begin
  inherited Create;
  FOwner := AOwner;
  FLayoutIndex := -1;
  FIsFocused := false;
  FBottomItem := nil;
  FTopItem := nil;
  FLeftItem := nil;
  FRightItem := nil;
  FGamePadButtons := [];
  FOnClickProc := nil;
  FBounds.Create(0, 0, 0, 0);
  FOnClick := nil;
  FKeyShortcuts := TUIKeyShortCutList.Create;
  FTag := 0;
  FTagBool := false;
  FTagFloat := 0;
  FTagObject := nil;
  FTagString := '';
end;

constructor TUIItem.Create(const AOwner: TUIItemsList;
  const ABounds: TUIItemBounds; const AOnClickProc: TNotifyProc);
begin
  Create(AOwner);
  FBounds.Create(ABounds, true);
  OnClickProc := AOnClickProc;
end;

constructor TUIItem.Create(const AOwner: TUIItemsList;
  const ABounds: TUIItemBounds; const AOnClick: TNotifyEvent);
begin
  Create(AOwner);
  FBounds.Create(ABounds, true);
  OnClick := AOnClick;
end;

constructor TUIItem.Create(const AOwner: TUIItemsList;
  const AOnClick: TNotifyEvent);
begin
  Create(AOwner);
  OnClick := AOnClick;
end;

constructor TUIItem.Create(const AOwner: TUIItemsList;
  const AOnClickProc: TNotifyProc);
begin
  Create(AOwner);
  OnClickProc := AOnClickProc;
end;

destructor TUIItem.Destroy;
begin
  if assigned(FOwner) then
    FOwner.ExtractItem(self);

  RightItem := nil;
  BottomItem := nil;
  LeftItem := nil;
  TopItem := nil;

  FKeyShortcuts.free;
  inherited;
end;

procedure TUIItem.DoClick;
begin
  if assigned(OnClick) then
    OnClick(self);
  if assigned(OnClickProc) then
    OnClickProc(self);
end;

procedure TUIItem.DoPaint;
begin
  Paint(FIsFocused);
  if assigned(OnPaint) then
    OnPaint(self);
  if assigned(OnPaintProc) then
    OnPaintProc(self);
end;

procedure TUIItem.GamepadButtonDown(const Button: TJoystickButtons;
  var Handled: boolean);
begin
  if Button in GamePadButtons then
  begin
    Handled := true;
    DoClick;
  end;
end;

procedure TUIItem.KeyDown(var Key: Word; var KeyChar: WideChar;
  const Shift: TShiftState);
begin
  if FKeyShortcuts.Exists(Key, KeyChar, Shift) then
  begin
    Key := 0;
    KeyChar := #0;
    DoClick;
  end;
end;

procedure TUIItem.Paint(const AIsFocused: boolean);
begin
  // à remplir sur les descendants
end;

procedure TUIItem.SetBottomItem(const Value: TUIItem);
var
  OldLink: TUIItem;
begin
  if FBottomItem = Value then
    exit;

  OldLink := FBottomItem;
  FBottomItem := Value;

  if assigned(OldLink) then
    OldLink.TopItem := nil;

  if assigned(FBottomItem) then
    FBottomItem.TopItem := self;
end;

procedure TUIItem.SetGamePadButtons(const Value: TJoystickButtonsSet);
begin
  FGamePadButtons := Value;
end;

procedure TUIItem.SetIsFocused(const Value: boolean);
var
  item: TUIItem;
begin
  if (FIsFocused = Value) then
    exit;

  if assigned(FOwner) then
  begin
    item := FOwner.Focused;
    if assigned(item) and (item <> self) then
      item.IsFocused := false;
  end;

  FIsFocused := Value;
  DoPaint;
end;

procedure TUIItem.SetLeftItem(const Value: TUIItem);
var
  OldLink: TUIItem;
begin
  if FLeftItem = Value then
    exit;

  OldLink := FLeftItem;
  FLeftItem := Value;

  if assigned(OldLink) then
    OldLink.RightItem := nil;

  if assigned(FLeftItem) then
    FLeftItem.RightItem := self;
end;

procedure TUIItem.SetOnClick(const Value: TNotifyEvent);
begin
  FOnClick := Value;
end;

procedure TUIItem.SetOnClickProc(const Value: TNotifyProc);
begin
  FOnClickProc := Value;
end;

procedure TUIItem.SetOnPaint(const Value: TNotifyEvent);
begin
  FOnPaint := Value;
end;

procedure TUIItem.SetOnPaintProc(const Value: TNotifyProc);
begin
  FOnPaintProc := Value;
end;

procedure TUIItem.SetBounds(const Value: TUIItemBounds);
begin
  FBounds := Value;
end;

procedure TUIItem.SetFocus;
begin
  IsFocused := true;
end;

procedure TUIItem.SetRightItem(const Value: TUIItem);
var
  OldLink: TUIItem;
begin
  if FRightItem = Value then
    exit;

  OldLink := FRightItem;
  FRightItem := Value;

  if assigned(OldLink) then
    OldLink.LeftItem := nil;

  if assigned(FRightItem) then
    FRightItem.LeftItem := self;
end;

procedure TUIItem.SetTag(const Value: integer);
begin
  FTag := Value;
end;

procedure TUIItem.SetTagBool(const Value: boolean);
begin
  FTagBool := Value;
end;

procedure TUIItem.SetTagFloat(const Value: single);
begin
  FTagFloat := Value;
end;

procedure TUIItem.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

procedure TUIItem.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

procedure TUIItem.SetTopItem(const Value: TUIItem);
var
  OldLink: TUIItem;
begin
  if FTopItem = Value then
    exit;

  OldLink := FTopItem;
  FTopItem := Value;

  if assigned(OldLink) then
    OldLink.BottomItem := nil;

  if assigned(FTopItem) then
    FTopItem.BottomItem := self;
end;

{ TUIItemsList }

function TUIItemsList.AddUIItem(const AOnClick: TNotifyEvent): TUIItem;
begin
  result := TUIItem.Create(self, AOnClick);
  result.FLayoutIndex := FLayoutIndex;
  FList.Add(result);
end;

function TUIItemsList.AddUIItem(const AOnClickProc: TNotifyProc): TUIItem;
begin
  result := TUIItem.Create(self, AOnClickProc);
  result.FLayoutIndex := FLayoutIndex;
  FList.Add(result);
end;

function TUIItemsList.AddUIItem(const ABounds: TUIItemBounds;
  const AOnClick: TNotifyEvent): TUIItem;
begin
  result := TUIItem.Create(self, ABounds, AOnClick);
  result.FLayoutIndex := FLayoutIndex;
  FList.Add(result);
end;

function TUIItemsList.AddUIItem(const ABounds: TUIItemBounds;
  const AOnClickProc: TNotifyProc): TUIItem;
begin
  result := TUIItem.Create(self, ABounds, AOnClickProc);
  result.FLayoutIndex := FLayoutIndex;
  FList.Add(result);
end;

constructor TUIItemsList.Create;
begin
  inherited;
  FList := TList<TUIItem>.Create;
  FLayoutIndex := 0;
end;

destructor TUIItemsList.Destroy;
begin
  while FList.Count > 0 do
    RemoveItem(FList[0]);
  FList.free;
  inherited;
end;

procedure TUIItemsList.ExtractItem(const AItem: TUIItem);
begin
  FList.Extract(AItem);
end;

function TUIItemsList.Focused: TUIItem;
var
  i: integer;
begin
  result := nil;
  for i := 0 to FList.Count - 1 do
    if (FList[i].FLayoutIndex = FLayoutIndex) and FList[i].IsFocused then
    begin
      result := FList[i];
      break;
    end;
end;

procedure TUIItemsList.GamepadButtonDown(const Button: TJoystickButtons;
  var Handled: boolean);
var
  i: integer;
begin
  Handled := false;
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  for i := 0 to FList.Count - 1 do
    if (FList[i].FLayoutIndex = FLayoutIndex) then
    begin
      FList[i].GamepadButtonDown(Button, Handled);
      if Handled then
        break;
    end;
end;

function TUIItemsList.GamepadMove(const DirectionPad: TJoystickDPad): boolean;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  case DirectionPad of
    TJoystickDPad.Right:
      result := GoToRight;
    TJoystickDPad.Bottom:
      result := GoToDown;
    TJoystickDPad.Left:
      result := GoToLeft;
    TJoystickDPad.Top:
      result := GoToUp;
  else
    result := false;
  end;
end;

function TUIItemsList.GetElementByTagObject(const ATagObject: TObject): TUIItem;
var
  i: integer;
begin
  result := nil;
  for i := 0 to FList.Count - 1 do
    if FList[i].TagObject = ATagObject then
    begin
      result := FList[i];
      break;
    end;
end;

function TUIItemsList.GoToDown: boolean;
var
  item: TUIItem;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  item := Focused;
  if assigned(item) and assigned(item.BottomItem) then
  begin
    item.BottomItem.SetFocus;
    result := true;
  end
  else
    result := false;
end;

function TUIItemsList.GoToLeft: boolean;
var
  item: TUIItem;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  item := Focused;
  if assigned(item) and assigned(item.LeftItem) then
  begin
    item.LeftItem.SetFocus;
    result := true;
  end
  else
    result := false;
end;

function TUIItemsList.GoToRight: boolean;
var
  item: TUIItem;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  item := Focused;
  if assigned(item) and assigned(item.RightItem) then
  begin
    item.RightItem.SetFocus;
    result := true;
  end
  else
    result := false;
end;

function TUIItemsList.GoToUp: boolean;
var
  item: TUIItem;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  item := Focused;
  if assigned(item) and assigned(item.TopItem) then
  begin
    item.TopItem.SetFocus;
    result := true;
  end
  else
    result := false;
end;

procedure TUIItemsList.KeyDown(var Key: Word; var KeyChar: WideChar;
  const Shift: TShiftState);
var
  i: integer;
begin
  // TODO : ne prendre en charge la demande que si des éléments d'interface sont disponibles à ce niveau
  for i := 0 to FList.Count - 1 do
    if (FList[i].FLayoutIndex = FLayoutIndex) then
    begin
      FList[i].KeyDown(Key, KeyChar, Shift);
      if (Key = 0) and (KeyChar = #0) then
        break;
    end;

  if (Key = vkRight) then
  begin
    if GoToRight then
    begin
      Key := 0;
      KeyChar := #0;
    end;
  end
  else if (Key = vkDown) then
  begin
    if GoToDown then
    begin
      Key := 0;
      KeyChar := #0;
    end;
  end
  else if (Key = vkLeft) then
  begin
    if GoToLeft then
    begin
      Key := 0;
      KeyChar := #0;
    end;
  end
  else if (Key = vkUp) then
  begin
    if GoToUp then
    begin
      Key := 0;
      KeyChar := #0;
    end;
  end;
end;

procedure TUIItemsList.NewLayout;
begin
  inc(FLayoutIndex);
end;

procedure TUIItemsList.RemoveItem(const AItem: TUIItem);
begin
  FList.Remove(AItem);
  AItem.free;
end;

procedure TUIItemsList.RemoveLayout;
var
  i: integer;
begin
  for i := FList.Count - 1 downto 0 do
    if (FList[i].FLayoutIndex = FLayoutIndex) then
      RemoveItem(FList[i]);
  dec(FLayoutIndex);
end;

{ TUIKeyShortCut }

procedure TUIKeyShortCut.SetKey(const Value: Word);
begin
  FKey := Value;
end;

procedure TUIKeyShortCut.SetKeyChar(const Value: WideChar);
begin
  FKeyChar := Value;
end;

procedure TUIKeyShortCut.SetShift(const Value: TShiftState);
begin
  FShift := Value;
end;

{ TUIKeyShortCutList }

procedure TUIKeyShortCutList.Add(const Key: Word; const KeyChar: WideChar;
  const Shift: TShiftState);
var
  sc: TUIKeyShortCut;
begin
  if (Key = 0) and (KeyChar = #0) then
    exit;

  if not Exists(Key, KeyChar, Shift) then
  begin
    sc := TUIKeyShortCut.Create;
    sc.Key := Key;
    sc.KeyChar := KeyChar;
    sc.Shift := Shift;
    FList.Add(sc);
  end;
end;

constructor TUIKeyShortCutList.Create;
begin
  inherited;
  FList := TObjectList<TUIKeyShortCut>.Create;
end;

destructor TUIKeyShortCutList.Destroy;
begin
  FList.free;
  inherited;
end;

function TUIKeyShortCutList.Exists(const Key: Word; const KeyChar: WideChar;
  const Shift: TShiftState): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to FList.Count - 1 do
    if (FList[i].Key = Key) and (FList[i].KeyChar = KeyChar) and
      (FList[i].Shift = Shift) then
    begin
      result := true;
      break;
    end;
end;

procedure TUIKeyShortCutList.Remove(const Key: Word; const KeyChar: WideChar;
  const Shift: TShiftState);
var
  i: integer;
begin
  for i := FList.Count - 1 downto 0 do
    if (FList[i].Key = Key) and (FList[i].KeyChar = KeyChar) and
      (FList[i].Shift = Shift) then
      FList[i].free;
end;

end.
