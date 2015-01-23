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


## Extended functionality that is not part of SFML API

{.deadCodeElim: on.}

import csfml


iterator events*[T: Window|RenderWindow] (window: T): Event =
  ## Iterator wrapping pollEvent in a loop
  var event: Event
  while window.pollEvent(event):
    yield event



proc red*(color: Color): int =
  ## *Returns*: red component of a Color
  int color.r
proc green*(color: Color): int =
  ## *Returns*: green component of a Color
  int color.g
proc blue*(color: Color): int =
  ## *Returns*: blue component of a Color
  int color.b
proc alpha*(color: Color): int =
  ## *Returns*: alpha (opacity) component of a Color
  int color.a

proc `red=`*(color: var Color, red: int) =
  ## Sets the red component of a Color
  color.r = uint8 red
proc `green=`*(color: var Color, green: int) =
  ## Sets the green component of a Color
  color.g = uint8 green
proc `blue=`*(color: var Color, blue: int) =
  ## Sets the blue component of a Color
  color.b = uint8 blue
proc `alpha=`*(color: var Color, alpha: int) =
  ## Sets the alpha (opacity) component of a Color
  color.a = uint8 alpha

