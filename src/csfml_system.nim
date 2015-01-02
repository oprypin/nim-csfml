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

{.deadCodeElim: on.}

when defined(windows):
  const lib = "csfml-system-(2|2.0|2.1|2.2|2.3).dll"
else:
  const lib = "libcsfml-system.so"

import csfml_util


include csfml_system_gen


proc vec2*(x, y: cint): Vector2i =
  result.x = x
  result.y = y
proc vec2*(x, y: int): Vector2i =
  result.x = cint x
  result.y = cint y
proc vec2*(x, y: cfloat): Vector2f =
  result.x = x
  result.y = y
proc vec2*(x, y: float): Vector2f =
  result.x = cfloat x
  result.y = cfloat y
converter vec2*(v: Vector2i): Vector2f =
  result.x = cfloat v.x
  result.y = cfloat v.y

proc vec3*(x, y, z: cfloat): Vector3f =
  return Vector3f(x: x, y: y, z: z)
proc vec3*(x, y, z: float): Vector3f =
  result.x = cfloat x
  result.y = cfloat y
  result.z = cfloat z

proc `+`*(a, b: Vector2f): Vector2f =
  result.x = a.x+b.x
  result.y = a.y+b.y
proc `-`*(a, b: Vector2f): Vector2f =
  result.x = a.x-b.x
  result.y = a.y-b.y
proc `*`*(a: Vector2f, b: cfloat): Vector2f =
  result.x = a.x*b
  result.y = a.y*b
proc `/`*(a: Vector2f, b: cfloat): Vector2f =
  result.x = a.x/b
  result.y = a.y/b
proc `==`*(a, b: Vector2f): bool =
  return a.x==b.x and a.y==b.y

proc `+`*(a, b: Vector2i): Vector2i =
  result.x = a.x+b.x
  result.y = a.y+b.y
proc `-`*(a, b: Vector2i): Vector2i =
  result.x = a.x-b.x
  result.y = a.y-b.y
proc `*`*(a: Vector2i, b: cint): Vector2i =
  result.x = a.x*b
  result.y = a.y*b
proc `/`*(a: Vector2i, b: cint): Vector2i =
  result.x = a.x div b
  result.y = a.y div b
proc `==`*(a, b: Vector2i): bool =
  return a.x==b.x and a.y==b.y

proc `+`*(a, b: Vector3f): Vector3f =
  result.x = a.x+b.x
  result.y = a.y+b.y
  result.z = a.z+b.z
proc `-`*(a, b: Vector3f): Vector3f =
  result.x = a.x-b.x
  result.y = a.y-b.y
  result.z = a.z-b.z
proc `*`*(a: Vector3f, b: cfloat): Vector3f =
  result.x = a.x*b
  result.y = a.y*b
  result.z = a.z*b
proc `/`*(a: Vector3f, b: cfloat): Vector3f =
  result.x = a.x/b
  result.y = a.y/b
  result.z = a.z/b
proc `==`*(a, b: Vector3f): bool =
  return a.x==b.x and a.y==b.y and a.z==b.z


proc `+`*(a, b: Time): Time = 
  return microseconds(a.asMicroseconds + b.asMicroseconds)
proc `-`*(a, b: Time): Time =
  return microseconds(a.asMicroseconds - b.asMicroseconds)
proc `==`*(a, b: Time): bool =
  return a.asMicroseconds == b.asMicroseconds
proc `<=`*(a, b: Time): bool =
  return a.asMicroseconds < b.asMicroseconds
proc `<`*(a, b: Time): bool =
  return a.asMicroseconds < b.asMicroseconds