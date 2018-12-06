# Adapted from SFML Sound Capture example
# https://github.com/LaurentGomila/SFML/blob/master/examples/sound_capture/SoundCapture.cpp

import strutils
import csfml/system, csfml/audio, csfml/util


if not soundRecorderIsAvailable():
  echo "Sorry, audio capture is not supported by your system"
  quit()

echo "Please choose the sample rate for sound capture (44100 is CD quality):"
var sampleRate = parseInt(stdin.readLine())

var recorder = newSoundBufferRecorder()

recorder.start(cint(sampleRate))
echo "Recording... press Enter to stop"
discard stdin.readLine()
recorder.stop()

var buffer = recorder.buffer

echo "Sound information:"
echo " ", buffer.duration.asSeconds, " seconds"
echo " ", buffer.sampleRate, " samples/seconds"
echo " ", buffer.channelCount, " channels"

echo "What do you want to do with captured sound (p = play, s = save)?"
var choice = stdin.readLine()

if choice == "s":
  echo "Choose the file to create:"
  var filename = stdin.readLine()
  discard buffer.saveToFile filename

else:
  var sound = newSound(buffer)
  sound.play()

  while sound.status == SoundStatus.Playing:
    echo "Playing... ", sound.playingOffset.asSeconds, " sec"
    sleep 100.milliseconds
  sound.destroy()

recorder.destroy()
echo "Done!"
