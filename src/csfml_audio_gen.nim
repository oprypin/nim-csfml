
#--- SFML/Audio ---#


#--- SFML/Audio/Listener ---#

proc listener_setGlobalVolume*(volume: cfloat) {.
  cdecl, dynlib: lib, importc: "sfListener_setGlobalVolume".}

proc listener_getGlobalVolume*(): cfloat {.
  cdecl, dynlib: lib, importc: "sfListener_getGlobalVolume".}

proc listener_setPosition*(position: Vector3f) {.
  cdecl, dynlib: lib, importc: "sfListener_setPosition".}

proc listener_getPosition*(): Vector3f {.
  cdecl, dynlib: lib, importc: "sfListener_getPosition".}

proc listener_setDirection*(orientation: Vector3f) {.
  cdecl, dynlib: lib, importc: "sfListener_setDirection".}

proc listener_getDirection*(): Vector3f {.
  cdecl, dynlib: lib, importc: "sfListener_getDirection".}


#--- SFML/Audio/Music ---#


#--- SFML/Audio/SoundStatus ---#

type SoundStatus* {.pure, size: sizeof(cint).} = enum
  Stopped, Paused, Playing


#--- SFML/Audio/Types ---#

type
  Music* = ptr TMusic
  TMusic {.pure, final.} = object

type
  Sound* = ptr TSound
  TSound {.pure, final.} = object

type
  SoundBuffer* = ptr TSoundBuffer
  TSoundBuffer {.pure, final.} = object

type
  SoundBufferRecorder* = ptr TSoundBufferRecorder
  TSoundBufferRecorder {.pure, final.} = object

type
  SoundRecorder* = ptr TSoundRecorder
  TSoundRecorder {.pure, final.} = object

type
  SoundStream* = ptr TSoundStream
  TSoundStream {.pure, final.} = object

proc newMusic*(filename: cstring): Music {.
  cdecl, dynlib: lib, importc: "sfMusic_createFromFile".}

proc newMusic*(data: pointer, sizeInBytes: int): Music {.
  cdecl, dynlib: lib, importc: "sfMusic_createFromMemory".}

proc newMusic*(stream: var InputStream): Music {.
  cdecl, dynlib: lib, importc: "sfMusic_createFromStream".}

proc destroy*(music: Music) {.
  cdecl, dynlib: lib, importc: "sfMusic_destroy".}

proc `loop=`*(music: Music, loop: IntBool) {.
  cdecl, dynlib: lib, importc: "sfMusic_setLoop".}

proc loop*(music: Music): IntBool {.
  cdecl, dynlib: lib, importc: "sfMusic_getLoop".}

proc duration*(music: Music): Time {.
  cdecl, dynlib: lib, importc: "sfMusic_getDuration".}

proc play*(music: Music) {.
  cdecl, dynlib: lib, importc: "sfMusic_play".}

proc pause*(music: Music) {.
  cdecl, dynlib: lib, importc: "sfMusic_pause".}

proc stop*(music: Music) {.
  cdecl, dynlib: lib, importc: "sfMusic_stop".}

proc channelCount*(music: Music): cint {.
  cdecl, dynlib: lib, importc: "sfMusic_getChannelCount".}

proc sampleRate*(music: Music): cint {.
  cdecl, dynlib: lib, importc: "sfMusic_getSampleRate".}

proc status*(music: Music): SoundStatus {.
  cdecl, dynlib: lib, importc: "sfMusic_getStatus".}

proc playingOffset*(music: Music): Time {.
  cdecl, dynlib: lib, importc: "sfMusic_getPlayingOffset".}

proc `pitch=`*(music: Music, pitch: cfloat) {.
  cdecl, dynlib: lib, importc: "sfMusic_setPitch".}

proc `volume=`*(music: Music, volume: cfloat) {.
  cdecl, dynlib: lib, importc: "sfMusic_setVolume".}

proc `position=`*(music: Music, position: Vector3f) {.
  cdecl, dynlib: lib, importc: "sfMusic_setPosition".}

proc `relativeToListener=`*(music: Music, relative: IntBool) {.
  cdecl, dynlib: lib, importc: "sfMusic_setRelativeToListener".}

proc `minDistance=`*(music: Music, distance: cfloat) {.
  cdecl, dynlib: lib, importc: "sfMusic_setMinDistance".}

proc `attenuation=`*(music: Music, attenuation: cfloat) {.
  cdecl, dynlib: lib, importc: "sfMusic_setAttenuation".}

proc `playingOffset=`*(music: Music, timeOffset: Time) {.
  cdecl, dynlib: lib, importc: "sfMusic_setPlayingOffset".}

proc pitch*(music: Music): cfloat {.
  cdecl, dynlib: lib, importc: "sfMusic_getPitch".}

proc volume*(music: Music): cfloat {.
  cdecl, dynlib: lib, importc: "sfMusic_getVolume".}

proc position*(music: Music): Vector3f {.
  cdecl, dynlib: lib, importc: "sfMusic_getPosition".}

proc relativeToListener*(music: Music): IntBool {.
  cdecl, dynlib: lib, importc: "sfMusic_isRelativeToListener".}

proc minDistance*(music: Music): cfloat {.
  cdecl, dynlib: lib, importc: "sfMusic_getMinDistance".}

proc attenuation*(music: Music): cfloat {.
  cdecl, dynlib: lib, importc: "sfMusic_getAttenuation".}


#--- SFML/Audio/Sound ---#

proc newSound*(): Sound {.
  cdecl, dynlib: lib, importc: "sfSound_create".}

proc copy*(sound: Sound): Sound {.
  cdecl, dynlib: lib, importc: "sfSound_copy".}

proc destroy*(sound: Sound) {.
  cdecl, dynlib: lib, importc: "sfSound_destroy".}

proc play*(sound: Sound) {.
  cdecl, dynlib: lib, importc: "sfSound_play".}

proc pause*(sound: Sound) {.
  cdecl, dynlib: lib, importc: "sfSound_pause".}

proc stop*(sound: Sound) {.
  cdecl, dynlib: lib, importc: "sfSound_stop".}

proc `buffer=`*(sound: Sound, buffer: SoundBuffer) {.
  cdecl, dynlib: lib, importc: "sfSound_setBuffer".}

proc buffer*(sound: Sound): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSound_getBuffer".}

proc `loop=`*(sound: Sound, loop: IntBool) {.
  cdecl, dynlib: lib, importc: "sfSound_setLoop".}

proc loop*(sound: Sound): IntBool {.
  cdecl, dynlib: lib, importc: "sfSound_getLoop".}

proc status*(sound: Sound): SoundStatus {.
  cdecl, dynlib: lib, importc: "sfSound_getStatus".}

proc `pitch=`*(sound: Sound, pitch: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSound_setPitch".}

proc `volume=`*(sound: Sound, volume: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSound_setVolume".}

proc `position=`*(sound: Sound, position: Vector3f) {.
  cdecl, dynlib: lib, importc: "sfSound_setPosition".}

proc `relativeToListener=`*(sound: Sound, relative: IntBool) {.
  cdecl, dynlib: lib, importc: "sfSound_setRelativeToListener".}

proc `minDistance=`*(sound: Sound, distance: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSound_setMinDistance".}

proc `attenuation=`*(sound: Sound, attenuation: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSound_setAttenuation".}

proc `playingOffset=`*(sound: Sound, timeOffset: Time) {.
  cdecl, dynlib: lib, importc: "sfSound_setPlayingOffset".}

proc pitch*(sound: Sound): cfloat {.
  cdecl, dynlib: lib, importc: "sfSound_getPitch".}

proc volume*(sound: Sound): cfloat {.
  cdecl, dynlib: lib, importc: "sfSound_getVolume".}

proc position*(sound: Sound): Vector3f {.
  cdecl, dynlib: lib, importc: "sfSound_getPosition".}

proc relativeToListener*(sound: Sound): IntBool {.
  cdecl, dynlib: lib, importc: "sfSound_isRelativeToListener".}

proc minDistance*(sound: Sound): cfloat {.
  cdecl, dynlib: lib, importc: "sfSound_getMinDistance".}

proc attenuation*(sound: Sound): cfloat {.
  cdecl, dynlib: lib, importc: "sfSound_getAttenuation".}

proc playingOffset*(sound: Sound): Time {.
  cdecl, dynlib: lib, importc: "sfSound_getPlayingOffset".}


#--- SFML/Audio/SoundBuffer ---#

proc newSoundBuffer*(filename: cstring): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_createFromFile".}

proc newSoundBuffer*(data: pointer, sizeInBytes: int): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_createFromMemory".}

proc newSoundBuffer*(stream: var InputStream): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_createFromStream".}

proc newSoundBuffer*(samples: ptr int16, sampleCount: int, channelCount: cint, sampleRate: cint): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_createFromSamples".}

proc copy*(soundBuffer: SoundBuffer): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_copy".}

proc destroy*(soundBuffer: SoundBuffer) {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_destroy".}

proc saveToFile*(soundBuffer: SoundBuffer, filename: cstring): IntBool {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_saveToFile".}

proc samples*(soundBuffer: SoundBuffer): ptr int16 {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_getSamples".}

proc sampleCount*(soundBuffer: SoundBuffer): int {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_getSampleCount".}

proc sampleRate*(soundBuffer: SoundBuffer): cint {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_getSampleRate".}

proc channelCount*(soundBuffer: SoundBuffer): cint {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_getChannelCount".}

proc duration*(soundBuffer: SoundBuffer): Time {.
  cdecl, dynlib: lib, importc: "sfSoundBuffer_getDuration".}


#--- SFML/Audio/SoundBufferRecorder ---#

proc newSoundBufferRecorder*(): SoundBufferRecorder {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_create".}

proc destroy*(soundBufferRecorder: SoundBufferRecorder) {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_destroy".}

proc start*(soundBufferRecorder: SoundBufferRecorder, sampleRate: cint) {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_start".}

proc stop*(soundBufferRecorder: SoundBufferRecorder) {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_stop".}

proc sampleRate*(soundBufferRecorder: SoundBufferRecorder): cint {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_getSampleRate".}

proc buffer*(soundBufferRecorder: SoundBufferRecorder): SoundBuffer {.
  cdecl, dynlib: lib, importc: "sfSoundBufferRecorder_getBuffer".}


#--- SFML/Audio/SoundRecorder ---#

type SoundRecorderStartCallback* = proc(p1: pointer): IntBool {.cdecl.}

type SoundRecorderProcessCallback* = proc(p1: ptr int16; p2: int; p3: pointer): IntBool {.cdecl.}

type SoundRecorderStopCallback* = proc(p1: pointer): void {.cdecl.}

proc newSoundRecorder*(onStart: SoundRecorderStartCallback, onProcess: SoundRecorderProcessCallback, onStop: SoundRecorderStopCallback, userData: pointer): SoundRecorder {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_create".}

proc destroy*(soundRecorder: SoundRecorder) {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_destroy".}

proc start*(soundRecorder: SoundRecorder, sampleRate: cint) {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_start".}

proc stop*(soundRecorder: SoundRecorder) {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_stop".}

proc sampleRate*(soundRecorder: SoundRecorder): cint {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_getSampleRate".}

proc soundRecorder_isAvailable*(): IntBool {.
  cdecl, dynlib: lib, importc: "sfSoundRecorder_isAvailable".}
