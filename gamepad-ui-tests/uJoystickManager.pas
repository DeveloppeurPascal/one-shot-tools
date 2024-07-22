unit uJoystickManager;

interface

uses
  System.Generics.Collections,
  System.Classes,
  Gamolf.RTL.Joystick;

type
  TJoystickAxes = (X, Y, Z, R, U, V);

  TGamepadDevice = class;
  TGamepadDeviceDict = class;
  TGamepad = class;
  TGamepadList = class;

  TOnNewGamepadDetected = procedure(const GamepadID: integer) of object;
  TOnGamepadLost = procedure(const GamepadID: integer) of object;
  TOnGamepadButtonUp = procedure(const GamepadID: integer;
    const Button: TJoystickButtons) of object;
  TOnGamepadButtonDown = procedure(const GamepadID: integer;
    const Button: TJoystickButtons) of object;
  TOnGamepadAxesChange = procedure(const GamepadID: integer;
    const Axe: TJoystickAxes; const Value: single) of object;
  TOnGamepadDirectionPadChange = procedure(const GamepadID: integer;
    const Value: TJoystickDPad) of object;

  /// <summary>
  /// Gamepad manager class, to use as a singleton.
  /// </summary>
  TGamepadDevicesManager = class(TInterfacedObject)
  private
    class var FGamepadManager: TGamepadDevicesManager;

  var
    /// <summary>
    /// List of gamepad datas
    /// </summary>
    FGamepads: TGamepadDeviceDict;
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
    FSynchronizedEvents: boolean;
    FTagBool: boolean;
    FTagFloat: single;
    FTagString: string;
    FTagObject: TObject;
    FTag: integer;
    procedure SetTag(const Value: integer);
    procedure SetTagBool(const Value: boolean);
    procedure SetTagFloat(const Value: single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
    procedure SetSynchronizedEvents(const Value: boolean);
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
    procedure RegisterGamePadClass(const Gamepad: TGamepadDevice);
    procedure UnRegisterGamePadClass(const Gamepad: TGamepadDevice);
    procedure DoNewGamepad(const AGamepadID: integer);
    procedure DoLostGamepad(const AGamepadID: integer);
    function IsGamepadConnected(const GamepadID: integer): boolean;
  public
    /// <summary>
    /// Check if the gamepad API is available for this platform
    /// </summary>
    property IsSupported: boolean read GetIsSupported;
    /// <summary>
    /// Start or stop the gamepad infos check loop
    /// </summary>
    property Enabled: boolean read FEnabled write SetEnabled;
    /// <summary>
    /// Execute events in main thread or in the thread used by the gamepad manager
    /// </summary>
    property SynchronizedEvents: boolean read FSynchronizedEvents
      write SetSynchronizedEvents;
    /// <summary>
    /// Used when a new gamepad is detected (it should be connected but can be not).
    /// </summary>
    property OnNewGamepadDetected: TOnNewGamepadDetected
      read FOnNewGamepadDetected write SetOnNewGamepadDetected;
    /// <summary>
    /// To know if a connected gamepad is disconnected from the system or powered off.
    /// </summary>
    property OnGamepadLost: TOnGamepadLost read FOnGamepadLost
      write SetOnGamepadLost;
    /// <summary>
    /// Called when a gamepad button is up (unpressed)
    /// </summary>
    property OnGamepadButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    /// <summary>
    /// Called when a gamepad button is down (pressed)
    /// </summary>
    property OnGamepadButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    /// <summary>
    /// Called for each new value of a gamepad axe (X,Y or others)
    /// </summary>
    property OnGamepadAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    /// <summary>
    /// Called for each direction change from a gamepad DPAD (if available on it)
    /// </summary>
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    class function Current: TGamepadDevicesManager;
    class constructor Create;
    class destructor Destroy;
    /// <summary>
    /// Return the gamepad data class
    /// </summary>
    function GetGamepad(const AID: integer): TGamepadDevice;
    /// <summary>
    /// Count the detected gamepads number (detected or declared in the OS depending on the platform)
    /// </summary>
    function GamepadCount: integer;
    /// <summary>
    /// Return the connected gamepads number
    /// </summary>
    function ConnectedGamepadCount: integer;
    /// <summary>
    /// Tag property "in case of" not used in this class
    /// </summary>
    property Tag: integer read FTag write SetTag;
    /// <summary>
    /// TagBool property "in case of" not used in this class
    /// </summary>
    property TagBool: boolean read FTagBool write SetTagBool;
    /// <summary>
    /// TagFloat property "in case of" not used in this class
    /// </summary>
    property TagFloat: single read FTagFloat write SetTagFloat;
    /// <summary>
    /// TagObject property "in case of" not used in this class
    /// </summary>
    property TagObject: TObject read FTagObject write SetTagObject;
    /// <summary>
    /// TagString property "in case of" not used in this class
    /// </summary>
    property TagString: string read FTagString write SetTagString;
  end;

  /// <summary>
  /// Gamepad manager component
  /// </summary>
{$IF CompilerVersion >= 33.0}
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux or
    pfidAndroid or pfidiOS)]
{$ELSE}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidOSX64 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidAndroid64 or pidLinux64)]
{$ENDIF}

  TGamepadManager = class(TComponent)
  private
    FTagBool: boolean;
    FTagFloat: single;
    FTagString: string;
    FTagObject: TObject;
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
    function GetOnGamepadAxesChange: TOnGamepadAxesChange;
    function GetOnGamepadButtonDown: TOnGamepadButtonDown;
    function GetOnGamepadButtonUp: TOnGamepadButtonUp;
    function GetOnGamepadDirectionPadChange: TOnGamepadDirectionPadChange;
    function GetSynchronizedEvents: boolean;
    procedure SetSynchronizedEvents(const Value: boolean);
    procedure SetTagBool(const Value: boolean);
    procedure SetTagFloat(const Value: single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
  protected
  public
    property IsSupported: boolean read GetIsSupported;
    property Enabled: boolean read GetEnabled write SetEnabled;
    /// <summary>
    /// Return the gamepad data class
    /// </summary>
    function GetGamepad(const AID: integer): TGamepadDevice;
    /// <summary>
    /// Count the detected gamepads number (detected or declared in the OS depending on the platform)
    /// </summary>
    function GamepadCount: integer;
    /// <summary>
    /// Return the connected gamepads number
    /// </summary>
    function ConnectedGamepadCount: integer;
    constructor Create(AOwner: TComponent); override;
  published
    /// <summary>
    /// Execute events in main thread or in the thread used by the gamepad manager
    /// </summary>
    property SynchronizedEvents: boolean read GetSynchronizedEvents
      write SetSynchronizedEvents default false;
    property OnNewGamepadDetected: TOnNewGamepadDetected
      read GetOnNewGamepadDetected write SetOnNewGamepadDetected;
    property OnGamepadLost: TOnGamepadLost read GetOnGamepadLost
      write SetOnGamepadLost;
    property OnButtonUp: TOnGamepadButtonUp read GetOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnButtonDown: TOnGamepadButtonDown read GetOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnAxesChange: TOnGamepadAxesChange read GetOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnDirectionPadChange: TOnGamepadDirectionPadChange
      read GetOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    /// <summary>
    /// Tag property "in case of" not used in this class
    /// </summary>
    property Tag;
    /// <summary>
    /// TagBool property "in case of" not used in this class
    /// </summary>
    property TagBool: boolean read FTagBool write SetTagBool default false;
    /// <summary>
    /// TagFloat property "in case of" not used in this class
    /// </summary>
    property TagFloat: single read FTagFloat write SetTagFloat;
    /// <summary>
    /// TagObject property "in case of" not used in this class
    /// </summary>
    property TagObject: TObject read FTagObject write SetTagObject default nil;
    /// <summary>
    /// TagString property "in case of" not used in this class
    /// </summary>
    property TagString: string read FTagString write SetTagString;
  end;

  /// <summary>
  /// Gamepad class to access data from each gamepad detected on the system
  /// </summary>
  TGamepadDevice = class(TInterfacedObject)
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
    FJoystickInfo: TJoystickInfo;
    FOnGamepadLost: TOnGamepadLost;
    FIsConnected: boolean;
    FhasDPAD: boolean;
    FSynchronizedEvents: boolean;
    FTagBool: boolean;
    FTagFloat: single;
    FTagString: string;
    FTagObject: TObject;
    FTag: integer;
    procedure SetID(const Value: integer);
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
    procedure SetOnGamepadLost(const Value: TOnGamepadLost);
    procedure SetIsConnected(const Value: boolean);
    function GetIsConnected: boolean;
    function GetAxes(const AxeID: TJoystickAxes): single;
    function GetButtons(const ButtonID: TJoystickButtons): boolean;
    function GetDPad: TJoystickDPad;
    procedure SetSynchronizedEvents(const Value: boolean);
    procedure SetTag(const Value: integer);
    procedure SetTagBool(const Value: boolean);
    procedure SetTagFloat(const Value: single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
  protected
    procedure SetNewJoystickInfo(const NewJoystickInfo: TJoystickInfo);
    procedure DoAxeChanged(const AAxeID: integer);
    procedure DoButtonChanged(const AButtonID: integer);
    procedure DoDirectionPadChanged;
    procedure DoLost;
    procedure RegisterGamePadComponent(const Gamepad: TGamepad);
    procedure UnRegisterGamePadComponent(const Gamepad: TGamepad);
  public
    property ID: integer read FID;
    property IsSupported: boolean read GetIsSupported;
    property Enabled: boolean read FEnabled write SetEnabled;
    property IsConnected: boolean read GetIsConnected write SetIsConnected;
    property hasDPAD: boolean read FhasDPAD;
    property Buttons[const ButtonID: TJoystickButtons]: boolean read GetButtons;
    property Axes[const AxeID: TJoystickAxes]: single read GetAxes;
    property DPad: TJoystickDPad read GetDPad;
    /// <summary>
    /// Execute events in main thread or in the thread used by the gamepad manager
    /// </summary>
    property SynchronizedEvents: boolean read FSynchronizedEvents
      write SetSynchronizedEvents;
    property OnGamepadButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnGamepadButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnGamepadAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnGamepadDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    property OnGamepadLost: TOnGamepadLost read FOnGamepadLost
      write SetOnGamepadLost;
    constructor Create(const AID: integer);
    destructor Destroy; override;
    /// <summary>
    /// Tag property "in case of" not used in this class
    /// </summary>
    property Tag: integer read FTag write SetTag;
    /// <summary>
    /// TagBool property "in case of" not used in this class
    /// </summary>
    property TagBool: boolean read FTagBool write SetTagBool;
    /// <summary>
    /// TagFloat property "in case of" not used in this class
    /// </summary>
    property TagFloat: single read FTagFloat write SetTagFloat;
    /// <summary>
    /// TagObject property "in case of" not used in this class
    /// </summary>
    property TagObject: TObject read FTagObject write SetTagObject;
    /// <summary>
    /// TagString property "in case of" not used in this class
    /// </summary>
    property TagString: string read FTagString write SetTagString;
  end;

  TGamepadDeviceDict = class(TObjectDictionary<integer, TGamepadDevice>)
  end;

  /// <summary>
  /// Gamepad component
  /// </summary>
{$IF CompilerVersion >= 33.0}
  [ComponentPlatformsAttribute(pfidWindows or pfidOSX or pfidLinux or
    pfidAndroid or pfidiOS)]
{$ELSE}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidOSX64 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidAndroid64 or pidLinux64)]
{$ENDIF}

  TGamepad = class(TComponent)
  private
    FID: integer;
    FEnabled: boolean;
    FOnGamepadDirectionPadChange: TOnGamepadDirectionPadChange;
    FOnGamepadAxesChange: TOnGamepadAxesChange;
    FOnGamepadButtonDown: TOnGamepadButtonDown;
    FOnGamepadButtonUp: TOnGamepadButtonUp;
    FOnGamepadLost: TOnGamepadLost;
    FhasDPAD: boolean;
    FSynchronizedEvents: boolean;
    FTagBool: boolean;
    FTagFloat: single;
    FTagString: string;
    FTagObject: TObject;
    procedure SetID(const Value: integer);
    function GetIsSupported: boolean;
    procedure SetEnabled(const Value: boolean);
    procedure SetOnGamepadAxesChange(const Value: TOnGamepadAxesChange);
    procedure SetOnGamepadButtonDown(const Value: TOnGamepadButtonDown);
    procedure SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
    procedure SetOnGamepadDirectionPadChange(const Value
      : TOnGamepadDirectionPadChange);
    procedure SetOnGamepadLost(const Value: TOnGamepadLost);
    function GetIsConnected: boolean;
    function GetHasDPAD: boolean;
    function GetAxes(const AxeID: TJoystickAxes): single;
    function GetButtons(const ButtonID: TJoystickButtons): boolean;
    function GetDPad: TJoystickDPad;
    procedure SetSynchronizedEvents(const Value: boolean);
    procedure SetTagBool(const Value: boolean);
    procedure SetTagFloat(const Value: single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
  protected
    function getGamepadData: TGamepadDevice;
    procedure DoAxeChanged(const AAxeID: integer);
    procedure DoButtonChanged(const AButtonID: integer);
    procedure DoDirectionPadChanged;
    procedure DoLost;
  public
    property IsSupported: boolean read GetIsSupported;
    property IsConnected: boolean read GetIsConnected;
    property hasDPAD: boolean read FhasDPAD;
    property Buttons[const ButtonID: TJoystickButtons]: boolean read GetButtons;
    property Axes[const AxeID: TJoystickAxes]: single read GetAxes;
    property DPad: TJoystickDPad read GetDPad;
    constructor Create(AOwner: TComponent); override;
  published
    property ID: integer read FID write SetID default -1;
    property Enabled: boolean read FEnabled write SetEnabled default true;
    /// <summary>
    /// Execute events in main thread or in the thread used by the gamepad manager
    /// </summary>
    property SynchronizedEvents: boolean read FSynchronizedEvents
      write SetSynchronizedEvents default false;
    property OnButtonUp: TOnGamepadButtonUp read FOnGamepadButtonUp
      write SetOnGamepadButtonUp;
    property OnButtonDown: TOnGamepadButtonDown read FOnGamepadButtonDown
      write SetOnGamepadButtonDown;
    property OnAxesChange: TOnGamepadAxesChange read FOnGamepadAxesChange
      write SetOnGamepadAxesChange;
    property OnDirectionPadChange: TOnGamepadDirectionPadChange
      read FOnGamepadDirectionPadChange write SetOnGamepadDirectionPadChange;
    property OnLost: TOnGamepadLost read FOnGamepadLost write SetOnGamepadLost;
    /// <summary>
    /// Tag property "in case of" not used in this class
    /// </summary>
    property Tag;
    /// <summary>
    /// TagBool property "in case of" not used in this class
    /// </summary>
    property TagBool: boolean read FTagBool write SetTagBool default false;
    /// <summary>
    /// TagFloat property "in case of" not used in this class
    /// </summary>
    property TagFloat: single read FTagFloat write SetTagFloat;
    /// <summary>
    /// TagObject property "in case of" not used in this class
    /// </summary>
    property TagObject: TObject read FTagObject write SetTagObject default nil;
    /// <summary>
    /// TagString property "in case of" not used in this class
    /// </summary>
    property TagString: string read FTagString write SetTagString;
  end;

  TGamepadList = class(TList<TGamepad>)
  end;

procedure Register;

implementation

uses
{$IF Defined(FRAMEWORK_FMX)}
  FMX.Platform,
  Gamolf.FMX.Joystick,
{$ELSEIF Defined(FRAMEWORK_VCL)}
  Gamolf.VCL.Joystick,
{$ENDIF}
{$IF Defined(DEBUG) and Defined(FRAMEWORK_FMX)}
  FMX.Types,
{$ENDIF}
  System.SysUtils;

procedure Register;
begin
  RegisterComponents('Gamolf', [TGamepadManager, TGamepad]);
end;

{ TGamepadDevicesManager }

function TGamepadDevicesManager.ConnectedGamepadCount: integer;
var
  GP: TGamepadDevice;
begin
  result := 0;
  for GP in FGamepads.Values do
    if GP.IsConnected then
      inc(result);
end;

class constructor TGamepadDevicesManager.Create;
begin
  FGamepadManager := TGamepadDevicesManager.Create;
end;

constructor TGamepadDevicesManager.Create;
begin
  inherited;
  FGamepads := TGamepadDeviceDict.Create([TDictionaryOwnership.doOwnsValues]);
{$IF Defined(FRAMEWORK_FMX)}
  if not TPlatformServices.Current.SupportsPlatformService
    (IGamolfJoystickService, FGamolfJoystickService) then
    FGamolfJoystickService := nil;
{$ELSEIF Defined(FRAMEWORK_VCL)}
  FGamolfJoystickService := GetGamolfJoystickService;
{$ELSEIF Defined(IDE)}
  // Component package for the IDE
{$ELSE}
{$MESSAGE FATAL 'Project type not implemented.'}
{$ENDIF}
  FLoopIsRunning := false;
  FLoopThread := nil;
  FOnNewGamepadDetected := nil;
  FOnGamepadLost := nil;
  FOnGamepadDirectionPadChange := nil;
  FOnGamepadAxesChange := nil;
  FOnGamepadButtonDown := nil;
  FOnGamepadButtonUp := nil;
  FOnGamepadDirectionPadChange := nil;
  FEnabled := false;
  FSynchronizedEvents := false;
  FTagBool := false;
  FTagFloat := 0;
  FTagString := '';
  FTagObject := nil;
  FTag := 0;

  // TODO : à ne pas faire dans l'IDE en conception de fiche
  TThread.ForceQueue(nil,
    procedure
    begin
      Enabled := IsSupported; // start the gamepad thread loop if its supported
    end);
end;

class function TGamepadDevicesManager.Current: TGamepadDevicesManager;
begin
  result := FGamepadManager;
end;

destructor TGamepadDevicesManager.Destroy;
var
  i: integer;
begin
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

function TGamepadDevicesManager.GamepadCount: integer;
begin
  result := FGamepads.Count;
end;

function TGamepadDevicesManager.GetGamepad(const AID: integer): TGamepadDevice;
begin
  if (AID < 0) then
  begin
    // TODO : traiter cas de AID=-1 (dernier ayant eu une modification ou le premier disponible)
    result := nil;
  end
  else if not FGamepads.TryGetValue(AID, result) then
    result := TGamepadDevice.Create(AID);
end;

function TGamepadDevicesManager.GetIsSupported: boolean;
begin
  result := assigned(FGamolfJoystickService);
end;

function TGamepadDevicesManager.IsGamepadConnected(const GamepadID
  : integer): boolean;
begin
  result := assigned(FGamolfJoystickService) and
    FGamolfJoystickService.IsConnected(GamepadID);
end;

procedure TGamepadDevicesManager.RegisterGamePadClass(const Gamepad
  : TGamepadDevice);
begin
  if not assigned(self) then
    exit;

  if assigned(Gamepad) and (not FGamepads.ContainsKey(Gamepad.ID)) then
    FGamepads.Add(Gamepad.ID, Gamepad);
end;

procedure TGamepadDevicesManager.SetEnabled(const Value: boolean);
begin
  if (not Value) and FLoopIsRunning then
    FLoopThread.Terminate;

  if Value and (not IsSupported) then
    raise EJoystickServiceException.Create('Gamepad API not available.');

  FEnabled := Value;

  if FEnabled and (not FLoopIsRunning) then
    Execute;
end;

procedure TGamepadDevicesManager.SetOnGamepadAxesChange
  (const Value: TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepadDevicesManager.SetOnGamepadButtonDown
  (const Value: TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepadDevicesManager.SetOnGamepadButtonUp
  (const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepadDevicesManager.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

procedure TGamepadDevicesManager.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  FOnGamepadLost := Value;
end;

procedure TGamepadDevicesManager.SetOnNewGamepadDetected
  (const Value: TOnNewGamepadDetected);
begin
  FOnNewGamepadDetected := Value;
end;

procedure TGamepadDevicesManager.SetSynchronizedEvents(const Value: boolean);
begin
  FSynchronizedEvents := Value;
end;

procedure TGamepadDevicesManager.SetTag(const Value: integer);
begin
  FTag := Value;
end;

procedure TGamepadDevicesManager.SetTagBool(const Value: boolean);
begin
  FTagBool := Value;
end;

procedure TGamepadDevicesManager.SetTagFloat(const Value: single);
begin
  FTagFloat := Value;
end;

procedure TGamepadDevicesManager.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

procedure TGamepadDevicesManager.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

procedure TGamepadDevicesManager.UnRegisterGamePadClass(const Gamepad
  : TGamepadDevice);
begin
  if not assigned(self) then
    exit;

  if assigned(Gamepad) and FGamepads.ContainsKey(Gamepad.ID) then
    FGamepads.ExtractPair(Gamepad.ID);
end;

class destructor TGamepadDevicesManager.Destroy;
begin
  FGamepadManager.Free;
end;

procedure TGamepadDevicesManager.DoLostGamepad(const AGamepadID: integer);
var
  GP: TGamepadDevice;
  LGamepadID: integer;
begin
  GP := GetGamepad(AGamepadID);
  GP.DoLost;
  if assigned(FOnGamepadLost) then
    if FSynchronizedEvents then
    begin
      LGamepadID := AGamepadID;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(FOnGamepadLost) then
            FOnGamepadLost(LGamepadID);
        end);
    end
    else
      FOnGamepadLost(AGamepadID);
end;

procedure TGamepadDevicesManager.DoNewGamepad(const AGamepadID: integer);
var
  LGamepadID: integer;
  GP: TGamepadDevice;
begin
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
  // if AGamepadID = 2 then
  // log.d(FGamolfJoystickService.IsConnected(AGamepadID).tostring);
{$ENDIF}
  if assigned(FGamolfJoystickService) and FGamolfJoystickService.IsConnected
    (AGamepadID) then
  begin
    GP := GetGamepad(AGamepadID);
    GP.FhasDPAD := FGamolfJoystickService.hasDPAD(AGamepadID);
    GP.IsConnected := true;
    if assigned(FOnNewGamepadDetected) then
      if FSynchronizedEvents then
      begin
        LGamepadID := AGamepadID;
        TThread.Queue(nil,
          procedure
          begin
            if not assigned(self) then
              exit;

            if assigned(FOnNewGamepadDetected) then
              FOnNewGamepadDetected(LGamepadID);
          end);
      end
      else
        FOnNewGamepadDetected(AGamepadID);
  end;
end;

procedure TGamepadDevicesManager.Execute;
begin
  if (not FLoopIsRunning) and IsSupported then
  begin
    FLoopIsRunning := true;
    try
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
      // log.d('GamepadManagerLoop: starting');
{$ENDIF}
      FLoopThread := TThread.CreateAnonymousThread(
        procedure
        var
          LJoystickInfo: TJoystickInfo;
        begin
          try
            try
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
              // log.d('GamepadManagerLoop: started');
{$ENDIF}
              while not TThread.CheckTerminated do
              begin
                TThread.Sleep(10);
                FGamolfJoystickService.ForEach(LJoystickInfo,
                  procedure(JoystickID: TJoystickID;
                    var JoystickInfo: TJoystickInfo; hadError: boolean)
                  var
                    GP: TGamepadDevice;
                  begin
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
                    // log.d('Joystick '+joystickid.ToString+ ' error ? '+haderror.ToString);
{$ENDIF}
                    GP := GetGamepad(JoystickID);
                    if hadError then
                    begin
                      if GP.IsConnected then
                        DoLostGamepad(JoystickID);
                    end
                    else if not GP.IsConnected then
                      // TODO : ne faire le test qu'une fois par seconde pour limiter les saturations d'API (notamment Windows) inutiles
                      DoNewGamepad(JoystickID)
                    else
                      GP.SetNewJoystickInfo(JoystickInfo);
                  end);
              end;
            finally
              FLoopIsRunning := false;
            end;
          except
            on e: exception do
            begin
              // TODO : ajouter un evenement pour remonter les erreurs au développeur

{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
              // log.d('GamepadManagerLoop: ' + e.Message);
{$ENDIF}
            end;
          end;
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
          // log.d('GamepadManagerLoop: stopped');
{$ENDIF}
        end);
      FLoopThread.start;
    except
      FLoopIsRunning := false;
    end;
  end;
end;

{ TGamepadManager }

function TGamepadManager.ConnectedGamepadCount: integer;
begin
  result := TGamepadDevicesManager.Current.ConnectedGamepadCount;
end;

constructor TGamepadManager.Create(AOwner: TComponent);
begin
  inherited;
  FTagBool := false;
  FTagFloat := 0;
  FTagString := '';
  FTagObject := nil;
end;

function TGamepadManager.GamepadCount: integer;
begin
  result := TGamepadDevicesManager.Current.GamepadCount;
end;

function TGamepadManager.GetEnabled: boolean;
begin
  result := TGamepadDevicesManager.Current.Enabled;
end;

function TGamepadManager.GetGamepad(const AID: integer): TGamepadDevice;
begin
  result := TGamepadDevicesManager.Current.GetGamepad(AID);
end;

function TGamepadManager.GetIsSupported: boolean;
begin
  result := TGamepadDevicesManager.Current.IsSupported;
end;

function TGamepadManager.GetOnGamepadAxesChange: TOnGamepadAxesChange;
begin
  result := TGamepadDevicesManager.Current.OnGamepadAxesChange;
end;

function TGamepadManager.GetOnGamepadButtonDown: TOnGamepadButtonDown;
begin
  result := TGamepadDevicesManager.Current.OnGamepadButtonDown;
end;

function TGamepadManager.GetOnGamepadButtonUp: TOnGamepadButtonUp;
begin
  result := TGamepadDevicesManager.Current.OnGamepadButtonUp;
end;

function TGamepadManager.GetOnGamepadDirectionPadChange
  : TOnGamepadDirectionPadChange;
begin
  result := TGamepadDevicesManager.Current.OnGamepadDirectionPadChange;
end;

function TGamepadManager.GetOnGamepadLost: TOnGamepadLost;
begin
  result := TGamepadDevicesManager.Current.OnGamepadLost;
end;

function TGamepadManager.GetOnNewGamepadDetected: TOnNewGamepadDetected;
begin
  result := TGamepadDevicesManager.Current.OnNewGamepadDetected;
end;

function TGamepadManager.GetSynchronizedEvents: boolean;
begin
  result := TGamepadDevicesManager.Current.SynchronizedEvents;
end;

procedure TGamepadManager.SetEnabled(const Value: boolean);
begin
  TGamepadDevicesManager.Current.Enabled := Value;
end;

procedure TGamepadManager.SetOnGamepadAxesChange(const Value
  : TOnGamepadAxesChange);
begin
  TGamepadDevicesManager.Current.OnGamepadAxesChange := Value;
end;

procedure TGamepadManager.SetOnGamepadButtonDown(const Value
  : TOnGamepadButtonDown);
begin
  TGamepadDevicesManager.Current.OnGamepadButtonDown := Value;
end;

procedure TGamepadManager.SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
begin
  TGamepadDevicesManager.Current.OnGamepadButtonUp := Value;
end;

procedure TGamepadManager.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  TGamepadDevicesManager.Current.OnGamepadDirectionPadChange := Value;
end;

procedure TGamepadManager.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  TGamepadDevicesManager.Current.OnGamepadLost := Value;
end;

procedure TGamepadManager.SetOnNewGamepadDetected
  (const Value: TOnNewGamepadDetected);
begin
  TGamepadDevicesManager.Current.OnNewGamepadDetected := Value;
end;

procedure TGamepadManager.SetSynchronizedEvents(const Value: boolean);
begin
  TGamepadDevicesManager.Current.SynchronizedEvents := Value;
end;

procedure TGamepadManager.SetTagBool(const Value: boolean);
begin
  FTagBool := Value;
end;

procedure TGamepadManager.SetTagFloat(const Value: single);
begin
  FTagFloat := Value;
end;

procedure TGamepadManager.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

procedure TGamepadManager.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

{ TGamepad }

constructor TGamepad.Create(AOwner: TComponent);
begin
  inherited;
  FID := -1;
  FEnabled := true;
  FSynchronizedEvents := false;
  FOnGamepadDirectionPadChange := nil;
  FOnGamepadAxesChange := nil;
  FOnGamepadButtonDown := nil;
  FOnGamepadButtonUp := nil;
  FOnGamepadDirectionPadChange := nil;
  FOnGamepadLost := nil;
  FTagBool := false;
  FTagFloat := 0;
  FTagString := '';
  FTagObject := nil;
end;

procedure TGamepad.DoAxeChanged(const AAxeID: integer);
var
  LID: integer;
  LAxe: TJoystickAxes;
  LAxeValue: single;
begin
  // TODO : gérer un niveau de sensibilité sur les changements pour ne pas saturer le logiciel et les files d'attentes sur les centièmes et millièmes
  if assigned(OnAxesChange) and Enabled then
    if SynchronizedEvents then
    begin
      LID := FID;
      LAxe := TJoystickAxes(AAxeID);
      LAxeValue := getGamepadData.Axes[LAxe];
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(OnAxesChange) and Enabled then
            OnAxesChange(LID, LAxe, LAxeValue);
        end);
    end
    else
      OnAxesChange(FID, TJoystickAxes(AAxeID),
        getGamepadData.Axes[TJoystickAxes(AAxeID)]);
end;

procedure TGamepad.DoButtonChanged(const AButtonID: integer);
var
  LID: integer;
  LButton: TJoystickButtons;
begin
  if assigned(OnButtonDown) and Enabled then
    if SynchronizedEvents then
    begin
      LID := FID;
      LButton := TJoystickButtons(AButtonID);
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(OnButtonDown) and Enabled then
            OnButtonDown(LID, LButton);
        end);
    end
    else
      OnButtonDown(FID, TJoystickButtons(AButtonID));
end;

procedure TGamepad.DoDirectionPadChanged;
var
  LID: integer;
  LDpad: TJoystickDPad;
begin
  if assigned(OnDirectionPadChange) and Enabled then
    if SynchronizedEvents then
    begin
      LID := FID;
      LDpad := getGamepadData.DPad;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(OnDirectionPadChange) and Enabled then
            OnDirectionPadChange(LID, LDpad);
        end);
    end
    else
      OnDirectionPadChange(FID, getGamepadData.DPad);
end;

procedure TGamepad.DoLost;
var
  LID: integer;
begin
  if assigned(OnLost) and Enabled then
    if SynchronizedEvents then
    begin
      LID := FID;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(OnLost) and Enabled then
            OnLost(LID);
        end);
    end
    else
      OnLost(FID);
end;

function TGamepad.GetAxes(const AxeID: TJoystickAxes): single;
begin
  result := getGamepadData.GetAxes(AxeID);
end;

function TGamepad.GetButtons(const ButtonID: TJoystickButtons): boolean;
begin
  result := getGamepadData.GetButtons(ButtonID);
end;

function TGamepad.GetDPad: TJoystickDPad;
begin
  result := getGamepadData.GetDPad;
end;

function TGamepad.getGamepadData: TGamepadDevice;
begin
  result := TGamepadDevicesManager.Current.GetGamepad(FID);
end;

function TGamepad.GetHasDPAD: boolean;
begin
  result := getGamepadData.hasDPAD;
end;

function TGamepad.GetIsConnected: boolean;
begin
  result := getGamepadData.IsConnected;
end;

function TGamepad.GetIsSupported: boolean;
begin
  result := TGamepadDevicesManager.Current.IsSupported;
end;

procedure TGamepad.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TGamepad.SetID(const Value: integer);
begin
  getGamepadData.UnRegisterGamePadComponent(self);
  FID := Value;
  getGamepadData.RegisterGamePadComponent(self);
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

procedure TGamepad.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  FOnGamepadLost := Value;
end;

procedure TGamepad.SetSynchronizedEvents(const Value: boolean);
begin
  FSynchronizedEvents := Value;
end;

procedure TGamepad.SetTagBool(const Value: boolean);
begin
  FTagBool := Value;
end;

procedure TGamepad.SetTagFloat(const Value: single);
begin
  FTagFloat := Value;
end;

procedure TGamepad.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

procedure TGamepad.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

{ TGamepadDevice }

constructor TGamepadDevice.Create(const AID: integer);
begin
  inherited Create;
  FGamepads := TGamepadList.Create;
  FID := AID;
  FEnabled := true;
  FhasDPAD := false;
  FOnGamepadDirectionPadChange := nil;
  FOnGamepadAxesChange := nil;
  FOnGamepadButtonDown := nil;
  FOnGamepadButtonUp := nil;
  FOnGamepadLost := nil;
  setlength(FJoystickInfo.Axes, 0);
  setlength(FJoystickInfo.Buttons, 0);
  setlength(FJoystickInfo.PressedButtons, 0);
  FJoystickInfo.DPad := ord(TJoystickDPad.Center);
  FIsConnected := false;
  FSynchronizedEvents := false;
  FTagBool := false;
  FTagFloat := 0;
  FTagString := '';
  FTagObject := nil;
  FTag := 0;

  TGamepadDevicesManager.Current.RegisterGamePadClass(self);
end;

destructor TGamepadDevice.Destroy;
begin
  TGamepadDevicesManager.Current.UnRegisterGamePadClass(self);

  FGamepads.Free;
  inherited;
end;

procedure TGamepadDevice.DoAxeChanged(const AAxeID: integer);
var
  GP: TGamepad;
  LID: integer;
  LAxe: TJoystickAxes;
  LAxeValue: single;
  Copied: boolean;
  procedure FillLocalVariables;
  begin
    if not Copied then
    begin
      LID := FID;
      LAxe := TJoystickAxes(AAxeID);
      LAxeValue := FJoystickInfo.Axes[AAxeID];
      Copied := true;
    end;
  end;

begin
  Copied := false;
  if (AAxeID >= 0) and (AAxeID < length(FJoystickInfo.Axes)) then
  begin
    if assigned(TGamepadDevicesManager.Current.OnGamepadAxesChange) then
      if TGamepadDevicesManager.Current.FSynchronizedEvents then
      begin
        FillLocalVariables;
        TThread.Queue(nil,
          procedure
          begin
            if not assigned(self) then
              exit;

            if assigned(TGamepadDevicesManager.Current.OnGamepadAxesChange) then
              TGamepadDevicesManager.Current.OnGamepadAxesChange(LID, LAxe,
                LAxeValue);
          end);
      end
      else
        TGamepadDevicesManager.Current.OnGamepadAxesChange(FID,
          TJoystickAxes(AAxeID), FJoystickInfo.Axes[AAxeID]);
    if assigned(FOnGamepadAxesChange) then
      if FSynchronizedEvents then
      begin
        FillLocalVariables;
        TThread.Queue(nil,
          procedure
          begin
            if not assigned(self) then
              exit;

            if assigned(FOnGamepadAxesChange) then
              FOnGamepadAxesChange(LID, LAxe, LAxeValue);
          end);
      end
      else
        FOnGamepadAxesChange(FID, TJoystickAxes(AAxeID),
          FJoystickInfo.Axes[AAxeID]);
    for GP in FGamepads do
      GP.DoAxeChanged(AAxeID);
  end;
end;

procedure TGamepadDevice.DoButtonChanged(const AButtonID: integer);
var
  GP: TGamepad;
  LID: integer;
  LButton: TJoystickButtons;
  Copied: boolean;
  procedure FillLocalVariables;
  begin
    if not Copied then
    begin
      LID := FID;
      LButton := TJoystickButtons(AButtonID);
      Copied := true;
    end;
  end;

begin
  Copied := false;
  if (AButtonID >= 0) and (AButtonID < length(FJoystickInfo.Buttons)) then
    case FJoystickInfo.Buttons[AButtonID] of
      true:
        begin
          if assigned(TGamepadDevicesManager.Current.OnGamepadButtonDown) then
            if TGamepadDevicesManager.Current.FSynchronizedEvents then
            begin
              FillLocalVariables;
              TThread.Queue(nil,
                procedure
                begin
                  if not assigned(self) then
                    exit;

                  if assigned(TGamepadDevicesManager.Current.OnGamepadButtonDown)
                  then
                    TGamepadDevicesManager.Current.OnGamepadButtonDown
                      (LID, LButton);
                end);
            end
            else
              TGamepadDevicesManager.Current.OnGamepadButtonDown(FID,
                TJoystickButtons(AButtonID));
          if assigned(FOnGamepadButtonDown) then
            if FSynchronizedEvents then
            begin
              FillLocalVariables;
              TThread.Queue(nil,
                procedure
                begin
                  if not assigned(self) then
                    exit;

                  if assigned(FOnGamepadButtonDown) then
                    FOnGamepadButtonDown(LID, LButton);
                end);
            end
            else
              FOnGamepadButtonDown(FID, TJoystickButtons(AButtonID));
          for GP in FGamepads do
            GP.DoButtonChanged(AButtonID);
        end;
    else
      if assigned(TGamepadDevicesManager.Current.OnGamepadButtonUp) then
        if TGamepadDevicesManager.Current.FSynchronizedEvents then
        begin
          FillLocalVariables;
          TThread.Queue(nil,
            procedure
            begin
              if not assigned(self) then
                exit;

              if assigned(TGamepadDevicesManager.Current.OnGamepadButtonUp) then
                TGamepadDevicesManager.Current.OnGamepadButtonUp(LID, LButton);
            end);
        end
        else
          TGamepadDevicesManager.Current.OnGamepadButtonUp(FID,
            TJoystickButtons(AButtonID));
      if assigned(FOnGamepadButtonUp) then
        if FSynchronizedEvents then
        begin
          FillLocalVariables;
          TThread.Queue(nil,
            procedure
            begin
              if not assigned(self) then
                exit;

              if assigned(FOnGamepadButtonUp) then
                FOnGamepadButtonUp(LID, LButton);
            end);
        end
        else
          FOnGamepadButtonUp(FID, TJoystickButtons(AButtonID));
      for GP in FGamepads do
        if assigned(GP.OnButtonUp) and GP.Enabled then
          if GP.SynchronizedEvents then
          begin
            FillLocalVariables;
            TThread.Queue(nil,
              procedure
              begin
                if not assigned(self) then
                  exit;

                if assigned(GP.OnButtonUp) and GP.Enabled then
                  GP.OnButtonUp(LID, LButton);
              end);
          end
          else
            GP.OnButtonUp(FID, TJoystickButtons(AButtonID));
    end;
end;

procedure TGamepadDevice.DoDirectionPadChanged;
var
  GP: TGamepad;
  LID: integer;
  LDpad: TJoystickDPad;
  Copied: boolean;
  procedure FillLocalVariables;
  begin
    if not Copied then
    begin
      LID := FID;
      LDpad := TJoystickDPad(FJoystickInfo.DPad);
      Copied := true;
    end;
  end;

begin
  Copied := false;
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
  // log.d('Joystick ' + FID.ToString+' DPAD changed');
{$ENDIF}
  if assigned(TGamepadDevicesManager.Current.OnGamepadDirectionPadChange) then
    if TGamepadDevicesManager.Current.FSynchronizedEvents then
    begin
      FillLocalVariables;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(TGamepadDevicesManager.Current.OnGamepadDirectionPadChange)
          then
            TGamepadDevicesManager.Current.OnGamepadDirectionPadChange
              (LID, LDpad);
        end);
    end
    else
      TGamepadDevicesManager.Current.OnGamepadDirectionPadChange(FID,
        TJoystickDPad(FJoystickInfo.DPad));
  if assigned(FOnGamepadDirectionPadChange) then
    if FSynchronizedEvents then
    begin
      FillLocalVariables;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(FOnGamepadDirectionPadChange) then
            FOnGamepadDirectionPadChange(LID, LDpad);
        end);
    end
    else
      FOnGamepadDirectionPadChange(FID, TJoystickDPad(FJoystickInfo.DPad));
  for GP in FGamepads do
    GP.DoDirectionPadChanged;
end;

procedure TGamepadDevice.DoLost;
var
  GP: TGamepad;
  LID: integer;
  Copied: boolean;
  procedure FillLocalVariables;
  begin
    if not Copied then
    begin
      LID := FID;
      Copied := true;
    end;
  end;

begin
  Copied := false;
  FIsConnected := false;
  if assigned(FOnGamepadLost) then
    if FSynchronizedEvents then
    begin
      FillLocalVariables;
      TThread.Queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          if assigned(FOnGamepadLost) then
            FOnGamepadLost(FID)
        end);
    end
    else
      FOnGamepadLost(FID);
  for GP in FGamepads do
    DoLost;
end;

function TGamepadDevice.GetAxes(const AxeID: TJoystickAxes): single;
var
  idx: integer;
begin
  idx := ord(AxeID);
  if (idx >= 0) and (idx < length(FJoystickInfo.Axes)) then
    result := FJoystickInfo.Axes[idx]
  else
    result := 0;
end;

function TGamepadDevice.GetButtons(const ButtonID: TJoystickButtons): boolean;
var
  idx: integer;
begin
  idx := ord(ButtonID);
  if (idx >= 0) and (idx < length(FJoystickInfo.Buttons)) then
    result := FJoystickInfo.Buttons[idx]
  else
    result := false;
end;

function TGamepadDevice.GetDPad: TJoystickDPad;
begin
  result := TJoystickDPad(FJoystickInfo.DPad);
end;

function TGamepadDevice.GetIsConnected: boolean;
begin
  if not assigned(self) then
    exit(false);

  result := FIsConnected and TGamepadDevicesManager.Current.
    IsGamepadConnected(FID);
end;

function TGamepadDevice.GetIsSupported: boolean;
begin
  result := TGamepadDevicesManager.Current.IsSupported;
end;

procedure TGamepadDevice.RegisterGamePadComponent(const Gamepad: TGamepad);
var
  i: integer;
  found: boolean;
begin
  if not assigned(self) then
    exit;

  if assigned(Gamepad) then
  begin
    found := false;
    for i := 0 to FGamepads.Count - 1 do
      if FGamepads[i] = Gamepad then
      begin
        found := true;
        break;
      end;
    if not found then
      FGamepads.Add(Gamepad);
  end;
end;

procedure TGamepadDevice.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TGamepadDevice.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TGamepadDevice.SetIsConnected(const Value: boolean);
begin
  FIsConnected := Value;
end;

procedure TGamepadDevice.SetNewJoystickInfo(const NewJoystickInfo
  : TJoystickInfo);
var
  CurNb, NewNb: integer;
  i: integer;
begin
{$IF Defined(DEBUG) and  Defined(FRAMEWORK_FMX)}
  // log.d('Joystick ' + FID.ToString+' enabled ? '+FEnabled.ToString);
{$ENDIF}
  if not FEnabled then
    exit;

  CurNb := length(FJoystickInfo.Axes);
  NewNb := length(NewJoystickInfo.Axes);
  if CurNb <> NewNb then
  begin
    setlength(FJoystickInfo.Axes, NewNb);
    for i := CurNb to NewNb - 1 do
      FJoystickInfo.Axes[i] := 0;
  end;
  for i := 0 to NewNb - 1 do
    if (FJoystickInfo.Axes[i] <> NewJoystickInfo.Axes[i]) then
    begin
      FJoystickInfo.Axes[i] := NewJoystickInfo.Axes[i];
      DoAxeChanged(i);
    end;

  CurNb := length(FJoystickInfo.Buttons);
  NewNb := length(NewJoystickInfo.Buttons);
  if CurNb <> NewNb then
  begin
    setlength(FJoystickInfo.Buttons, NewNb);
    for i := CurNb to NewNb - 1 do
      FJoystickInfo.Buttons[i] := false;
  end;
  for i := 0 to NewNb - 1 do
    if (FJoystickInfo.Buttons[i] <> NewJoystickInfo.Buttons[i]) then
    begin
      FJoystickInfo.Buttons[i] := NewJoystickInfo.Buttons[i];
      DoButtonChanged(i);
    end;

  if (FJoystickInfo.DPad <> NewJoystickInfo.DPad) then
  begin
    FJoystickInfo.DPad := NewJoystickInfo.DPad;
    DoDirectionPadChanged;
  end;
end;

procedure TGamepadDevice.SetOnGamepadAxesChange(const Value
  : TOnGamepadAxesChange);
begin
  FOnGamepadAxesChange := Value;
end;

procedure TGamepadDevice.SetOnGamepadButtonDown(const Value
  : TOnGamepadButtonDown);
begin
  FOnGamepadButtonDown := Value;
end;

procedure TGamepadDevice.SetOnGamepadButtonUp(const Value: TOnGamepadButtonUp);
begin
  FOnGamepadButtonUp := Value;
end;

procedure TGamepadDevice.SetOnGamepadDirectionPadChange
  (const Value: TOnGamepadDirectionPadChange);
begin
  FOnGamepadDirectionPadChange := Value;
end;

procedure TGamepadDevice.SetOnGamepadLost(const Value: TOnGamepadLost);
begin
  FOnGamepadLost := Value;
end;

procedure TGamepadDevice.SetSynchronizedEvents(const Value: boolean);
begin
  FSynchronizedEvents := Value;
end;

procedure TGamepadDevice.SetTag(const Value: integer);
begin
  FTag := Value;
end;

procedure TGamepadDevice.SetTagBool(const Value: boolean);
begin
  FTagBool := Value;
end;

procedure TGamepadDevice.SetTagFloat(const Value: single);
begin
  FTagFloat := Value;
end;

procedure TGamepadDevice.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

procedure TGamepadDevice.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

procedure TGamepadDevice.UnRegisterGamePadComponent(const Gamepad: TGamepad);
var
  i: integer;
begin
  if not assigned(self) then
    exit;

  for i := FGamepads.Count - 1 downto 0 do
    if FGamepads[i] = Gamepad then
      FGamepads.Delete(i);
end;

end.
