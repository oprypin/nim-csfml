
#--- SFML/Audio ---#


#--- SFML/Audio/Listener ---#

proc listener_setGlobalVolume*(volume: cfloat) {.
  cdecl, importc: "sfListener_setGlobalVolume".}
  ## Change the global volume of all the sounds and musics
  ## 
  ## The volume is a number between 0 and 100; it is combined with
  ## the individual volume of each sound / music.
  ## The default value for the volume is 100 (maximum).
  ## 
  ## *Arguments*:
  ## - ``volume``:  New global volume, in the range [0, 100]

proc listener_getGlobalVolume*(): cfloat {.
  cdecl, importc: "sfListener_getGlobalVolume".}
  ## Get the current value of the global volume
  ## 
  ## *Returns:* Current global volume, in the range [0, 100]

proc listener_setPosition*(position: Vector3f) {.
  cdecl, importc: "sfListener_setPosition".}
  ## Set the position of the listener in the scene
  ## 
  ## The default listener's position is (0, 0, 0).
  ## 
  ## *Arguments*:
  ## - ``position``:  New position of the listener

proc listener_getPosition*(): Vector3f {.
  cdecl, importc: "sfListener_getPosition".}
  ## Get the current position of the listener in the scene
  ## 
  ## *Returns:* The listener's position

proc listener_setDirection*(direction: Vector3f) {.
  cdecl, importc: "sfListener_setDirection".}
  ## Set the orientation of the forward vector in the scene
  ## 
  ## The direction (also called "at vector") is the vector
  ## pointing forward from the listener's perspective. Together
  ## with the up vector, it defines the 3D orientation of the
  ## listener in the scene. The direction vector doesn't
  ## have to be normalized.
  ## The default listener's direction is (0, 0, -1).
  ## 
  ## *Arguments*:
  ## - ``direction``:  New listener's direction

proc listener_getDirection*(): Vector3f {.
  cdecl, importc: "sfListener_getDirection".}
  ## Get the current forward vector of the listener in the scene
  ## 
  ## *Returns:* Listener's forward vector (not normalized)

proc listener_setUpVector*(upVector: Vector3f) {.
  cdecl, importc: "sfListener_setUpVector".}
  ## Set the upward vector of the listener in the scene
  ## 
  ## The up vector is the vector that points upward from the
  ## listener's perspective. Together with the direction, it
  ## defines the 3D orientation of the listener in the scene.
  ## The up vector doesn't have to be normalized.
  ## The default listener's up vector is (0, 1, 0). It is usually
  ## not necessary to change it, especially in 2D scenarios.
  ## 
  ## *Arguments*:
  ## - ``upVector``:  New listener's up vector

proc listener_getUpVector*(): Vector3f {.
  cdecl, importc: "sfListener_getUpVector".}
  ## Get the current upward vector of the listener in the scene
  ## 
  ## *Returns:* Listener's upward vector (not normalized)


#--- SFML/Audio/Music ---#


#--- SFML/Audio/SoundStatus ---#

type SoundStatus* {.pure, size: sizeof(cint).} = enum  ## Enumeration of statuses for sounds and musics
  Stopped, Paused, Playing


#--- SFML/Audio/Types ---#

type Music* = ptr object

type Sound* = ptr object

type SoundBuffer* = ptr object

type SoundBufferRecorder* = ptr object

type SoundRecorder* = ptr object

type SoundStream* = ptr object

proc newMusic*(filename: cstring): Music {.
  cdecl, importc: "sfMusic_createFromFile".}
  ## Create a new music and load it from a file
  ## 
  ## This function doesn't start playing the music (call
  ## Music_play to do so).
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``filename``:  Path of the music file to open
  ## 
  ## *Returns:* A new Music object (NULL if failed)

proc newMusic*(data: pointer, sizeInBytes: int): Music {.
  cdecl, importc: "sfMusic_createFromMemory".}
  ## Create a new music and load it from a file in memory
  ## 
  ## This function doesn't start playing the music (call
  ## Music_play to do so).
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``data``:         Pointer to the file data in memory
  ## - ``sizeInBytes``:  Size of the data to load, in bytes
  ## 
  ## *Returns:* A new Music object (NULL if failed)

proc newMusic*(stream: var InputStream): Music {.
  cdecl, importc: "sfMusic_createFromStream".}
  ## Create a new music and load it from a custom stream
  ## 
  ## This function doesn't start playing the music (call
  ## Music_play to do so).
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``stream``:  Source stream to read from
  ## 
  ## *Returns:* A new Music object (NULL if failed)

proc destroy*(music: Music) {.
  destroy, cdecl, importc: "sfMusic_destroy".}
  ## Destroy a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music to destroy

proc `loop=`*(music: Music, loop: BoolInt) {.
  cdecl, importc: "sfMusic_setLoop".}
  ## Set whether or not a music should loop after reaching the end
  ## 
  ## If set, the music will restart from beginning after
  ## reaching the end and so on, until it is stopped or
  ## Music_setLoop(music, False) is called.
  ## The default looping state for musics is false.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## - ``loop``:   True to play in loop, False to play once

proc loop*(music: Music): BoolInt {.
  cdecl, importc: "sfMusic_getLoop".}
  ## Tell whether or not a music is in loop mode
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* True if the music is looping, False otherwise

proc duration*(music: Music): Time {.
  cdecl, importc: "sfMusic_getDuration".}
  ## Get the total duration of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Music duration

proc play*(music: Music) {.
  cdecl, importc: "sfMusic_play".}
  ## Start or resume playing a music
  ## 
  ## This function starts the music if it was stopped, resumes
  ## it if it was paused, and restarts it from beginning if it
  ## was it already playing.
  ## This function uses its own thread so that it doesn't block
  ## the rest of the program while the music is played.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object

proc pause*(music: Music) {.
  cdecl, importc: "sfMusic_pause".}
  ## Pause a music
  ## 
  ## This function pauses the music if it was playing,
  ## otherwise (music already paused or stopped) it has no effect.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object

proc stop*(music: Music) {.
  cdecl, importc: "sfMusic_stop".}
  ## Stop playing a music
  ## 
  ## This function stops the music if it was playing or paused,
  ## and does nothing if it was already stopped.
  ## It also resets the playing position (unlike Music_pause).
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object

proc channelCount*(music: Music): cint {.
  cdecl, importc: "sfMusic_getChannelCount".}
  ## Return the number of channels of a music
  ## 
  ## 1 channel means a mono sound, 2 means stereo, etc.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Number of channels

proc sampleRate*(music: Music): cint {.
  cdecl, importc: "sfMusic_getSampleRate".}
  ## Get the sample rate of a music
  ## 
  ## The sample rate is the number of audio samples played per
  ## second. The higher, the better the quality.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Sample rate, in number of samples per second

proc status*(music: Music): SoundStatus {.
  cdecl, importc: "sfMusic_getStatus".}
  ## Get the current status of a music (stopped, paused, playing)
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Current status

proc playingOffset*(music: Music): Time {.
  cdecl, importc: "sfMusic_getPlayingOffset".}
  ## Get the current playing position of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Current playing position

proc `pitch=`*(music: Music, pitch: cfloat) {.
  cdecl, importc: "sfMusic_setPitch".}
  ## Set the pitch of a music
  ## 
  ## The pitch represents the perceived fundamental frequency
  ## of a sound; thus you can make a music more acute or grave
  ## by changing its pitch. A side effect of changing the pitch
  ## is to modify the playing speed of the music as well.
  ## The default value for the pitch is 1.
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## - ``pitch``:  New pitch to apply to the music

proc `volume=`*(music: Music, volume: cfloat) {.
  cdecl, importc: "sfMusic_setVolume".}
  ## Set the volume of a music
  ## 
  ## The volume is a value between 0 (mute) and 100 (full volume).
  ## The default value for the volume is 100.
  ## 
  ## *Arguments*:
  ## - ``music``:   Music object
  ## - ``volume``:  Volume of the music

proc `position=`*(music: Music, position: Vector3f) {.
  cdecl, importc: "sfMusic_setPosition".}
  ## Set the 3D position of a music in the audio scene
  ## 
  ## Only musics with one channel (mono musics) can be
  ## spatialized.
  ## The default position of a music is (0, 0, 0).
  ## 
  ## *Arguments*:
  ## - ``music``:     Music object
  ## - ``position``:  Position of the music in the scene

proc `relativeToListener=`*(music: Music, relative: BoolInt) {.
  cdecl, importc: "sfMusic_setRelativeToListener".}
  ## Make a musics's position relative to the listener or absolute
  ## 
  ## Making a music relative to the listener will ensure that it will always
  ## be played the same way regardless the position of the listener.
  ## This can be useful for non-spatialized musics, musics that are
  ## produced by the listener, or musics attached to it.
  ## The default value is false (position is absolute).
  ## 
  ## *Arguments*:
  ## - ``music``:     Music object
  ## - ``relative``:  True to set the position relative, False to set it absolute

proc `minDistance=`*(music: Music, distance: cfloat) {.
  cdecl, importc: "sfMusic_setMinDistance".}
  ## Set the minimum distance of a music
  ## 
  ## The "minimum distance" of a music is the maximum
  ## distance at which it is heard at its maximum volume. Further
  ## than the minimum distance, it will start to fade out according
  ## to its attenuation factor. A value of 0 ("inside the head
  ## of the listener") is an invalid value and is forbidden.
  ## The default value of the minimum distance is 1.
  ## 
  ## *Arguments*:
  ## - ``music``:     Music object
  ## - ``distance``:  New minimum distance of the music

proc `attenuation=`*(music: Music, attenuation: cfloat) {.
  cdecl, importc: "sfMusic_setAttenuation".}
  ## Set the attenuation factor of a music
  ## 
  ## The attenuation is a multiplicative factor which makes
  ## the music more or less loud according to its distance
  ## from the listener. An attenuation of 0 will produce a
  ## non-attenuated music, i.e. its volume will always be the same
  ## whether it is heard from near or from far. On the other hand,
  ## an attenuation value such as 100 will make the music fade out
  ## very quickly as it gets further from the listener.
  ## The default value of the attenuation is 1.
  ## 
  ## *Arguments*:
  ## - ``music``:        Music object
  ## - ``attenuation``:  New attenuation factor of the music

proc `playingOffset=`*(music: Music, timeOffset: Time) {.
  cdecl, importc: "sfMusic_setPlayingOffset".}
  ## Change the current playing position of a music
  ## 
  ## The playing position can be changed when the music is
  ## either paused or playing.
  ## 
  ## *Arguments*:
  ## - ``music``:       Music object
  ## - ``timeOffset``:  New playing position

proc pitch*(music: Music): cfloat {.
  cdecl, importc: "sfMusic_getPitch".}
  ## Get the pitch of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Pitch of the music

proc volume*(music: Music): cfloat {.
  cdecl, importc: "sfMusic_getVolume".}
  ## Get the volume of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Volume of the music, in the range [0, 100]

proc position*(music: Music): Vector3f {.
  cdecl, importc: "sfMusic_getPosition".}
  ## Get the 3D position of a music in the audio scene
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Position of the music in the world

proc relativeToListener*(music: Music): BoolInt {.
  cdecl, importc: "sfMusic_isRelativeToListener".}
  ## Tell whether a music's position is relative to the
  ## listener or is absolute
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* True if the position is relative, False if it's absolute

proc minDistance*(music: Music): cfloat {.
  cdecl, importc: "sfMusic_getMinDistance".}
  ## Get the minimum distance of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Minimum distance of the music

proc attenuation*(music: Music): cfloat {.
  cdecl, importc: "sfMusic_getAttenuation".}
  ## Get the attenuation factor of a music
  ## 
  ## *Arguments*:
  ## - ``music``:  Music object
  ## 
  ## *Returns:* Attenuation factor of the music


#--- SFML/Audio/Sound ---#

proc newSound*(): Sound {.
  cdecl, importc: "sfSound_create".}
  ## Create a new sound
  ## 
  ## *Returns:* A new Sound object

proc copy*(sound: Sound): Sound {.
  cdecl, importc: "sfSound_copy".}
  ## Create a new sound by copying an existing one
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound to copy
  ## 
  ## *Returns:* A new Sound object which is a copy of ``sound``

proc destroy*(sound: Sound) {.
  destroy, cdecl, importc: "sfSound_destroy".}
  ## Destroy a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound to destroy

proc play*(sound: Sound) {.
  cdecl, importc: "sfSound_play".}
  ## Start or resume playing a sound
  ## 
  ## This function starts the sound if it was stopped, resumes
  ## it if it was paused, and restarts it from beginning if it
  ## was it already playing.
  ## This function uses its own thread so that it doesn't block
  ## the rest of the program while the sound is played.
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object

proc pause*(sound: Sound) {.
  cdecl, importc: "sfSound_pause".}
  ## Pause a sound
  ## 
  ## This function pauses the sound if it was playing,
  ## otherwise (sound already paused or stopped) it has no effect.
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object

proc stop*(sound: Sound) {.
  cdecl, importc: "sfSound_stop".}
  ## Stop playing a sound
  ## 
  ## This function stops the sound if it was playing or paused,
  ## and does nothing if it was already stopped.
  ## It also resets the playing position (unlike Sound_pause).
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object

proc `buffer=`*(sound: Sound, buffer: SoundBuffer) {.
  cdecl, importc: "sfSound_setBuffer".}
  ## Set the source buffer containing the audio data to play
  ## 
  ## It is important to note that the sound buffer is not copied,
  ## thus the SoundBuffer object must remain alive as long
  ## as it is attached to the sound.
  ## 
  ## *Arguments*:
  ## - ``sound``:   Sound object
  ## - ``buffer``:  Sound buffer to attach to the sound

proc buffer*(sound: Sound): SoundBuffer {.
  cdecl, importc: "sfSound_getBuffer".}
  ## Get the audio buffer attached to a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Sound buffer attached to the sound (can be NULL)

proc `loop=`*(sound: Sound, loop: BoolInt) {.
  cdecl, importc: "sfSound_setLoop".}
  ## Set whether or not a sound should loop after reaching the end
  ## 
  ## If set, the sound will restart from beginning after
  ## reaching the end and so on, until it is stopped or
  ## Sound_setLoop(sound, False) is called.
  ## The default looping state for sounds is false.
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## - ``loop``:   True to play in loop, False to play once

proc loop*(sound: Sound): BoolInt {.
  cdecl, importc: "sfSound_getLoop".}
  ## Tell whether or not a sound is in loop mode
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* True if the sound is looping, False otherwise

proc status*(sound: Sound): SoundStatus {.
  cdecl, importc: "sfSound_getStatus".}
  ## Get the current status of a sound (stopped, paused, playing)
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Current status

proc `pitch=`*(sound: Sound, pitch: cfloat) {.
  cdecl, importc: "sfSound_setPitch".}
  ## Set the pitch of a sound
  ## 
  ## The pitch represents the perceived fundamental frequency
  ## of a sound; thus you can make a sound more acute or grave
  ## by changing its pitch. A side effect of changing the pitch
  ## is to modify the playing speed of the sound as well.
  ## The default value for the pitch is 1.
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## - ``pitch``:  New pitch to apply to the sound

proc `volume=`*(sound: Sound, volume: cfloat) {.
  cdecl, importc: "sfSound_setVolume".}
  ## Set the volume of a sound
  ## 
  ## The volume is a value between 0 (mute) and 100 (full volume).
  ## The default value for the volume is 100.
  ## 
  ## *Arguments*:
  ## - ``sound``:   Sound object
  ## - ``volume``:  Volume of the sound

proc `position=`*(sound: Sound, position: Vector3f) {.
  cdecl, importc: "sfSound_setPosition".}
  ## Set the 3D position of a sound in the audio scene
  ## 
  ## Only sounds with one channel (mono sounds) can be
  ## spatialized.
  ## The default position of a sound is (0, 0, 0).
  ## 
  ## *Arguments*:
  ## - ``sound``:     Sound object
  ## - ``position``:  Position of the sound in the scene

proc `relativeToListener=`*(sound: Sound, relative: BoolInt) {.
  cdecl, importc: "sfSound_setRelativeToListener".}
  ## Make the sound's position relative to the listener or absolute
  ## 
  ## Making a sound relative to the listener will ensure that it will always
  ## be played the same way regardless the position of the listener.
  ## This can be useful for non-spatialized sounds, sounds that are
  ## produced by the listener, or sounds attached to it.
  ## The default value is false (position is absolute).
  ## 
  ## *Arguments*:
  ## - ``sound``:     Sound object
  ## - ``relative``:  True to set the position relative, False to set it absolute

proc `minDistance=`*(sound: Sound, distance: cfloat) {.
  cdecl, importc: "sfSound_setMinDistance".}
  ## Set the minimum distance of a sound
  ## 
  ## The "minimum distance" of a sound is the maximum
  ## distance at which it is heard at its maximum volume. Further
  ## than the minimum distance, it will start to fade out according
  ## to its attenuation factor. A value of 0 ("inside the head
  ## of the listener") is an invalid value and is forbidden.
  ## The default value of the minimum distance is 1.
  ## 
  ## *Arguments*:
  ## - ``sound``:     Sound object
  ## - ``distance``:  New minimum distance of the sound

proc `attenuation=`*(sound: Sound, attenuation: cfloat) {.
  cdecl, importc: "sfSound_setAttenuation".}
  ## Set the attenuation factor of a sound
  ## 
  ## The attenuation is a multiplicative factor which makes
  ## the sound more or less loud according to its distance
  ## from the listener. An attenuation of 0 will produce a
  ## non-attenuated sound, i.e. its volume will always be the same
  ## whether it is heard from near or from far. On the other hand,
  ## an attenuation value such as 100 will make the sound fade out
  ## very quickly as it gets further from the listener.
  ## The default value of the attenuation is 1.
  ## 
  ## *Arguments*:
  ## - ``sound``:        Sound object
  ## - ``attenuation``:  New attenuation factor of the sound

proc `playingOffset=`*(sound: Sound, timeOffset: Time) {.
  cdecl, importc: "sfSound_setPlayingOffset".}
  ## Change the current playing position of a sound
  ## 
  ## The playing position can be changed when the sound is
  ## either paused or playing.
  ## 
  ## *Arguments*:
  ## - ``sound``:       Sound object
  ## - ``timeOffset``:  New playing position

proc pitch*(sound: Sound): cfloat {.
  cdecl, importc: "sfSound_getPitch".}
  ## Get the pitch of a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Pitch of the sound

proc volume*(sound: Sound): cfloat {.
  cdecl, importc: "sfSound_getVolume".}
  ## Get the volume of a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Volume of the sound, in the range [0, 100]

proc position*(sound: Sound): Vector3f {.
  cdecl, importc: "sfSound_getPosition".}
  ## Get the 3D position of a sound in the audio scene
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Position of the sound in the world

proc relativeToListener*(sound: Sound): BoolInt {.
  cdecl, importc: "sfSound_isRelativeToListener".}
  ## Tell whether a sound's position is relative to the
  ## listener or is absolute
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* True if the position is relative, False if it's absolute

proc minDistance*(sound: Sound): cfloat {.
  cdecl, importc: "sfSound_getMinDistance".}
  ## Get the minimum distance of a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Minimum distance of the sound

proc attenuation*(sound: Sound): cfloat {.
  cdecl, importc: "sfSound_getAttenuation".}
  ## Get the attenuation factor of a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Attenuation factor of the sound

proc playingOffset*(sound: Sound): Time {.
  cdecl, importc: "sfSound_getPlayingOffset".}
  ## Get the current playing position of a sound
  ## 
  ## *Arguments*:
  ## - ``sound``:  Sound object
  ## 
  ## *Returns:* Current playing position


#--- SFML/Audio/SoundBuffer ---#

proc newSoundBuffer*(filename: cstring): SoundBuffer {.
  cdecl, importc: "sfSoundBuffer_createFromFile".}
  ## Create a new sound buffer and load it from a file
  ## 
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``filename``:  Path of the sound file to load
  ## 
  ## *Returns:* A new SoundBuffer object (NULL if failed)

proc newSoundBuffer*(data: pointer, sizeInBytes: int): SoundBuffer {.
  cdecl, importc: "sfSoundBuffer_createFromMemory".}
  ## Create a new sound buffer and load it from a file in memory
  ## 
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``data``:         Pointer to the file data in memory
  ## - ``sizeInBytes``:  Size of the data to load, in bytes
  ## 
  ## *Returns:* A new SoundBuffer object (NULL if failed)

proc newSoundBuffer*(stream: var InputStream): SoundBuffer {.
  cdecl, importc: "sfSoundBuffer_createFromStream".}
  ## Create a new sound buffer and load it from a custom stream
  ## 
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``stream``:  Source stream to read from
  ## 
  ## *Returns:* A new SoundBuffer object (NULL if failed)

proc newSoundBuffer*(samples: ptr int16, sampleCount: uint64, channelCount: cint, sampleRate: cint): SoundBuffer {.
  cdecl, importc: "sfSoundBuffer_createFromSamples".}
  ## Create a new sound buffer and load it from an array of samples in memory
  ## 
  ## The assumed format of the audio samples is 16 bits signed integer
  ## (Int16).
  ## 
  ## *Arguments*:
  ## - ``samples``:       Pointer to the array of samples in memory
  ## - ``sampleCount``:   Number of samples in the array
  ## - ``channelCount``:  Number of channels (1 = mono, 2 = stereo, ...)
  ## - ``sampleRate``:    Sample rate (number of samples to play per second)
  ## 
  ## *Returns:* A new SoundBuffer object (NULL if failed)

proc copy*(soundBuffer: SoundBuffer): SoundBuffer {.
  cdecl, importc: "sfSoundBuffer_copy".}
  ## Create a new sound buffer by copying an existing one
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer to copy
  ## 
  ## *Returns:* A new SoundBuffer object which is a copy of ``soundBuffer``

proc destroy*(soundBuffer: SoundBuffer) {.
  destroy, cdecl, importc: "sfSoundBuffer_destroy".}
  ## Destroy a sound buffer
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer to destroy

proc saveToFile*(soundBuffer: SoundBuffer, filename: cstring): BoolInt {.
  cdecl, importc: "sfSoundBuffer_saveToFile".}
  ## Save a sound buffer to an audio file
  ## 
  ## Here is a complete list of all the supported audio formats:
  ## ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
  ## w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## - ``filename``:     Path of the sound file to write
  ## 
  ## *Returns:* True if saving succeeded, False if it failed

proc samples*(soundBuffer: SoundBuffer): ptr int16 {.
  cdecl, importc: "sfSoundBuffer_getSamples".}
  ## Get the array of audio samples stored in a sound buffer
  ## 
  ## The format of the returned samples is 16 bits signed integer
  ## (Int16). The total number of samples in this array
  ## is given by the SoundBuffer_getSampleCount function.
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## 
  ## *Returns:* Read-only pointer to the array of sound samples

proc sampleCount*(soundBuffer: SoundBuffer): uint64 {.
  cdecl, importc: "sfSoundBuffer_getSampleCount".}
  ## Get the number of samples stored in a sound buffer
  ## 
  ## The array of samples can be accessed with the
  ## SoundBuffer_getSamples function.
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## 
  ## *Returns:* Number of samples

proc sampleRate*(soundBuffer: SoundBuffer): cint {.
  cdecl, importc: "sfSoundBuffer_getSampleRate".}
  ## Get the sample rate of a sound buffer
  ## 
  ## The sample rate is the number of samples played per second.
  ## The higher, the better the quality (for example, 44100
  ## samples/s is CD quality).
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## 
  ## *Returns:* Sample rate (number of samples per second)

proc channelCount*(soundBuffer: SoundBuffer): cint {.
  cdecl, importc: "sfSoundBuffer_getChannelCount".}
  ## Get the number of channels used by a sound buffer
  ## 
  ## If the sound is mono then the number of channels will
  ## be 1, 2 for stereo, etc.
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## 
  ## *Returns:* Number of channels

proc duration*(soundBuffer: SoundBuffer): Time {.
  cdecl, importc: "sfSoundBuffer_getDuration".}
  ## Get the total duration of a sound buffer
  ## 
  ## *Arguments*:
  ## - ``soundBuffer``:  Sound buffer object
  ## 
  ## *Returns:* Sound duration


#--- SFML/Audio/SoundBufferRecorder ---#

proc newSoundBufferRecorder*(): SoundBufferRecorder {.
  cdecl, importc: "sfSoundBufferRecorder_create".}
  ## Create a new sound buffer recorder
  ## 
  ## *Returns:* A new SoundBufferRecorder object (NULL if failed)

proc destroy*(soundBufferRecorder: SoundBufferRecorder) {.
  destroy, cdecl, importc: "sfSoundBufferRecorder_destroy".}
  ## Destroy a sound buffer recorder
  ## 
  ## *Arguments*:
  ## - ``soundBufferRecorder``:  Sound buffer recorder to destroy

proc start*(soundBufferRecorder: SoundBufferRecorder, sampleRate: cint) {.
  cdecl, importc: "sfSoundBufferRecorder_start".}
  ## Start the capture of a sound recorder recorder
  ## 
  ## The ``sampleRate`` parameter defines the number of audio samples
  ## captured per second. The higher, the better the quality
  ## (for example, 44100 samples/sec is CD quality).
  ## This function uses its own thread so that it doesn't block
  ## the rest of the program while the capture runs.
  ## Please note that only one capture can happen at the same time.
  ## 
  ## *Arguments*:
  ## - ``soundBufferRecorder``:  Sound buffer recorder object
  ## - ``sampleRate``:           Desired capture rate, in number of samples per second

proc stop*(soundBufferRecorder: SoundBufferRecorder) {.
  cdecl, importc: "sfSoundBufferRecorder_stop".}
  ## Stop the capture of a sound recorder
  ## 
  ## *Arguments*:
  ## - ``soundBufferRecorder``:  Sound buffer recorder object

proc sampleRate*(soundBufferRecorder: SoundBufferRecorder): cint {.
  cdecl, importc: "sfSoundBufferRecorder_getSampleRate".}
  ## Get the sample rate of a sound buffer recorder
  ## 
  ## The sample rate defines the number of audio samples
  ## captured per second. The higher, the better the quality
  ## (for example, 44100 samples/sec is CD quality).
  ## 
  ## *Arguments*:
  ## - ``soundBufferRecorder``:  Sound buffer recorder object
  ## 
  ## *Returns:* Sample rate, in samples per second

proc buffer*(soundBufferRecorder: SoundBufferRecorder): SoundBuffer {.
  cdecl, importc: "sfSoundBufferRecorder_getBuffer".}
  ## Get the sound buffer containing the captured audio data
  ## 
  ## The sound buffer is valid only after the capture has ended.
  ## This function provides a read-only access to the internal
  ## sound buffer, but it can be copied if you need to
  ## make any modification to it.
  ## 
  ## *Arguments*:
  ## - ``soundBufferRecorder``:  Sound buffer recorder object
  ## 
  ## *Returns:* Read-only access to the sound buffer


#--- SFML/Audio/SoundRecorder ---#

type SoundRecorderStartCallback* = proc(p1: pointer): BoolInt {.cdecl.}

type SoundRecorderProcessCallback* = proc(p1: ptr int16; p2: int; p3: pointer): BoolInt {.cdecl.}

type SoundRecorderStopCallback* = proc(p1: pointer): void {.cdecl.}

proc newSoundRecorder*(onStart: SoundRecorderStartCallback, onProcess: SoundRecorderProcessCallback, onStop: SoundRecorderStopCallback, userData: pointer): SoundRecorder {.
  cdecl, importc: "sfSoundRecorder_create".}
  ## Construct a new sound recorder from callback functions
  ## 
  ## *Arguments*:
  ## - ``onStart``:    Callback function which will be called when a new capture starts (can be NULL)
  ## - ``onProcess``:  Callback function which will be called each time there's audio data to process
  ## - ``onStop``:     Callback function which will be called when the current capture stops (can be NULL)
  ## - ``userData``:   Data to pass to the callback function (can be NULL)
  ## 
  ## *Returns:* A new SoundRecorder object (NULL if failed)

proc destroy*(soundRecorder: SoundRecorder) {.
  destroy, cdecl, importc: "sfSoundRecorder_destroy".}
  ## Destroy a sound recorder
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder to destroy

proc start*(soundRecorder: SoundRecorder, sampleRate: cint): BoolInt {.
  cdecl, importc: "sfSoundRecorder_start".}
  ## Start the capture of a sound recorder
  ## 
  ## The ``sampleRate`` parameter defines the number of audio samples
  ## captured per second. The higher, the better the quality
  ## (for example, 44100 samples/sec is CD quality).
  ## This function uses its own thread so that it doesn't block
  ## the rest of the program while the capture runs.
  ## Please note that only one capture can happen at the same time.
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object
  ## - ``sampleRate``:     Desired capture rate, in number of samples per second
  ## 
  ## *Returns:* True, if start of capture was successful

proc stop*(soundRecorder: SoundRecorder) {.
  cdecl, importc: "sfSoundRecorder_stop".}
  ## Stop the capture of a sound recorder
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object

proc sampleRate*(soundRecorder: SoundRecorder): cint {.
  cdecl, importc: "sfSoundRecorder_getSampleRate".}
  ## Get the sample rate of a sound recorder
  ## 
  ## The sample rate defines the number of audio samples
  ## captured per second. The higher, the better the quality
  ## (for example, 44100 samples/sec is CD quality).
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object
  ## 
  ## *Returns:* Sample rate, in samples per second

proc soundRecorder_isAvailable*(): BoolInt {.
  cdecl, importc: "sfSoundRecorder_isAvailable".}
  ## Check if the system supports audio capture
  ## 
  ## This function should always be called before using
  ## the audio capture features. If it returns false, then
  ## any attempt to use SoundRecorder will fail.
  ## 
  ## *Returns:* True if audio capture is supported, False otherwise

proc `processingInterval=`*(soundRecorder: SoundRecorder, interval: Time) {.
  cdecl, importc: "sfSoundRecorder_setProcessingInterval".}
  ## Set the processing interval
  ## 
  ## The processing interval controls the period
  ## between calls to the onProcessSamples function. You may
  ## want to use a small interval if you want to process the
  ## recorded data in real time, for example.
  ## 
  ## Note: this is only a hint, the actual period may vary.
  ## So don't rely on this parameter to implement precise timing.
  ## 
  ## The default processing interval is 100 ms.
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object
  ## - ``interval``:  Processing interval

proc soundRecorder_getAvailableDevices*(count: ptr int): ptr ptr char {.
  cdecl, importc: "sfSoundRecorder_getAvailableDevices".}
  ## Get a list of the names of all availabe audio capture devices
  ## 
  ## This function returns an array of strings (null terminated),
  ## containing the names of all availabe audio capture devices.
  ## If no devices are available then NULL is returned.
  ## 
  ## *Arguments*:
  ## - ``count``:  Pointer to a variable that will be filled with the number of modes in the array
  ## 
  ## *Returns:* An array of strings containing the names

proc soundRecorder_getDefaultDevice*(): cstring {.
  cdecl, importc: "sfSoundRecorder_getDefaultDevice".}
  ## Get the name of the default audio capture device
  ## 
  ## This function returns the name of the default audio
  ## capture device. If none is available, NULL is returned.
  ## 
  ## *Returns:* The name of the default audio capture device (null terminated)

proc `device=`*(soundRecorder: SoundRecorder, name: cstring): BoolInt {.
  cdecl, importc: "sfSoundRecorder_setDevice".}
  ## Set the audio capture device
  ## 
  ## This function sets the audio capture device to the device
  ## with the given name. It can be called on the fly (i.e:
  ## while recording). If you do so while recording and
  ## opening the device fails, it stops the recording.
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object
  ## - ``The``:  name of the audio capture device
  ## 
  ## *Returns:* True, if it was able to set the requested device

proc device*(soundRecorder: SoundRecorder): cstring {.
  cdecl, importc: "sfSoundRecorder_getDevice".}
  ## Get the name of the current audio capture device
  ## 
  ## *Arguments*:
  ## - ``soundRecorder``:  Sound recorder object
  ## 
  ## *Returns:* The name of the current audio capture device


#--- SFML/Audio/SoundStream ---#

type SoundStreamChunk* {.bycopy.} = object
  ## defines the data to fill by the OnGetData callback
  samples*: ptr int16
  sampleCount*: cint

type SoundStreamGetDataCallback* = proc(p1: var SoundStreamChunk; p2: pointer): BoolInt {.cdecl.}

type SoundStreamSeekCallback* = proc(p1: Time; p2: pointer): void {.cdecl.}

proc newSoundStream*(onGetData: SoundStreamGetDataCallback, onSeek: SoundStreamSeekCallback, channelCount: cint, sampleRate: cint, userData: pointer): SoundStream {.
  cdecl, importc: "sfSoundStream_create".}
  ## Create a new sound stream
  ## 
  ## *Arguments*:
  ## - ``onGetData``:     Function called when the stream needs more data (can't be NULL)
  ## - ``onSeek``:        Function called when the stream seeks (can't be NULL)
  ## - ``channelCount``:  Number of channels to use (1 = mono, 2 = stereo)
  ## - ``sampleRate``:    Sample rate of the sound (44100 = CD quality)
  ## - ``userData``:      Data to pass to the callback functions
  ## 
  ## *Returns:* A new SoundStream object

proc destroy*(soundStream: SoundStream) {.
  destroy, cdecl, importc: "sfSoundStream_destroy".}
  ## Destroy a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream to destroy

proc play*(soundStream: SoundStream) {.
  cdecl, importc: "sfSoundStream_play".}
  ## Start or resume playing a sound stream
  ## 
  ## This function starts the stream if it was stopped, resumes
  ## it if it was paused, and restarts it from beginning if it
  ## was it already playing.
  ## This function uses its own thread so that it doesn't block
  ## the rest of the program while the music is played.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object

proc pause*(soundStream: SoundStream) {.
  cdecl, importc: "sfSoundStream_pause".}
  ## Pause a sound stream
  ## 
  ## This function pauses the stream if it was playing,
  ## otherwise (stream already paused or stopped) it has no effect.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object

proc stop*(soundStream: SoundStream) {.
  cdecl, importc: "sfSoundStream_stop".}
  ## Stop playing a sound stream
  ## 
  ## This function stops the stream if it was playing or paused,
  ## and does nothing if it was already stopped.
  ## It also resets the playing position (unlike SoundStream_pause).
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object

proc status*(soundStream: SoundStream): SoundStatus {.
  cdecl, importc: "sfSoundStream_getStatus".}
  ## Get the current status of a sound stream (stopped, paused, playing)
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Current status

proc channelCount*(soundStream: SoundStream): cint {.
  cdecl, importc: "sfSoundStream_getChannelCount".}
  ## Return the number of channels of a sound stream
  ## 
  ## 1 channel means a mono sound, 2 means stereo, etc.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Number of channels

proc sampleRate*(soundStream: SoundStream): cint {.
  cdecl, importc: "sfSoundStream_getSampleRate".}
  ## Get the sample rate of a sound stream
  ## 
  ## The sample rate is the number of audio samples played per
  ## second. The higher, the better the quality.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Sample rate, in number of samples per second

proc `pitch=`*(soundStream: SoundStream, pitch: cfloat) {.
  cdecl, importc: "sfSoundStream_setPitch".}
  ## Set the pitch of a sound stream
  ## 
  ## The pitch represents the perceived fundamental frequency
  ## of a sound; thus you can make a stream more acute or grave
  ## by changing its pitch. A side effect of changing the pitch
  ## is to modify the playing speed of the stream as well.
  ## The default value for the pitch is 1.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``pitch``:        New pitch to apply to the stream

proc `volume=`*(soundStream: SoundStream, volume: cfloat) {.
  cdecl, importc: "sfSoundStream_setVolume".}
  ## Set the volume of a sound stream
  ## 
  ## The volume is a value between 0 (mute) and 100 (full volume).
  ## The default value for the volume is 100.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``volume``:       Volume of the stream

proc `position=`*(soundStream: SoundStream, position: Vector3f) {.
  cdecl, importc: "sfSoundStream_setPosition".}
  ## Set the 3D position of a sound stream in the audio scene
  ## 
  ## Only streams with one channel (mono streams) can be
  ## spatialized.
  ## The default position of a stream is (0, 0, 0).
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``position``:     Position of the stream in the scene

proc `relativeToListener=`*(soundStream: SoundStream, relative: BoolInt) {.
  cdecl, importc: "sfSoundStream_setRelativeToListener".}
  ## Make a sound stream's position relative to the listener or absolute
  ## 
  ## Making a stream relative to the listener will ensure that it will always
  ## be played the same way regardless the position of the listener.
  ## This can be useful for non-spatialized streams, streams that are
  ## produced by the listener, or streams attached to it.
  ## The default value is false (position is absolute).
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``relative``:     True to set the position relative, False to set it absolute

proc `minDistance=`*(soundStream: SoundStream, distance: cfloat) {.
  cdecl, importc: "sfSoundStream_setMinDistance".}
  ## Set the minimum distance of a sound stream
  ## 
  ## The "minimum distance" of a stream is the maximum
  ## distance at which it is heard at its maximum volume. Further
  ## than the minimum distance, it will start to fade out according
  ## to its attenuation factor. A value of 0 ("inside the head
  ## of the listener") is an invalid value and is forbidden.
  ## The default value of the minimum distance is 1.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``distance``:     New minimum distance of the stream

proc `attenuation=`*(soundStream: SoundStream, attenuation: cfloat) {.
  cdecl, importc: "sfSoundStream_setAttenuation".}
  ## Set the attenuation factor of a sound stream
  ## 
  ## The attenuation is a multiplicative factor which makes
  ## the stream more or less loud according to its distance
  ## from the listener. An attenuation of 0 will produce a
  ## non-attenuated stream, i.e. its volume will always be the same
  ## whether it is heard from near or from far. On the other hand,
  ## an attenuation value such as 100 will make the stream fade out
  ## very quickly as it gets further from the listener.
  ## The default value of the attenuation is 1.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``attenuation``:  New attenuation factor of the stream

proc `playingOffset=`*(soundStream: SoundStream, timeOffset: Time) {.
  cdecl, importc: "sfSoundStream_setPlayingOffset".}
  ## Change the current playing position of a sound stream
  ## 
  ## The playing position can be changed when the stream is
  ## either paused or playing.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``timeOffset``:   New playing position

proc `loop=`*(soundStream: SoundStream, loop: BoolInt) {.
  cdecl, importc: "sfSoundStream_setLoop".}
  ## Set whether or not a sound stream should loop after reaching the end
  ## 
  ## If set, the stream will restart from beginning after
  ## reaching the end and so on, until it is stopped or
  ## SoundStream_setLoop(stream, False) is called.
  ## The default looping state for sound streams is false.
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## - ``loop``:         True to play in loop, False to play once

proc pitch*(soundStream: SoundStream): cfloat {.
  cdecl, importc: "sfSoundStream_getPitch".}
  ## Get the pitch of a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Pitch of the stream

proc volume*(soundStream: SoundStream): cfloat {.
  cdecl, importc: "sfSoundStream_getVolume".}
  ## Get the volume of a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Volume of the stream, in the range [0, 100]

proc position*(soundStream: SoundStream): Vector3f {.
  cdecl, importc: "sfSoundStream_getPosition".}
  ## Get the 3D position of a sound stream in the audio scene
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Position of the stream in the world

proc relativeToListener*(soundStream: SoundStream): BoolInt {.
  cdecl, importc: "sfSoundStream_isRelativeToListener".}
  ## Tell whether a sound stream's position is relative to the
  ## listener or is absolute
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* True if the position is relative, False if it's absolute

proc minDistance*(soundStream: SoundStream): cfloat {.
  cdecl, importc: "sfSoundStream_getMinDistance".}
  ## Get the minimum distance of a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Minimum distance of the stream

proc attenuation*(soundStream: SoundStream): cfloat {.
  cdecl, importc: "sfSoundStream_getAttenuation".}
  ## Get the attenuation factor of a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Attenuation factor of the stream

proc loop*(soundStream: SoundStream): BoolInt {.
  cdecl, importc: "sfSoundStream_getLoop".}
  ## Tell whether or not a sound stream is in loop mode
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* True if the music is looping, False otherwise

proc playingOffset*(soundStream: SoundStream): Time {.
  cdecl, importc: "sfSoundStream_getPlayingOffset".}
  ## Get the current playing position of a sound stream
  ## 
  ## *Arguments*:
  ## - ``soundStream``:  Sound stream object
  ## 
  ## *Returns:* Current playing position
