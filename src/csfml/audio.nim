# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
# 
# This file is part of nim-csfml.
# 
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
# 
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

const module = "audio"
include csfml/private/common

import csfml/system


{.push dynlib: lib.}
include csfml/private/audio_gen
{.pop.}


proc newSound*(buffer: SoundBuffer): Sound =
  ## *Returns*: A new Sound with this buffer
  result = newSound()
  if result == nil: return nil
  result.buffer = buffer

proc soundRecorder_getAvailableDevices*(): seq[string] =
  ## Wrapper proc that returns a seq instead of exposing pointers
  ##
  ## *Returns:* seq of the names of all availabe audio capture devices
  var count: int
  var p = cast[int](soundRecorder_getAvailableDevices(addr count))
  result = newSeq[string](count)
  for i in result.low..result.high:
    result[i] = $cast[ptr cstring](p)[]
    p += sizeof(cstring)
