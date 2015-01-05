
#--- SFML/System ---#


#--- SFML/System/Clock ---#


#--- SFML/System/Time ---#

type Time* = object
  ## Represents a time value
  microseconds*: int64

proc asSeconds*(time: Time): cfloat {.
  cdecl, importc: "sfTime_asSeconds".}
  ## Return a time value as a number of seconds
  ## 
  ## *Arguments*:
  ## - ``time``:  Time value
  ## 
  ## *Returns:* Time in seconds

proc asMilliseconds*(time: Time): int32 {.
  cdecl, importc: "sfTime_asMilliseconds".}
  ## Return a time value as a number of milliseconds
  ## 
  ## *Arguments*:
  ## - ``time``:  Time value
  ## 
  ## *Returns:* Time in milliseconds

proc asMicroseconds*(time: Time): int64 {.
  cdecl, importc: "sfTime_asMicroseconds".}
  ## Return a time value as a number of microseconds
  ## 
  ## *Arguments*:
  ## - ``time``:  Time value
  ## 
  ## *Returns:* Time in microseconds

proc seconds*(amount: cfloat): Time {.
  cdecl, importc: "sfSeconds".}
  ## Construct a time value from a number of seconds
  ## 
  ## *Arguments*:
  ## - ``amount``:  Number of seconds
  ## 
  ## *Returns:* Time value constructed from the amount of seconds

proc milliseconds*(amount: int32): Time {.
  cdecl, importc: "sfMilliseconds".}
  ## Construct a time value from a number of milliseconds
  ## 
  ## *Arguments*:
  ## - ``amount``:  Number of milliseconds
  ## 
  ## *Returns:* Time value constructed from the amount of milliseconds

proc microseconds*(amount: int64): Time {.
  cdecl, importc: "sfMicroseconds".}
  ## Construct a time value from a number of microseconds
  ## 
  ## *Arguments*:
  ## - ``amount``:  Number of microseconds
  ## 
  ## *Returns:* Time value constructed from the amount of microseconds


#--- SFML/System/Types ---#

type
  Clock* = ptr object

type
  Mutex* = ptr object

type
  Thread* = ptr object

proc newClock*(): Clock {.
  cdecl, importc: "sfClock_create".}
  ## Create a new clock and start it
  ## 
  ## *Returns:* A new Clock object

proc copy*(clock: Clock): Clock {.
  cdecl, importc: "sfClock_copy".}
  ## Create a new clock by copying an existing one
  ## 
  ## *Arguments*:
  ## - ``clock``:  Clock to copy
  ## 
  ## *Returns:* A new Clock object which is a copy of ``clock``

proc destroy*(clock: Clock) {.
  override, cdecl, importc: "sfClock_destroy".}
  ## Destroy a clock
  ## 
  ## *Arguments*:
  ## - ``clock``:  Clock to destroy

proc elapsedTime*(clock: Clock): Time {.
  cdecl, importc: "sfClock_getElapsedTime".}
  ## Get the time elapsed in a clock
  ## 
  ## This function returns the time elapsed since the last call
  ## to Clock_restart (or the construction of the object if
  ## Clock_restart has not been called).
  ## 
  ## *Arguments*:
  ## - ``clock``:  Clock object
  ## 
  ## *Returns:* Time elapsed

proc restart*(clock: Clock): Time {.
  cdecl, importc: "sfClock_restart".}
  ## Restart a clock
  ## 
  ## This function puts the time counter back to zero.
  ## It also returns the time elapsed since the clock was started.
  ## 
  ## *Arguments*:
  ## - ``clock``:  Clock object
  ## 
  ## *Returns:* Time elapsed


#--- SFML/System/InputStream ---#

type InputStreamReadFunc* = proc(data: pointer; size: int64; userData: pointer): int64 {.cdecl.}

type InputStreamSeekFunc* = proc(position: int64; userData: pointer): int64 {.cdecl.}

type InputStreamTellFunc* = proc(userData: pointer): int64 {.cdecl.}

type InputStreamGetSizeFunc* = proc(userData: pointer): int64 {.cdecl.}

type InputStream* = object
  ## Set of callbacks that allow users to define custom file streams
  read*: InputStreamReadFunc
  seek*: InputStreamSeekFunc
  tell*: InputStreamTellFunc
  getSize*: InputStreamGetSizeFunc
  userData*: pointer


#--- SFML/System/Sleep ---#

proc sleep*(duration: Time) {.
  cdecl, importc: "sfSleep".}
  ## Make the current thread sleep for a given duration
  ## 
  ## Sleep is the best way to block a program or one of its
  ## threads, as it doesn't consume any CPU power.
  ## 
  ## *Arguments*:
  ## - ``duration``:  Time to sleep


#--- SFML/System/Vector2 ---#

type Vector2i* = object
  ## 2-component vector of integers
  x*: cint
  y*: cint

type Vector2f* = object
  ## 2-component vector of floats
  x*: cfloat
  y*: cfloat


#--- SFML/System/Vector3 ---#

type Vector3f* = object
  ## 3-component vector of floats
  x*: cfloat
  y*: cfloat
  z*: cfloat
