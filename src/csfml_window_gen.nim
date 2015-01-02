
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
  ## Create a new context
  ## 
  ## This function activates the new context.
  ## 
  ## *Returns:* New sfContext object

proc destroy*(context: Context) {.
  cdecl, dynlib: lib, importc: "sfContext_destroy".}
  ## Destroy a context
  ## 
  ## *Arguments*:
  ## - ``context``:  Context to destroy

proc `active=`*(context: Context, active: IntBool) {.
  cdecl, dynlib: lib, importc: "sfContext_setActive".}
  ## Activate or deactivate explicitely a context
  ## 
  ## *Arguments*:
  ## - ``context``:  Context object
  ## - ``active``:   sfTrue to activate, sfFalse to deactivate


#--- SFML/Window/Event ---#


#--- SFML/Window/Joystick ---#

const
  JoystickCount* = 8
  JoystickButtonCount* = 32
  JoystickAxisCount* = 8

type JoystickAxis* {.pure, size: sizeof(cint).} = enum  ## Axes supported by SFML joysticks
  X, Y, Z, R, U, V, PovX, PovY

proc joystick_isConnected*(joystick: cint): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_isConnected".}
  ## Check if a joystick is connected
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick to check
  ## 
  ## *Returns:* sfTrue if the joystick is connected, sfFalse otherwise

proc joystick_getButtonCount*(joystick: cint): cint {.
  cdecl, dynlib: lib, importc: "sfJoystick_getButtonCount".}
  ## Return the number of buttons supported by a joystick
  ## 
  ## If the joystick is not connected, this function returns 0.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## 
  ## *Returns:* Number of buttons supported by the joystick

proc joystick_hasAxis*(joystick: cint, axis: JoystickAxis): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_hasAxis".}
  ## Check if a joystick supports a given axis
  ## 
  ## If the joystick is not connected, this function returns false.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``axis``:      Axis to check
  ## 
  ## *Returns:* sfTrue if the joystick supports the axis, sfFalse otherwise

proc joystick_isButtonPressed*(joystick: cint, button: cint): IntBool {.
  cdecl, dynlib: lib, importc: "sfJoystick_isButtonPressed".}
  ## Check if a joystick button is pressed
  ## 
  ## If the joystick is not connected, this function returns false.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``button``:    Button to check
  ## 
  ## *Returns:* sfTrue if the button is pressed, sfFalse otherwise

proc joystick_getAxisPosition*(joystick: cint, axis: JoystickAxis): cfloat {.
  cdecl, dynlib: lib, importc: "sfJoystick_getAxisPosition".}
  ## Get the current position of a joystick axis
  ## 
  ## If the joystick is not connected, this function returns 0.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``axis``:      Axis to check
  ## 
  ## *Returns:* Current position of the axis, in range [-100 .. 100]

proc joystick_update*() {.
  cdecl, dynlib: lib, importc: "sfJoystick_update".}
  ## Update the states of all joysticks
  ## 
  ## This function is used internally by SFML, so you normally
  ## don't have to call it explicitely. However, you may need to
  ## call it if you have no window yet (or no window at all):
  ## in this case the joysticks states are not updated automatically.


#--- SFML/Window/Keyboard ---#

type KeyCode* {.pure, size: sizeof(cint).} = enum  ## Key codes
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
  ## Check if a key is pressed
  ## 
  ## *Arguments*:
  ## - ``key``:  Key to check
  ## 
  ## *Returns:* sfTrue if the key is pressed, sfFalse otherwise


#--- SFML/Window/Mouse ---#

type MouseButton* {.pure, size: sizeof(cint).} = enum  ## Mouse buttons
  Left, Right, Middle, XButton1, XButton2, Count

proc mouse_isButtonPressed*(button: MouseButton): IntBool {.
  cdecl, dynlib: lib, importc: "sfMouse_isButtonPressed".}
  ## Check if a mouse button is pressed
  ## 
  ## *Arguments*:
  ## - ``button``:  Button to check
  ## 
  ## *Returns:* sfTrue if the button is pressed, sfFalse otherwise

proc mouse_getPosition*(relativeTo: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfMouse_getPosition".}
  ## Get the current position of the mouse
  ## 
  ## This function returns the current position of the mouse
  ## cursor relative to the given window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``relativeTo``:  Reference window
  ## 
  ## *Returns:* Position of the mouse cursor, relative to the given window

proc mouse_setPosition*(position: Vector2i, relativeTo: Window) {.
  cdecl, dynlib: lib, importc: "sfMouse_setPosition".}
  ## Set the current position of the mouse
  ## 
  ## This function sets the current position of the mouse
  ## cursor relative to the given window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``position``:    New position of the mouse
  ## - ``relativeTo``:  Reference window

type EventType* {.pure, size: sizeof(cint).} = enum  ## Definition of all the event types
  Closed, Resized, LostFocus, GainedFocus, TextEntered, KeyPressed, KeyReleased,
  MouseWheelMoved, MouseButtonPressed, MouseButtonReleased, MouseMoved,
  MouseEntered, MouseLeft, JoystickButtonPressed, JoystickButtonReleased,
  JoystickMoved, JoystickConnected, JoystickDisconnected

type KeyEvent* {.pure, final.} = object
  ## Keyboard event parameters
  code*: KeyCode
  alt*: IntBool
  control*: IntBool
  shift*: IntBool
  system*: IntBool

type TextEvent* {.pure, final.} = object
  ## Text event parameters
  unicode*: uint32

type MouseMoveEvent* {.pure, final.} = object
  ## Mouse move event parameters
  x*: cint
  y*: cint

type MouseButtonEvent* {.pure, final.} = object
  ## Mouse buttons events parameters
  button*: MouseButton
  x*: cint
  y*: cint

type MouseWheelEvent* {.pure, final.} = object
  ## Mouse wheel events parameters
  delta*: cint
  x*: cint
  y*: cint

type JoystickMoveEvent* {.pure, final.} = object
  ## Joystick axis move event parameters
  joystickId*: cint
  axis*: JoystickAxis
  position*: cfloat

type JoystickButtonEvent* {.pure, final.} = object
  ## Joystick buttons events parameters
  joystickId*: cint
  button*: cint

type JoystickConnectEvent* {.pure, final.} = object
  ## Joystick connection/disconnection event parameters
  joystickId*: cint

type SizeEvent* {.pure, final.} = object
  ## Size events parameters
  width*: cint
  height*: cint

include csfml_union_event


#--- SFML/Window/VideoMode ---#

type VideoMode* {.pure, final.} = object
  ## sfVideoMode defines a video mode (width, height, bpp, frequency)
  ## and provides functions for getting modes supported
  ## by the display device
  width*: cint
  height*: cint
  bitsPerPixel*: cint

proc videoMode_getDesktopMode*(): VideoMode {.
  cdecl, dynlib: lib, importc: "sfVideoMode_getDesktopMode".}
  ## Get the current desktop video mode
  ## 
  ## *Returns:* Current desktop video mode

proc videoMode_getFullscreenModes*(count: ptr int): var VideoMode {.
  cdecl, dynlib: lib, importc: "sfVideoMode_getFullscreenModes".}
  ## Retrieve all the video modes supported in fullscreen mode
  ## 
  ## When creating a fullscreen window, the video mode is restricted
  ## to be compatible with what the graphics driver and monitor
  ## support. This function returns the complete list of all video
  ## modes that can be used in fullscreen mode.
  ## The returned array is sorted from best to worst, so that
  ## the first element will always give the best mode (higher
  ## width, height and bits-per-pixel).
  ## 
  ## *Arguments*:
  ## - ``count``:  Pointer to a variable that will be filled with the number of modes in the array
  ## 
  ## *Returns:* Pointer to an array containing all the supported fullscreen modes

proc valid*(mode: VideoMode): IntBool {.
  cdecl, dynlib: lib, importc: "sfVideoMode_isValid".}
  ## Tell whether or not a video mode is valid
  ## 
  ## The validity of video modes is only relevant when using
  ## fullscreen windows; otherwise any video mode can be used
  ## with no restriction.
  ## 
  ## *Arguments*:
  ## - ``mode``:  Video mode
  ## 
  ## *Returns:* sfTrue if the video mode is valid for fullscreen mode


#--- SFML/Window/Window ---#


#--- SFML/Window/WindowHandle ---#

type WindowStyle* {.pure, size: sizeof(cint).} = enum  ## Enumeration of window creation styles
  None = 0, Titlebar = 1, Resize = 2, Close = 4, Default = 7, Fullscreen = 8

type ContextSettings* {.pure, final.} = object
  ## Structure defining the window's creation settings
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
  ## Construct a new window
  ## 
  ## This function creates the window with the size and pixel
  ## depth defined in ``mode``. An optional style can be passed to
  ## customize the look and behaviour of the window (borders,
  ## title bar, resizable, closable, ...). If ``style`` contains
  ## sfFullscreen, then ``mode`` must be a valid video mode.
  ## 
  ## The fourth parameter is a pointer to a structure specifying
  ## advanced OpenGL context settings such as antialiasing,
  ## depth-buffer bits, etc.
  ## 
  ## *Arguments*:
  ## - ``mode``:      Video mode to use (defines the width, height and depth of the rendering area of the window)
  ## - ``title``:     Title of the window
  ## - ``style``:     Window style
  ## - ``settings``:  Additional settings for the underlying OpenGL context
  ## 
  ## *Returns:* A new sfWindow object

proc newWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, dynlib: lib, importc: "sfWindow_createUnicode".}
proc newWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: ContextSettings): Window =
  (var Csettings = settings)
  newWindow(mode, title, style, Csettings)
  ## Construct a new window (with a UTF-32 title)
  ## 
  ## This function creates the window with the size and pixel
  ## depth defined in ``mode``. An optional style can be passed to
  ## customize the look and behaviour of the window (borders,
  ## title bar, resizable, closable, ...). If ``style`` contains
  ## sfFullscreen, then ``mode`` must be a valid video mode.
  ## 
  ## The fourth parameter is a pointer to a structure specifying
  ## advanced OpenGL context settings such as antialiasing,
  ## depth-buffer bits, etc.
  ## 
  ## *Arguments*:
  ## - ``mode``:      Video mode to use (defines the width, height and depth of the rendering area of the window)
  ## - ``title``:     Title of the window (UTF-32)
  ## - ``style``:     Window style
  ## - ``settings``:  Additional settings for the underlying OpenGL context
  ## 
  ## *Returns:* A new sfWindow object

proc newWindow*(handle: WindowHandle, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, dynlib: lib, importc: "sfWindow_createFromHandle".}
proc newWindow*(handle: WindowHandle, settings: ContextSettings): Window =
  (var Csettings = settings)
  newWindow(handle, Csettings)
  ## Construct a window from an existing control
  ## 
  ## Use this constructor if you want to create an OpenGL
  ## rendering area into an already existing control.
  ## 
  ## The second parameter is a pointer to a structure specifying
  ## advanced OpenGL context settings such as antialiasing,
  ## depth-buffer bits, etc.
  ## 
  ## *Arguments*:
  ## - ``handle``:    Platform-specific handle of the control
  ## - ``settings``:  Additional settings for the underlying OpenGL context
  ## 
  ## *Returns:* A new sfWindow object

proc destroy*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_destroy".}
  ## Destroy a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window to destroy

proc close*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_close".}
  ## Close a window and destroy all the attached resources
  ## 
  ## After calling this function, the sfWindow object remains
  ## valid, you must call sfWindow_destroy to actually delete it.
  ## All other functions such as sfWindow_pollEvent or sfWindow_display
  ## will still work (i.e. you don't have to test sfWindow_isOpen
  ## every time), and will have no effect on closed windows.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object

proc open*(window: Window): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_isOpen".}
  ## Tell whether or not a window is opened
  ## 
  ## This function returns whether or not the window exists.
  ## Note that a hidden window (sfWindow_setVisible(sfFalse)) will return
  ## sfTrue.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* sfTrue if the window is opened, sfFalse if it has been closed

proc settings*(window: Window): ContextSettings {.
  cdecl, dynlib: lib, importc: "sfWindow_getSettings".}
  ## Get the settings of the OpenGL context of a window
  ## 
  ## Note that these settings may be different from what was
  ## passed to the sfWindow_create function,
  ## if one or more settings were not supported. In this case,
  ## SFML chose the closest match.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* Structure containing the OpenGL context settings

proc pollEvent*(window: Window, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_pollEvent".}
  ## Pop the event on top of event queue, if any, and return it
  ## 
  ## This function is not blocking: if there's no pending event then
  ## it will return false and leave ``event`` unmodified.
  ## Note that more than one event may be present in the event queue,
  ## thus you should always call this function in a loop
  ## to make sure that you process every pending event.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``event``:   Event to be returned
  ## 
  ## *Returns:* sfTrue if an event was returned, or sfFalse if the event queue was empty

proc waitEvent*(window: Window, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_waitEvent".}
  ## Wait for an event and return it
  ## 
  ## This function is blocking: if there's no pending event then
  ## it will wait until an event is received.
  ## After this function returns (and no error occured),
  ## the ``event`` object is always valid and filled properly.
  ## This function is typically used when you have a thread that
  ## is dedicated to events handling: you want to make this thread
  ## sleep as long as no new event is received.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``event``:   Event to be returned
  ## 
  ## *Returns:* sfFalse if any error occured

proc position*(window: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfWindow_getPosition".}
  ## Get the position of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* Position in pixels

proc `position=`*(window: Window, position: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfWindow_setPosition".}
  ## Change the position of a window on screen
  ## 
  ## This function only works for top-level windows
  ## (i.e. it will be ignored for windows created from
  ## the handle of a child window/control).
  ## 
  ## *Arguments*:
  ## - ``window``:    Window object
  ## - ``position``:  New position of the window, in pixels

proc size*(window: Window): Vector2i {.
  cdecl, dynlib: lib, importc: "sfWindow_getSize".}
  ## Get the size of the rendering region of a window
  ## 
  ## The size doesn't include the titlebar and borders
  ## of the window.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* Size in pixels

proc `size=`*(window: Window, size: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfWindow_setSize".}
  ## Change the size of the rendering region of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``size``:    New size, in pixels

proc `title=`*(window: Window, title: cstring) {.
  cdecl, dynlib: lib, importc: "sfWindow_setTitle".}
  ## Change the title of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``title``:   New title

proc `unicodeTitle=`*(window: Window, title: ptr uint32) {.
  cdecl, dynlib: lib, importc: "sfWindow_setUnicodeTitle".}
  ## Change the title of a window (with a UTF-32 string)
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``title``:   New title

proc setIcon*(window: Window, width: cint, height: cint, pixels: ptr uint8) {.
  cdecl, dynlib: lib, importc: "sfWindow_setIcon".}
  ## Change a window's icon
  ## 
  ## ``pixels`` must be an array of ``width`` x ``height`` pixels
  ## in 32-bits RGBA format.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``width``:   Icon's width, in pixels
  ## - ``height``:  Icon's height, in pixels
  ## - ``pixels``:  Pointer to the array of pixels in memory

proc `visible=`*(window: Window, visible: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setVisible".}
  ## Show or hide a window
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``visible``:  sfTrue to show the window, sfFalse to hide it

proc `mouseCursorVisible=`*(window: Window, visible: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setMouseCursorVisible".}
  ## Show or hide the mouse cursor
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``visible``:  sfTrue to show, sfFalse to hide

proc `verticalSyncEnabled=`*(window: Window, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setVerticalSyncEnabled".}
  ## Enable or disable vertical synchronization
  ## 
  ## Activating vertical synchronization will limit the number
  ## of frames displayed to the refresh rate of the monitor.
  ## This can avoid some visual artifacts, and limit the framerate
  ## to a good value (but not constant across different computers).
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``enabled``:  sfTrue to enable v-sync, sfFalse to deactivate

proc `keyRepeatEnabled=`*(window: Window, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfWindow_setKeyRepeatEnabled".}
  ## Enable or disable automatic key-repeat
  ## 
  ## If key repeat is enabled, you will receive repeated
  ## KeyPress events while keeping a key pressed. If it is disabled,
  ## you will only get a single event when the key is pressed.
  ## 
  ## Key repeat is enabled by default.
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``enabled``:  sfTrue to enable, sfFalse to disable

proc `active=`*(window: Window, active: IntBool): IntBool {.
  cdecl, dynlib: lib, importc: "sfWindow_setActive".}
  ## Activate or deactivate a window as the current target
  ## for OpenGL rendering
  ## 
  ## A window is active only on the current thread, if you want to
  ## make it active on another thread you have to deactivate it
  ## on the previous thread first if it was active.
  ## Only one window can be active on a thread at a time, thus
  ## the window previously active (if any) automatically gets deactivated.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``active``:  sfTrue to activate, sfFalse to deactivate
  ## 
  ## *Returns:* sfTrue if operation was successful, sfFalse otherwise

proc display*(window: Window) {.
  cdecl, dynlib: lib, importc: "sfWindow_display".}
  ## Display on screen what has been rendered to the
  ## window so far
  ## 
  ## This function is typically called after all OpenGL rendering
  ## has been done for the current frame, in order to show
  ## it on screen.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object

proc `framerateLimit=`*(window: Window, limit: cint) {.
  cdecl, dynlib: lib, importc: "sfWindow_setFramerateLimit".}
  ## Limit the framerate to a maximum fixed frequency
  ## 
  ## If a limit is set, the window will use a small delay after
  ## each call to sfWindow_display to ensure that the current frame
  ## lasted long enough to match the framerate limit.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``limit``:   Framerate limit, in frames per seconds (use 0 to disable limit)

proc `joystickThreshold=`*(window: Window, threshold: cfloat) {.
  cdecl, dynlib: lib, importc: "sfWindow_setJoystickThreshold".}
  ## Change the joystick threshold
  ## 
  ## The joystick threshold is the value below which
  ## no JoyMoved event will be generated.
  ## 
  ## *Arguments*:
  ## - ``window``:     Window object
  ## - ``threshold``:  New threshold, in the range [0, 100]

proc systemHandle*(window: Window): WindowHandle {.
  cdecl, dynlib: lib, importc: "sfWindow_getSystemHandle".}
  ## Get the OS-specific handle of the window
  ## 
  ## The type of the returned handle is sfWindowHandle,
  ## which is a typedef to the handle type defined by the OS.
  ## You shouldn't need to use this function, unless you have
  ## very specific stuff to implement that SFML doesn't support,
  ## or implement a temporary workaround until a bug is fixed.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* System handle of the window
