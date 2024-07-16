unit uJoystickManager;

interface

uses
  System.Generics.Collections,
  System.Classes,
  Gamolf.RTL.Joystick;

type
  TJoystickAxes = (X, Y, Z, R, U, V); // TODO : à déplacer dans Olf.RTL.Joystick

  TGamepadClass = class;
  TGamepadClassDict = class;
  TGamepad = class;
  TGamepadList = class;

  TOnNewGamepadDetected = procedure(const GamepadID: integer) of object;
  TOnGamepadLost = procedure(const GamepadID: integer) of object;
  TOnGamepadButtonUp = procedure(const GamepadID: integer;
    const Button: TJoystickButtons);
  TOnGamepadButtonDown = procedure(const GamepadID: integer;
    const Button: TJoystickButtons);
  TOnGamepadAxesChange = procedure(const GamepadID: integer;
    const Axe: TJoystickAxes; const Value: single);
  TOnGamepadDirectionPadChange = procedure(const GamepadID: integer;
    const Value: TJoystickDPad);

  /// <summary>
  /// Gamepad manager class, to use as a singleton.
  /// </summary>
  TGamepadManagerClass = class(TInterfacedObject)
  private
    class var FGamepadManager: TGamepadManagerClass;

  var
    /// <summary>
    /// List of gamepad datas
    /// </summary>
    FGamepads: TGamepadClassDict;
    /// <summary>
    /// Access to the joystick interface
    /// </summary>
    FGamolfJoystickService: IGamolfJoystickService;
    /// <summary>
    /// Activate or stop the gamepad infos check loop
    /// </summary>
    FEnabled: boolean;
    /// <summary>
    /// To know if the thread loop is running
    /// </summary>
    FLoopIsRunning: boolean;
    /// <summary>
    /// To check the thread status and terminate it if needed
    /// </summary>
    FLoopThread: TThread;
    FOnNewGamepadDetected: TOnNewGamepadDetected;
    FOnGamepadLost: TOnGamepadLost;
    FOnGamepadDirectionPadChange: TOnGamepadDirectionPadChange;
    FOnGamepadAxesChange: TOnGamepadAxesChange;
    FOnGamepadButtonDown: TOnGamepadButtonDown;
    FOnGamepadButtonUp: TOnGamepadButtonUp;
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
    procedure SetOnGamepadLost(const Value: TOnGamepadLost);
    procedure SetOnNewGamepadDetected(const Value: TOnNewGamepadDetected);
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
  protected
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
  public
    property IsSupported: boolean read GetIsSupported;
    property Enabled: boolean read FEnabled write SetEnabled;
    property OnNewGamepadDetected: TOnNewGamepadDetected
      read FOnNewGamepadDetected write SetOnNewGamepadDetected;
    property OnGamepadLost: TOnGamepadLost read FOnGamepadLost
      write SetOnGamepadLost;
    property OnGamepadButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnGamepadButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnGamepadAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    class function Current: TGamepadManagerClass;
    class constructor Create;
    class destructor Destroy;
    function GetGamepad(const AID: integer): TGamepadClass;
  end;

  /// <summary>
  /// Gamepad manager component
  /// </summary>
  TGamepadManager = class(TComponent)
  private
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
    function GetEnabled: boolean;
    procedure SetOnGamepadLost(const Value: TOnGamepadLost);
    procedure SetOnNewGamepadDetected(const Value: TOnNewGamepadDetected);
    function GetOnGamepadLost: TOnGamepadLost;
    function GetOnNewGamepadDetected: TOnNewGamepadDetected;
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
  protected
  public
    property IsSupported: boolean read GetIsSupported;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: boolean read GetEnabled write SetEnabled;
    property OnNewGamepadDetected: TOnNewGamepadDetected
      read GetOnNewGamepadDetected write SetOnNewGamepadDetected;
    property OnGamepadLost: TOnGamepadLost read GetOnGamepadLost
      write SetOnGamepadLost;
    property OnGamepadButtonUp: TOnGamepadButtonUp read GetOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnGamepadButtonDown: TOnGamepadButtonDown
      read GetOnGamepadButtonDown write SetOnGamepadButtonDown;
    property OnGamepadAxesChange: TOnGamepadAxesChange
      read GetOnGamepadAxesChange write SetOnGamepadAxesChange;
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read GetOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
  end;

  /// <summary>
  /// Gamepad class to access data from each gamepad detected on the system
  /// </summary>
  TGamepadClass = class(TInterfacedObject)
  private
    /// <summary>
    /// List of gamepad components for this ID
    /// </summary>
    FGamepads: TGamepadList;
    FID: integer;
    FEnabled: boolean;
    FOnGamepadDirectionPadChange: TOnGamepadDirectionPadChange;
    FOnGamepadAxesChange: TOnGamepadAxesChange;
    FOnGamepadButtonDown: TOnGamepadButtonDown;
    FOnGamepadButtonUp: TOnGamepadButtonUp;
    procedure SetID(const Value: integer);
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
  protected
  public
    property IsSupported: boolean read GetIsSupported;
    property Enabled: boolean read FEnabled write SetEnabled;
    property OnGamepadButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnGamepadButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnGamepadAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    destructor Destroy; override;
    property ID: integer read FID write SetID;
    constructor Create;
  end;

  TGamepadClassDict = class(TObjectDictionary<integer, TGamepadClass>)
  end;

  /// <summary>
  /// Gamepad component
  /// </summary>
  TGamepad = class(TComponent)
  private
    FID: integer;
    FEnabled: boolean;
    FOnGamepadDirectionPadChange: TOnGamepadDirectionPadChange;
    FOnGamepadAxesChange: TOnGamepadAxesChange;
    FOnGamepadButtonDown: TOnGamepadButtonDown;
    FOnGamepadButtonUp: TOnGamepadButtonUp;
    procedure SetID(const Value: integer);
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
  protected
    function getGamepadData: TGamepadClass;
  public
    property IsSupported: boolean read GetIsSupported;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ID: integer read FID write SetID;
    property Enabled: boolean read FEnabled write SetEnabled;
    property OnGamepadButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnGamepadButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnGamepadAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
  end;

  TGamepadList = class(TObjectList<TGamepad>)
  end;

procedure Register;

implementation

{$IF Defined(FRAMEWORK_FMX)}

uses
  FMX.Platform,
  Gamolf.FMX.Joystick;
{$ELSEIF Defined(FRAMEWORK_VCL)}

uses
  Gamolf.VCL.Joystick;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Gamolf', [TGamepadManager, TGamepad]);
end;

{ TGamepadManagerClass }

class constructor TGamepadManagerClass.Create;
begin
  FGamepadManager := TGamepadManagerClass.Create;
end;

constructor TGamepadManagerClass.Create;
begin
  inherited;
  FGamepads := TGamepadClassDict.Create([TDictionaryOwnership.doOwnsValues]);
{$IF Defined(FRAMEWORK_FMX)}
  if not TPlatformServices.Current.SupportsPlatformService
    (IGamolfJoystickService, FGamolfJoystickService) then
    FGamolfJoystickService := nil;
{$ELSEIF Defined(FRAMEWORK_VCL)}
  FGamolfJoystickService := GetGamolfJoystickService;
{$ELSE}
{$MESSAGE FATAL 'Project type not implemented.'}
{$ENDIF}
  FLoopIsRunning := false;
  Enabled := IsSupported; // start the gamepad thread loop if its supported
  // TODO : à compléter
end;

class function TGamepadManagerClass.Current: TGamepadManagerClass;
begin
  result := FGamepadManager;
end;

destructor TGamepadManagerClass.Destroy;
var
  i: integer;
begin
  // TODO : à compléter
  Enabled := false; // stop the gamepad thread loop

  // Wait max 1 minute the end of the thread loop
  i := 0;
  while FLoopIsRunning and (i < 10 * 100 * 60) do
  begin
    TThread.Sleep(10);
    inc(i);
  end;

  FGamepads.Free;
  inherited;
end;

function TGamepadManagerClass.GetGamepad(const AID: integer): TGamepadClass;
begin
  // TODO : traiter cas de AID=-1 (dernier ayant eu une modification ou le premier disponible)
  if not FGamepads.TryGetValue(AID, result) then
    result := nil;
end;

function TGamepadManagerClass.GetIsSupported: boolean;
begin
  result := assigned(FGamolfJoystickService);
end;

procedure TGamepadManagerClass.SetEnabled(const Value: boolean);
begin
  if (not Value) and FLoopIsRunning then
    FLoopThread.Terminate;

  FEnabled := Value;

  if FEnabled and (not FLoopIsRunning) then
    Execute;
end;

procedure TGamepadManagerClass.SetOnGamepadAxesChange
  (const Value: TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepadManagerClass.SetOnGamepadButtonDown
  (const Value: TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepadManagerClass.SetOnGamepadButtonUp
  (const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepadManagerClass.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

procedure TGamepadManagerClass.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  FOnGamepadLost := Value;
end;

procedure TGamepadManagerClass.SetOnNewGamepadDetected
  (const Value: TOnNewGamepadDetected);
begin
  FOnNewGamepadDetected := Value;
end;

class destructor TGamepadManagerClass.Destroy;
begin
  FGamepadManager.Free;
end;

procedure TGamepadManagerClass.Execute;
begin
  if (not FLoopIsRunning) and IsSupported then
  begin
    FLoopIsRunning := true;
    try
      FLoopThread := TThread.CreateAnonymousThread(
        procedure
        begin
          try
            while not TThread.CheckTerminated do
            begin
              TThread.Sleep(10);
              // TODO : boucle de détection des valeurs des gamepad
              // TODO : si nouveau appeler onNewGamepadDetected
              // TODO : si gamepad inexistant, appeler onLostGamepad
            end;
          finally
            FLoopIsRunning := false;
          end;
        end);
      FLoopThread.start;
    except
      FLoopIsRunning := false;
    end;
  end;
end;

{ TGamepadManager }

constructor TGamepadManager.Create(AOwner: TComponent);
begin
  inherited;
  // TODO : à compléter
end;

destructor TGamepadManager.Destroy;
begin
  // TODO : à compléter
  inherited;
end;

function TGamepadManager.GetEnabled: boolean;
begin

end;

function TGamepadManager.GetIsSupported: boolean;
begin
  result := TGamepadManagerClass.Current.IsSupported;
end;

function TGamepadManager.GetOnGamepadLost: TOnGamepadLost;
begin
  result := TGamepadManagerClass.Current.OnGamepadLost;
end;

function TGamepadManager.GetOnNewGamepadDetected: TOnNewGamepadDetected;
begin
  result := TGamepadManagerClass.Current.OnNewGamepadDetected;
end;

procedure TGamepadManager.SetEnabled(const Value: boolean);
begin
  TGamepadManagerClass.Current.Enabled := Value;
end;

procedure TGamepadManager.SetOnGamepadAxesChange(const Value
  : TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepadManager.SetOnGamepadButtonDown(const Value
  : TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepadManager.SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepadManager.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

procedure TGamepadManager.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  TGamepadManagerClass.Current.OnGamepadLost := Value;
end;

procedure TGamepadManager.SetOnNewGamepadDetected
  (const Value: TOnNewGamepadDetected);
begin
  TGamepadManagerClass.Current.OnNewGamepadDetected := Value;
end;

{ TGamepad }

constructor TGamepad.Create(AOwner: TComponent);
begin
  inherited;
  FID := -1;
  // TODO : à compléter
end;

destructor TGamepad.Destroy;
begin
  // TODO : à compléter
  inherited;
end;

function TGamepad.getGamepadData: TGamepadClass;
begin
  result := TGamepadManagerClass.Current.GetGamepad(FID);
end;

function TGamepad.GetIsSupported: boolean;
begin
  result := TGamepadManagerClass.Current.IsSupported;
end;

procedure TGamepad.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TGamepad.SetID(const Value: integer);
begin
  // TODO : se déréférencer de l'ancien gamepadclass
  FID := Value;
  // TODO : se référencer sur le bon gamepadclass
end;

procedure TGamepad.SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepad.SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepad.SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepad.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

{ TGamepadClass }

constructor TGamepadClass.Create;
begin
  inherited;
  FGamepads := TGamepadList.Create;
  // TODO : à compléter
end;

destructor TGamepadClass.Destroy;
begin
  // TODO : à compléter
  FGamepads.Free;
  inherited;
end;

function TGamepadClass.GetIsSupported: boolean;
begin
  result := TGamepadManagerClass.Current.IsSupported;
end;

procedure TGamepadClass.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TGamepadClass.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TGamepadClass.SetOnGamepadAxesChange(const Value
  : TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepadClass.SetOnGamepadButtonDown(const Value
  : TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepadClass.SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepadClass.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

end.
