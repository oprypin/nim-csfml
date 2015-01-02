
#--- SFML/Window ---#


#--- SFML/Window/Context ---#


#--- SFML/Window/Types ---#

type
  Context* = ptr TContext
  TContext {.pure, final.} = object

type
  Window* = ptr TWindow
  TWindow {.pure, final.} = object

proc newContext*(): Context {.
  cdecl, dynlib: lib, importc: "sfContext_create".}

proc destroy*(context: Context) {.
  cdecl, dynlib: lib, importc: "sfContext_destroy".}

proc `active=`*(context: Context, active: IntBool) {.
  cdecl, dynlib: lib, importc: "sfContext_setActive".}


#--- SFML/Window/Event ---#


#--- SFML/Window/Joystick ---#

const
  JoystickCount* = 8
  JoystickButtonCount* = 32
  JoystickAxisCount* = 8

type JoystickAxis* {.pure, size: sizeof(cint).} = enum
  X, Y, Z, R, U, V, PovX, PovY

proc joystick_isConnected*(joystick: cint): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_isConnected".}

proc joystick_getButtonCount*(joystick: cint): cint {.
  cdecl, dynlib: lib, importc: "sfJoystick_getButtonCount".}

proc joystick_hasAxis*(joystick: cint, axis: JoystickAxis): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_hasAxis".}

proc joystick_isButtonPressed*(joystick: cint, button: cint): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_isButtonPressed".}

proc joystick_getAxisPosition*(joystick: cint, axis: JoystickAxis): cfloat {.
  cdecl, dynlib: lib, importc: "sfJoystick_getAxisPosition".}

proc joystick_update*() {.
  cdecl, dynlib: lib, importc: "sfJoystick_update".}


#--- SFML/Window/Keyboard ---#

type KeyCode* {.pure, size: sizeof(cint).} = enum
  Unknown = -1, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U,
  V, W, X, Y, Z, Num0, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9,
  Escape, LControl, LShift, LAlt, LSystem, RControl, RShift, RAlt, RSystem,
  Menu, LBracket, RBracket, SemiColon, Comma, Period, Quote, Slash, BackSlash,
  Tilde, Equal, Dash, Space, Return, Back, Tab, PageUp, PageDown, End, Home,
  Insert, Delete, Add, Subtract, Multiply, Divide, Left, Right, Up, Down,
  Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6, Numpad7,
  Numpad8, Numpad9, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
  F15, Pause, Count

proc keyboard_isKeyPressed*(key: KeyCode): IntBool {.
  cdecl, dynlib: lib, importc: "sfKeyboard_isKeyPressed".}


#--- SFML/Window/Mouse ---#

type MouseButton* {.pure, size: sizeof(cint).} = enum
  Left, Right, Middle, XButton1, XButton2, Count

proc mouse_isButtonPressed*(button: MouseButton): IntBool {.
  cdecl, dynlib: lib, importc: "sfMouse_isButtonPressed".}

proc mouse_getPosition*(relativeTo: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfMouse_getPosition".}

proc mouse_setPosition*(position: Vector2i, relativeTo: Window) {.
  cdecl, dynlib: lib, importc: "sfMouse_setPosition".}

type EventType* {.pure, size: sizeof(cint).} = enum
  Closed, Resized, LostFocus, GainedFocus, TextEntered, KeyPressed, KeyReleased,
  MouseWheelMoved, MouseButtonPressed, MouseButtonReleased, MouseMoved,
  MouseEntered, MouseLeft, JoystickButtonPressed, JoystickButtonReleased,
  JoystickMoved, JoystickConnected, JoystickDisconnected

type KeyEvent* {.pure, final.} = object
  code*: KeyCode
  alt*: IntBool
  control*: IntBool
  shift*: IntBool
  system*: IntBool

type TextEvent* {.pure, final.} = object
  unicode*: uint32

type MouseMoveEvent* {.pure, final.} = object
  x*: cint
  y*: cint

type MouseButtonEvent* {.pure, final.} = object
  button*: MouseButton
  x*: cint
  y*: cint

type MouseWheelEvent* {.pure, final.} = object
  delta*: cint
  x*: cint
  y*: cint

type JoystickMoveEvent* {.pure, final.} = object
  joystickId*: cint
  axis*: JoystickAxis
  position*: cfloat

type JoystickButtonEvent* {.pure, final.} = object
  joystickId*: cint
  button*: cint

type JoystickConnectEvent* {.pure, final.} = object
  joystickId*: cint

type SizeEvent* {.pure, final.} = object
  width*: cint
  height*: cint

include csfml_union_event


#--- SFML/Window/VideoMode ---#

type VideoMode* {.pure, final.} = object
  width*: cint
  height*: cint
  bitsPerPixel*: cint

proc videoMode_getDesktopMode*(): VideoMode {.
  cdecl, dynlib: lib, importc: "sfVideoMode_getDesktopMode".}

proc videoMode_getFullscreenModes*(count: ptr int): var VideoMode {.
  cdecl, dynlib: lib, importc: "sfVideoMode_getFullscreenModes".}

proc valid*(mode: VideoMode): IntBool {.
  cdecl, dynlib: lib, importc: "sfVideoMode_isValid".}


#--- SFML/Window/Window ---#


#--- SFML/Window/WindowHandle ---#

type WindowStyle* {.pure, size: sizeof(cint).} = enum
  None = 0, Titlebar = 1, Resize = 2, Close = 4, Default = 7, Fullscreen = 8

type ContextSettings* {.pure, final.} = object
  depthBits*: cint
  stencilBits*: cint
  antialiasingLevel*: cint
  majorVersion*: cint
  minorVersion*: cint

proc newWindow*(mode: VideoMode, title: cstring, style: uint32, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, dynlib: lib, importc: "sfWindow_create".}
proc newWindow*(mode: VideoMode, title: cstring, style: uint32, settings: ContextSettings): Window =
  (var Csettings = settings)
  newWindow(mode, title, style, Csettings)

proc newWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, dynlib: lib, importc: "sfWindow_createUnicode".}
proc newWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: ContextSettings): Window =
  (var Csettings = settings)
  newWindow(mode, title, style, Csettings)

proc newWindow*(handle: WindowHandle, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, dynlib: lib, importc: "sfWindow_createFromHandle".}
proc newWindow*(handle: WindowHandle, settings: ContextSettings): Window =
  (var Csettings = settings)
  newWindow(handle, Csettings)

proc destroy*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_destroy".}

proc close*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_close".}

proc open*(window: Window): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_isOpen".}

proc settings*(window: Window): ContextSettings {.
  cdecl, dynlib: lib, importc: "sfWindow_getSettings".}

proc pollEvent*(window: Window, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_pollEvent".}

proc waitEvent*(window: Window, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_waitEvent".}

proc position*(window: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfWindow_getPosition".}

proc `position=`*(window: Window, position: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfWindow_setPosition".}

proc size*(window: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfWindow_getSize".}

proc `size=`*(window: Window, size: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfWindow_setSize".}

proc `title=`*(window: Window, title: cstring) {.
  cdecl, dynlib: lib, importc: "sfWindow_setTitle".}

proc `unicodeTitle=`*(window: Window, title: ptr uint32) {.
  cdecl, dynlib: lib, importc: "sfWindow_setUnicodeTitle".}

proc setIcon*(window: Window, width: cint, height: cint, pixels: ptr uint8) {.
  cdecl, dynlib: lib, importc: "sfWindow_setIcon".}

proc `visible=`*(window: Window, visible: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setVisible".}

proc `mouseCursorVisible=`*(window: Window, visible: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setMouseCursorVisible".}

proc `verticalSyncEnabled=`*(window: Window, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setVerticalSyncEnabled".}

proc `keyRepeatEnabled=`*(window: Window, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setKeyRepeatEnabled".}

proc `active=`*(window: Window, active: IntBool): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_setActive".}

proc display*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_display".}

proc `framerateLimit=`*(window: Window, limit: cint) {.
  cdecl, dynlib: lib, importc: "sfWindow_setFramerateLimit".}

proc `joystickThreshold=`*(window: Window, threshold: cfloat) {.
  cdecl, dynlib: lib, importc: "sfWindow_setJoystickThreshold".}

proc systemHandle*(window: Window): WindowHandle {.
  cdecl, dynlib: lib, importc: "sfWindow_getSystemHandle".}
