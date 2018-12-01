
#--- SFML/Window ---#


#--- SFML/Window/Clipboard ---#


#--- SFML/Window/Types ---#

type Context* = ptr object

type Cursor* = ptr object

type Window* = ptr object

proc clipboard_getStr*(): cstring {.
  cdecl, importc: "sfClipboard_getString".}
  ## Get the content of the clipboard as string data (returns an ANSI string)
  ## 
  ## This function returns the content of the clipboard
  ## as a string. If the clipboard does not contain string
  ## it returns an empty string.
  ## 
  ## *Returns:* Clipboard contents as a locale-dependent ANSI string

proc clipboard_getUnicodeStr_U32(): StringU32 {.
  cdecl, importc: "sfClipboard_getUnicodeString".}
  ## Get the content of the clipboard as string data (returns a Unicode string)
  ## 
  ## This function returns the content of the clipboard
  ## as a string. If the clipboard does not contain string
  ## it returns an empty string.
  ## 
  ## *Returns:* Clipboard contents as UTF-32

proc clipboard_setStr*(text: cstring) {.
  cdecl, importc: "sfClipboard_setString".}
  ## Set the content of the clipboard as ANSI string data
  ## 
  ## This function sets the content of the clipboard as an
  ## ANSI string.
  ## 
  ## *Arguments*:
  ## - ``text``:  ANSI string containing the data to be sent
  ## to the clipboard

proc clipboard_setUnicodeStr_U32(text: StringU32) {.
  cdecl, importc: "sfClipboard_setUnicodeString".}
  ## Set the content of the clipboard as Unicode string data
  ## 
  ## This function sets the content of the clipboard as a
  ## Unicode string.
  ## 
  ## *Arguments*:
  ## - ``text``:  Unicode string containing the data to be sent
  ## to the clipboard


#--- SFML/Window/Context ---#


#--- SFML/Window/Window ---#


#--- SFML/Window/Event ---#


#--- SFML/Window/Joystick ---#


#--- SFML/Window/JoystickIdentification ---#

type JoystickIdentification* {.bycopy.} = object
  name*: cstring
  vendorId*: cint
  productId*: cint

const
  JoystickCount* = 8
  JoystickButtonCount* = 32
  JoystickAxisCount* = 8

type JoystickAxis* {.pure, size: sizeof(cint).} = enum  ## Axes supported by SFML joysticks
  X, Y, Z, R, U, V, PovX, PovY

proc joystick_isConnected*(joystick: cint): BoolInt {.
  cdecl, importc: "sfJoystick_isConnected".}
  ## Check if a joystick is connected
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick to check
  ## 
  ## *Returns:* True if the joystick is connected, False otherwise

proc joystick_getButtonCount*(joystick: cint): cint {.
  cdecl, importc: "sfJoystick_getButtonCount".}
  ## Return the number of buttons supported by a joystick
  ## 
  ## If the joystick is not connected, this function returns 0.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## 
  ## *Returns:* Number of buttons supported by the joystick

proc joystick_hasAxis*(joystick: cint, axis: JoystickAxis): BoolInt {.
  cdecl, importc: "sfJoystick_hasAxis".}
  ## Check if a joystick supports a given axis
  ## 
  ## If the joystick is not connected, this function returns false.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``axis``:      Axis to check
  ## 
  ## *Returns:* True if the joystick supports the axis, False otherwise

proc joystick_isButtonPressed*(joystick: cint, button: cint): BoolInt {.
  cdecl, importc: "sfJoystick_isButtonPressed".}
  ## Check if a joystick button is pressed
  ## 
  ## If the joystick is not connected, this function returns false.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``button``:    Button to check
  ## 
  ## *Returns:* True if the button is pressed, False otherwise

proc joystick_getAxisPosition*(joystick: cint, axis: JoystickAxis): cfloat {.
  cdecl, importc: "sfJoystick_getAxisPosition".}
  ## Get the current position of a joystick axis
  ## 
  ## If the joystick is not connected, this function returns 0.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## - ``axis``:      Axis to check
  ## 
  ## *Returns:* Current position of the axis, in range [-100 .. 100]

proc joystick_getIdentification*(joystick: cint): JoystickIdentification {.
  cdecl, importc: "sfJoystick_getIdentification".}
  ## Get the joystick information
  ## 
  ## The result of this function will only remain valid until
  ## the next time the function is called.
  ## 
  ## *Arguments*:
  ## - ``joystick``:  Index of the joystick
  ## 
  ## *Returns:* Structure containing joystick information.

proc joystick_update*() {.
  cdecl, importc: "sfJoystick_update".}
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
  Menu, LBracket, RBracket, Semicolon, Comma, Period, Quote, Slash, Backslash,
  Tilde, Equal, Hyphen, Space, Enter, Backspace, Tab, PageUp, PageDown, End,
  Home, Insert, Delete, Add, Subtract, Multiply, Divide, Left, Right, Up, Down,
  Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6, Numpad7,
  Numpad8, Numpad9, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
  F15, Pause, Count

proc keyboard_isKeyPressed*(key: KeyCode): BoolInt {.
  cdecl, importc: "sfKeyboard_isKeyPressed".}
  ## Check if a key is pressed
  ## 
  ## *Arguments*:
  ## - ``key``:  Key to check
  ## 
  ## *Returns:* True if the key is pressed, False otherwise

proc keyboard_setVirtualKeyboardVisible*(visible: BoolInt) {.
  cdecl, importc: "sfKeyboard_setVirtualKeyboardVisible".}
  ## Show or hide the virtual keyboard.
  ## 
  ## Warning: the virtual keyboard is not supported on all systems.
  ## It will typically be implemented on mobile OSes (Android, iOS)
  ## but not on desktop OSes (Windows, Linux, ...).
  ## 
  ## If the virtual keyboard is not available, this function does nothing.
  ## 
  ## *Arguments*:
  ## - ``visible``:  True to show, false to hide


#--- SFML/Window/Mouse ---#

type MouseButton* {.pure, size: sizeof(cint).} = enum  ## Mouse buttons
  Left, Right, Middle, XButton1, XButton2, Count

type MouseWheel* {.pure, size: sizeof(cint).} = enum  ## Mouse wheels
  VerticalWheel, HorizontalWheel

proc mouse_isButtonPressed*(button: MouseButton): BoolInt {.
  cdecl, importc: "sfMouse_isButtonPressed".}
  ## Check if a mouse button is pressed
  ## 
  ## *Arguments*:
  ## - ``button``:  Button to check
  ## 
  ## *Returns:* True if the button is pressed, False otherwise

proc mouse_getPosition*(relativeTo: Window): Vector2i {.
  cdecl, importc: "sfMouse_getPosition".}
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
  cdecl, importc: "sfMouse_setPosition".}
  ## Set the current position of the mouse
  ## 
  ## This function sets the current position of the mouse
  ## cursor relative to the given window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``position``:    New position of the mouse
  ## - ``relativeTo``:  Reference window


#--- SFML/Window/Sensor ---#

type SensorType* {.pure, size: sizeof(cint).} = enum  ## Sensor Types
  Accelerometer, Gyroscope, Magnetometer, Gravity, UserAcceleration,
  Orientation, Count

proc sensor_isAvailable*(sensor: SensorType): BoolInt {.
  cdecl, importc: "sfSensor_isAvailable".}
  ## Check if a sensor is available on the underlying platform
  ## 
  ## *Arguments*:
  ## - ``sensor``:  Sensor to check
  ## 
  ## *Returns:* True if the sensor is available, False otherwise

proc sensor_setEnabled*(sensor: SensorType, enabled: BoolInt) {.
  cdecl, importc: "sfSensor_setEnabled".}
  ## Enable or disable a sensor
  ## 
  ## All sensors are disabled by default, to avoid consuming too
  ## much battery power. Once a sensor is enabled, it starts
  ## sending events of the corresponding type.
  ## 
  ## This function does nothing if the sensor is unavailable.
  ## 
  ## *Arguments*:
  ## - ``sensor``:  Sensor to enable
  ## - ``enabled``:  True to enable, False to disable

proc sensor_getValue*(sensor: SensorType): Vector3f {.
  cdecl, importc: "sfSensor_getValue".}
  ## Get the current sensor value
  ## 
  ## *Arguments*:
  ## - ``sensor``:  Sensor to read
  ## 
  ## *Returns:* The current sensor value

type EventType* {.pure, size: sizeof(cint).} = enum  ## Definition of all the event types
  Closed, Resized, LostFocus, GainedFocus, TextEntered, KeyPressed, KeyReleased,
  MouseWheelMoved, MouseWheelScrolled, MouseButtonPressed, MouseButtonReleased,
  MouseMoved, MouseEntered, MouseLeft, JoystickButtonPressed,
  JoystickButtonReleased, JoystickMoved, JoystickConnected,
  JoystickDisconnected, TouchBegan, TouchMoved, TouchEnded, SensorChanged, Count

type KeyEvent* {.bycopy.} = object
  ## Keyboard event parameters
  code*: KeyCode
  alt*: BoolInt
  control*: BoolInt
  shift*: BoolInt
  system*: BoolInt

type TextEvent* {.bycopy.} = object
  ## Text event parameters
  unicode*: RuneU32

type MouseMoveEvent* {.bycopy.} = object
  ## Mouse move event parameters
  x*: cint
  y*: cint

type MouseButtonEvent* {.bycopy.} = object
  ## Mouse buttons events parameters
  button*: MouseButton
  x*: cint
  y*: cint

type MouseWheelEvent* {.bycopy.} = object
  ## Mouse wheel events parameters
  ## 
  ## \deprecated
  ## Use MouseWheelScrollEvent instead.
  delta*: cint
  x*: cint
  y*: cint

type MouseWheelScrollEvent* {.bycopy.} = object
  ## Mouse wheel events parameters
  wheel*: MouseWheel
  delta*: cfloat
  x*: cint
  y*: cint

type JoystickMoveEvent* {.bycopy.} = object
  ## Joystick axis move event parameters
  joystickId*: cint
  axis*: JoystickAxis
  position*: cfloat

type JoystickButtonEvent* {.bycopy.} = object
  ## Joystick buttons events parameters
  joystickId*: cint
  button*: cint

type JoystickConnectEvent* {.bycopy.} = object
  ## Joystick connection/disconnection event parameters
  joystickId*: cint

type SizeEvent* {.bycopy.} = object
  ## Size events parameters
  width*: cint
  height*: cint

type TouchEvent* {.bycopy.} = object
  ## Touch events parameters
  finger*: cint
  x*: cint
  y*: cint

type SensorEvent* {.bycopy.} = object
  ## Sensor event parameters
  sensorType*: SensorType
  x*: cfloat
  y*: cfloat
  z*: cfloat

include union_event


#--- SFML/Window/VideoMode ---#

type VideoMode* {.bycopy.} = object
  ## VideoMode defines a video mode (width, height, bpp, frequency)
  ## and provides functions for getting modes supported
  ## by the display device
  width*: cint
  height*: cint
  bitsPerPixel*: cint

proc videoMode_getDesktopMode*(): VideoMode {.
  cdecl, importc: "sfVideoMode_getDesktopMode".}
  ## Get the current desktop video mode
  ## 
  ## *Returns:* Current desktop video mode

proc videoMode_getFullscreenModes*(count: ptr int): ptr VideoMode {.
  cdecl, importc: "sfVideoMode_getFullscreenModes".}
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

proc valid*(mode: VideoMode): BoolInt {.
  cdecl, importc: "sfVideoMode_isValid".}
  ## Tell whether or not a video mode is valid
  ## 
  ## The validity of video modes is only relevant when using
  ## fullscreen windows; otherwise any video mode can be used
  ## with no restriction.
  ## 
  ## *Arguments*:
  ## - ``mode``:  Video mode
  ## 
  ## *Returns:* True if the video mode is valid for fullscreen mode


#--- SFML/Window/WindowHandle ---#

type WindowStyle* {.pure, size: sizeof(cint).} = enum  ## Enumeration of window creation styles
  None = 0, Titlebar = 1, Resize = 2, Close = 4, Default = 7, Fullscreen = 8

type ContextAttribute* {.pure, size: sizeof(cint).} = enum  ## Enumeration of the context attribute flags
  Default = 0, Core = 1, Debug = 4

type ContextSettings* {.bycopy.} = object
  ## Structure defining the window's creation settings
  depthBits*: cint
  stencilBits*: cint
  antialiasingLevel*: cint
  majorVersion*: cint
  minorVersion*: cint
  attributeFlags*: BitMaskU32
  sRgbCapable*: BoolInt

proc newWindowC*(mode: VideoMode, title: cstring, style: BitMaskU32, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, importc: "sfWindow_create".}
proc newWindowC*(mode: VideoMode, title: cstring, style: BitMaskU32, settings: ContextSettings): Window =
  ## Construct a new window
  ## 
  ## This function creates the window with the size and pixel
  ## depth defined in ``mode``. An optional style can be passed to
  ## customize the look and behaviour of the window (borders,
  ## title bar, resizable, closable, ...). If ``style`` contains
  ## Fullscreen, then ``mode`` must be a valid video mode.
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
  ## *Returns:* A new Window object
  (var Csettings = settings)
  newWindowC(mode, title, style, Csettings)

proc newWindow_U32(mode: VideoMode, title: StringU32, style: BitMaskU32, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, importc: "sfWindow_createUnicode".}
proc newWindow_U32(mode: VideoMode, title: StringU32, style: BitMaskU32, settings: ContextSettings): Window =
  ## Construct a new window (with a UTF-32 title)
  ## 
  ## This function creates the window with the size and pixel
  ## depth defined in ``mode``. An optional style can be passed to
  ## customize the look and behaviour of the window (borders,
  ## title bar, resizable, closable, ...). If ``style`` contains
  ## Fullscreen, then ``mode`` must be a valid video mode.
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
  ## *Returns:* A new Window object
  (var Csettings = settings)
  newWindow_U32(mode, title, style, Csettings)

proc newWindow*(handle: WindowHandle, settings: (var ContextSettings){lvalue}): Window {.
  cdecl, importc: "sfWindow_createFromHandle".}
proc newWindow*(handle: WindowHandle, settings: ContextSettings): Window =
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
  ## *Returns:* A new Window object
  (var Csettings = settings)
  newWindow(handle, Csettings)

proc destroy*(window: Window) {.
  cdecl, importc: "sfWindow_destroy".}
  ## Destroy a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window to destroy

proc close*(window: Window) {.
  cdecl, importc: "sfWindow_close".}
  ## Close a window and destroy all the attached resources
  ## 
  ## After calling this function, the Window object remains
  ## valid, you must call Window_destroy to actually delete it.
  ## All other functions such as Window_pollEvent or Window_display
  ## will still work (i.e. you don't have to test Window_isOpen
  ## every time), and will have no effect on closed windows.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object

proc open*(window: Window): BoolInt {.
  cdecl, importc: "sfWindow_isOpen".}
  ## Tell whether or not a window is opened
  ## 
  ## This function returns whether or not the window exists.
  ## Note that a hidden window (Window_setVisible(False)) will return
  ## True.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* True if the window is opened, False if it has been closed

proc settings*(window: Window): ContextSettings {.
  cdecl, importc: "sfWindow_getSettings".}
  ## Get the settings of the OpenGL context of a window
  ## 
  ## Note that these settings may be different from what was
  ## passed to the Window_create function,
  ## if one or more settings were not supported. In this case,
  ## SFML chose the closest match.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* Structure containing the OpenGL context settings

proc pollEvent*(window: Window, event: var Event): BoolInt {.
  cdecl, importc: "sfWindow_pollEvent".}
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
  ## *Returns:* True if an event was returned, or False if the event queue was empty

proc waitEvent*(window: Window, event: var Event): BoolInt {.
  cdecl, importc: "sfWindow_waitEvent".}
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
  ## *Returns:* False if any error occured

proc position*(window: Window): Vector2i {.
  cdecl, importc: "sfWindow_getPosition".}
  ## Get the position of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* Position in pixels

proc `position=`*(window: Window, position: Vector2i) {.
  cdecl, importc: "sfWindow_setPosition".}
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
  cdecl, importc: "sfWindow_getSize".}
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
  cdecl, importc: "sfWindow_setSize".}
  ## Change the size of the rendering region of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``size``:    New size, in pixels

proc `titleC=`*(window: Window, title: cstring) {.
  cdecl, importc: "sfWindow_setTitle".}
  ## Change the title of a window
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``title``:   New title

proc `title_U32=`(window: Window, title: StringU32) {.
  cdecl, importc: "sfWindow_setUnicodeTitle".}
  ## Change the title of a window (with a UTF-32 string)
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``title``:   New title

proc setIcon*(window: Window, width: cint, height: cint, pixels: ptr uint8) {.
  cdecl, importc: "sfWindow_setIcon".}
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

proc `visible=`*(window: Window, visible: BoolInt) {.
  cdecl, importc: "sfWindow_setVisible".}
  ## Show or hide a window
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``visible``:  True to show the window, False to hide it

proc `verticalSyncEnabled=`*(window: Window, enabled: BoolInt) {.
  cdecl, importc: "sfWindow_setVerticalSyncEnabled".}
  ## Enable or disable vertical synchronization
  ## 
  ## Activating vertical synchronization will limit the number
  ## of frames displayed to the refresh rate of the monitor.
  ## This can avoid some visual artifacts, and limit the framerate
  ## to a good value (but not constant across different computers).
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``enabled``:  True to enable v-sync, False to deactivate

proc `mouseCursorVisible=`*(window: Window, visible: BoolInt) {.
  cdecl, importc: "sfWindow_setMouseCursorVisible".}
  ## Show or hide the mouse cursor
  ## 
  ## *Arguments*:
  ## - ``window``:   Window object
  ## - ``visible``:  True to show, False to hide

proc `mouseCursorGrabbed=`*(window: Window, grabbed: BoolInt) {.
  cdecl, importc: "sfWindow_setMouseCursorGrabbed".}
  ## Grab or release the mouse cursor
  ## 
  ## If set, grabs the mouse cursor inside this window's client
  ## area so it may no longer be moved outside its bounds.
  ## Note that grabbing is only active while the window has
  ## focus and calling this function for fullscreen windows
  ## won't have any effect (fullscreen windows always grab the
  ## cursor).
  ## 
  ## *Arguments*:
  ## - ``grabbed``:  True to enable, False to disable

proc `mouseCursor=`*(window: Window, cursor: Cursor) {.
  cdecl, importc: "sfWindow_setMouseCursor".}
  ## Set the displayed cursor to a native system cursor
  ## 
  ## Upon window creation, the arrow cursor is used by default.
  ## 
  ## \warning The cursor must not be destroyed while in use by
  ## the window.
  ## 
  ## \warning Features related to Cursor are not supported on
  ## iOS and Android.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``cursor``:  Native system cursor type to display
  ## 
  ## \see Cursor_createFromSystem
  ## \see Cursor_createFromPixels

proc `keyRepeatEnabled=`*(window: Window, enabled: BoolInt) {.
  cdecl, importc: "sfWindow_setKeyRepeatEnabled".}
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
  ## - ``enabled``:  True to enable, False to disable

proc `framerateLimit=`*(window: Window, limit: cint) {.
  cdecl, importc: "sfWindow_setFramerateLimit".}
  ## Limit the framerate to a maximum fixed frequency
  ## 
  ## If a limit is set, the window will use a small delay after
  ## each call to Window_display to ensure that the current frame
  ## lasted long enough to match the framerate limit.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``limit``:   Framerate limit, in frames per seconds (use 0 to disable limit)

proc `joystickThreshold=`*(window: Window, threshold: cfloat) {.
  cdecl, importc: "sfWindow_setJoystickThreshold".}
  ## Change the joystick threshold
  ## 
  ## The joystick threshold is the value below which
  ## no JoyMoved event will be generated.
  ## 
  ## *Arguments*:
  ## - ``window``:     Window object
  ## - ``threshold``:  New threshold, in the range [0, 100]

proc `active=`*(window: Window, active: BoolInt): BoolInt {.
  cdecl, importc: "sfWindow_setActive".}
  ## Activate or deactivate a window as the current target
  ## for OpenGL rendering
  ## 
  ## A window is active only on the current thread, if you want to
  ## make it active on another thread you have to deactivate it
  ## on the previous thread first if it was active.
  ## Only one window can be active on a thread at a time, thus
  ## the window previously active (if any) automatically gets deactivated.
  ## This is not to be confused with Window_requestFocus().
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## - ``active``:  True to activate, False to deactivate
  ## 
  ## *Returns:* True if operation was successful, False otherwise

proc requestFocus*(window: Window) {.
  cdecl, importc: "sfWindow_requestFocus".}
  ## Request the current window to be made the active
  ## foreground window
  ## 
  ## At any given time, only one window may have the input focus
  ## to receive input events such as keystrokes or mouse events.
  ## If a window requests focus, it only hints to the operating
  ## system, that it would like to be focused. The operating system
  ## is free to deny the request.
  ## This is not to be confused with Window_setActive().

proc hasFocus*(window: Window): BoolInt {.
  cdecl, importc: "sfWindow_hasFocus".}
  ## Check whether the window has the input focus
  ## 
  ## At any given time, only one window may have the input focus
  ## to receive input events such as keystrokes or most mouse
  ## events.
  ## 
  ## *Returns:* True if window has focus, false otherwise

proc display*(window: Window) {.
  cdecl, importc: "sfWindow_display".}
  ## Display on screen what has been rendered to the
  ## window so far
  ## 
  ## This function is typically called after all OpenGL rendering
  ## has been done for the current frame, in order to show
  ## it on screen.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object

proc systemHandle*(window: Window): WindowHandle {.
  cdecl, importc: "sfWindow_getSystemHandle".}
  ## Get the OS-specific handle of the window
  ## 
  ## The type of the returned handle is WindowHandle,
  ## which is a typedef to the handle type defined by the OS.
  ## You shouldn't need to use this function, unless you have
  ## very specific stuff to implement that SFML doesn't support,
  ## or implement a temporary workaround until a bug is fixed.
  ## 
  ## *Arguments*:
  ## - ``window``:  Window object
  ## 
  ## *Returns:* System handle of the window

proc newContext*(): Context {.
  cdecl, importc: "sfContext_create".}
  ## Create a new context
  ## 
  ## This function activates the new context.
  ## 
  ## *Returns:* New Context object

proc destroy*(context: Context) {.
  cdecl, importc: "sfContext_destroy".}
  ## Destroy a context
  ## 
  ## *Arguments*:
  ## - ``context``:  Context to destroy

proc `active=`*(context: Context, active: BoolInt): BoolInt {.
  cdecl, importc: "sfContext_setActive".}
  ## Activate or deactivate explicitely a context
  ## 
  ## *Arguments*:
  ## - ``context``:  Context object
  ## - ``active``:   True to activate, False to deactivate
  ## 
  ## *Returns:* True on success, False on failure

proc settings*(context: Context): ContextSettings {.
  cdecl, importc: "sfContext_getSettings".}
  ## Get the settings of the context.
  ## 
  ## Note that these settings may be different than the ones passed to the
  ## constructor; they are indeed adjusted if the original settings are not
  ## directly supported by the system.
  ## 
  ## *Returns:* Structure containing the settings

proc context_getActiveContextId*(): uint64 {.
  cdecl, importc: "sfContext_getActiveContextId".}
  ## Get the currently active context's ID
  ## 
  ## The context ID is used to identify contexts when
  ## managing unshareable OpenGL resources.
  ## 
  ## *Returns:* The active context's ID or 0 if no context is currently active


#--- SFML/Window/Cursor ---#

type CursorType* {.pure, size: sizeof(cint).} = enum  ## Enumeration of the native system cursor types
  ## 
  ## Refer to the following table to determine which cursor
  ## is available on which platform.
  ## 
  ## Type                               | Linux | Mac OS X | Windows
  ## ------------------------------------|:-----:|:--------:|:--------:
  ## CursorArrow                  |  yes  |    yes   |   yes
  ## CursorArrowWait              |  no   |    no    |   yes
  ## CursorWait                   |  yes  |    no    |   yes
  ## CursorText                   |  yes  |    yes   |   yes
  ## CursorHand                   |  yes  |    yes   |   yes
  ## CursorSizeHorizontal         |  yes  |    yes   |   yes
  ## CursorSizeVertical           |  yes  |    yes   |   yes
  ## CursorSizeTopLeftBottomRight |  no   |    no    |   yes
  ## CursorSizeBottomLeftTopRight |  no   |    no    |   yes
  ## CursorSizeAll                |  yes  |    no    |   yes
  ## CursorCross                  |  yes  |    yes   |   yes
  ## CursorHelp                   |  yes  |    no    |   yes
  ## CursorNotAllowed             |  yes  |    yes   |   yes
  Arrow, ArrowWait, Wait, Text, Hand, SizeHorizontal, SizeVertical,
  SizeTopLeftBottomRight, SizeBottomLeftTopRight, SizeAll, Cross, Help,
  NotAllowed

proc newCursor*(pixels: ptr uint8, size: Vector2i, hotspot: Vector2i): Cursor {.
  cdecl, importc: "sfCursor_createFromPixels".}
  ## Create a cursor with the provided image
  ## 
  ## ``pixels`` must be an array of ``width`` by ``height`` pixels
  ## in 32-bit RGBA format. If not, this will cause undefined behavior.
  ## 
  ## If ``pixels`` is null or either ``width`` or ``height`` are 0,
  ## the current cursor is left unchanged and the function will
  ## return false.
  ## 
  ## In addition to specifying the pixel data, you can also
  ## specify the location of the hotspot of the cursor. The
  ## hotspot is the pixel coordinate within the cursor image
  ## which will be located exactly where the mouse pointer
  ## position is. Any mouse actions that are performed will
  ## return the window/screen location of the hotspot.
  ## 
  ## \warning On Unix, the pixels are mapped into a monochrome
  ## bitmap: pixels with an alpha channel to 0 are
  ## transparent, black if the RGB channel are close
  ## to zero, and white otherwise.
  ## 
  ## *Arguments*:
  ## - ``pixels``:    Array of pixels of the image
  ## - ``size``:      Width and height of the image
  ## - ``hotspot``:   (x,y) location of the hotspot
  ## *Returns:* A new Cursor object

proc newCursor*(kind: CursorType): Cursor {.
  cdecl, importc: "sfCursor_createFromSystem".}
  ## Create a native system cursor
  ## 
  ## Refer to the list of cursor available on each system
  ## (see CursorType) to know whether a given cursor is
  ## expected to load successfully or is not supported by
  ## the operating system.
  ## 
  ## *Arguments*:
  ## - ``type``:  Native system cursor type
  ## *Returns:* A new Cursor object

proc destroy*(cursor: Cursor) {.
  cdecl, importc: "sfCursor_destroy".}
  ## Destroy a cursor
  ## 
  ## *Arguments*:
  ## - ``cursor``:  Cursor to destroy


#--- SFML/Window/Touch ---#

proc touch_isDown*(finger: cint): BoolInt {.
  cdecl, importc: "sfTouch_isDown".}
  ## Check if a touch event is currently down
  ## 
  ## *Arguments*:
  ## - ``finger``:  Finger index
  ## 
  ## *Returns:* True if ``finger`` is currently touching the screen, False otherwise

proc touch_getPosition*(finger: cint, relativeTo: Window): Vector2i {.
  cdecl, importc: "sfTouch_getPosition".}
  ## Get the current position of a touch in window coordinates
  ## 
  ## This function returns the current touch position
  ## relative to the given window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``finger``:  Finger index
  ## - ``relativeTo``:  Reference window
  ## 
  ## *Returns:* Current position of ``finger``, or undefined if it's not down
