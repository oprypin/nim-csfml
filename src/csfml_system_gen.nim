
#--- SFML/System ---#


#--- SFML/System/Clock ---#


#--- SFML/System/Time ---#

type Time* {.pure, final.} = object
  microseconds*: int64

proc asSeconds*(time: Time): cfloat {.
  cdecl, dynlib: lib, importc: "sfTime_asSeconds".}

proc asMilliseconds*(time: Time): int32 {.
  cdecl, dynlib: lib, importc: "sfTime_asMilliseconds".}

proc asMicroseconds*(time: Time): int64 {.
  cdecl, dynlib: lib, importc: "sfTime_asMicroseconds".}

proc seconds*(amount: cfloat): Time {.
  cdecl, dynlib: lib, importc: "sfSeconds".}

proc milliseconds*(amount: int32): Time {.
  cdecl, dynlib: lib, importc: "sfMilliseconds".}

proc microseconds*(amount: int64): Time {.
  cdecl, dynlib: lib, importc: "sfMicroseconds".}


#--- SFML/System/Types ---#

type
  Clock* = ptr TClock
  TClock {.pure, final.} = object

type
  Mutex* = ptr TMutex
  TMutex {.pure, final.} = object

type
  Thread* = ptr TThread
  TThread {.pure, final.} = object

proc newClock*(): Clock {.
  cdecl, dynlib: lib, importc: "sfClock_create".}

proc copy*(clock: Clock): Clock {.
  cdecl, dynlib: lib, importc: "sfClock_copy".}

proc destroy*(clock: Clock) {.
  cdecl, dynlib: lib, importc: "sfClock_destroy".}

proc elapsedTime*(clock: Clock): Time {.
  cdecl, dynlib: lib, importc: "sfClock_getElapsedTime".}

proc restart*(clock: Clock): Time {.
  cdecl, dynlib: lib, importc: "sfClock_restart".}


#--- SFML/System/InputStream ---#

type InputStreamReadFunc* = proc(data: pointer; size: int64; userData: pointer): int64 {.cdecl.}

type InputStreamSeekFunc* = proc(position: int64; userData: pointer): int64 {.cdecl.}

type InputStreamTellFunc* = proc(userData: pointer): int64 {.cdecl.}

type InputStreamGetSizeFunc* = proc(userData: pointer): int64 {.cdecl.}

type InputStream* {.pure, final.} = object
  read*: InputStreamReadFunc
  seek*: InputStreamSeekFunc
  tell*: InputStreamTellFunc
  getSize*: InputStreamGetSizeFunc
  userData*: pointer


#--- SFML/System/Sleep ---#

proc sleep*(duration: Time) {.
  cdecl, dynlib: lib, importc: "sfSleep".}


#--- SFML/System/Vector2 ---#

type Vector2i* {.pure, final.} = object
  x*: cint
  y*: cint

type Vector2f* {.pure, final.} = object
  x*: cfloat
  y*: cfloat


#--- SFML/System/Vector3 ---#

type Vector3f* {.pure, final.} = object
  x*: cfloat
  y*: cfloat
  z*: cfloat
