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

{.deadCodeElim: on, experimental.}

when defined(windows):
  const lib = "csfml-system-2.dll"
elif defined(mac):
  const lib = "libcsfml-system.dylib"
else:
  const lib = "libcsfml-system.so"

import csfml_util
export csfml_util


{.push dynlib: lib.}
include csfml_system_gen
{.pop.}


proc vec2*(x, y: cint): Vector2i =
  ## *Returns*: Vector2i with these coordinates
  result.x = x
  result.y = y
proc vec2*(x, y: int): Vector2i =
  ## *Returns*: Vector2i with these coordinates
  result.x = cint x
  result.y = cint y
proc vec2*(x, y: cfloat): Vector2f =
  ## *Returns*: Vector2f with these coordinates
  result.x = x
  result.y = y
proc vec2*(x, y: float): Vector2f =
  ## *Returns*: Vector2f with these coordinates
  result.x = cfloat x
  result.y = cfloat y
converter vec2*(v: Vector2i): Vector2f =
  ## Conversion from Vector2i to Vector2f
  result.x = cfloat v.x
  result.y = cfloat v.y

proc vec3*(x, y, z: cfloat): Vector3f =
  ## *Returns*: Vector3f with these coordinates
  result.x = x
  result.y = y
  result.z = z
proc vec3*(x, y, z: float): Vector3f =
  ## *Returns*: Vector3f with these coordinates
  result.x = cfloat x
  result.y = cfloat y
  result.z = cfloat z

proc `+`*(a, b: Vector2f): Vector2f =
  ## *Returns*: memberwise addition
  result.x = a.x+b.x
  result.y = a.y+b.y
proc `-`*(a, b: Vector2f): Vector2f =
  ## *Returns*: memberwise subtraction
  result.x = a.x-b.x
  result.y = a.y-b.y
proc `*`*(a: Vector2f, b: cfloat): Vector2f =
  ## *Returns*: memberwise multiplication by ``b``
  result.x = a.x*b
  result.y = a.y*b
proc `/`*(a: Vector2f, b: cfloat): Vector2f =
  ## *Returns*: memberwise division by ``b``
  result.x = a.x/b
  result.y = a.y/b
proc `-`*(a: Vector2f): Vector2f =
  ## *Returns*: memberwise opposite
  result.x = -a.x
  result.y = -a.y
proc `==`*(a, b: Vector2f): bool =
  ## *Returns*: whether corresponding members of two Vector2fs are equal
  return a.x==b.x and a.y==b.y

proc `+`*(a, b: Vector2i): Vector2i =
  ## *Returns*: memberwise addition
  result.x = a.x+b.x
  result.y = a.y+b.y
proc `-`*(a, b: Vector2i): Vector2i =
  ## *Returns*: memberwise subtraction
  result.x = a.x-b.x
  result.y = a.y-b.y
proc `*`*(a: Vector2i, b: cint): Vector2i =
  ## *Returns*: memberwise multiplication by ``b``
  result.x = a.x*b
  result.y = a.y*b
proc `/`*(a: Vector2i, b: cint): Vector2i =
  ## *Returns*: memberwise integer division by ``b``
  result.x = a.x div b
  result.y = a.y div b
proc `-`*(a: Vector2i): Vector2i =
  ## *Returns*: memberwise opposite
  result.x = -a.x
  result.y = -a.y
proc `==`*(a, b: Vector2i): bool =
  ## *Returns*: whether corresponding members of two Vector2is are equal
  return a.x==b.x and a.y==b.y

proc `+`*(a, b: Vector3f): Vector3f =
  ## *Returns*: memberwise addition
  result.x = a.x+b.x
  result.y = a.y+b.y
  result.z = a.z+b.z
proc `-`*(a, b: Vector3f): Vector3f =
  ## *Returns*: memberwise subtraction
  result.x = a.x-b.x
  result.y = a.y-b.y
  result.z = a.z-b.z
proc `*`*(a: Vector3f, b: cfloat): Vector3f =
  ## *Returns*: memberwise multiplication by ``b``
  result.x = a.x*b
  result.y = a.y*b
  result.z = a.z*b
proc `/`*(a: Vector3f, b: cfloat): Vector3f =
  ## *Returns*: memberwise division by ``b``
  result.x = a.x/b
  result.y = a.y/b
  result.z = a.z/b
proc `-`*(a: Vector3f): Vector3f =
  ## *Returns*: memberwise opposite
  result.x = -a.x
  result.y = -a.y
  result.z = -a.z
proc `==`*(a, b: Vector3f): bool =
  ## *Returns*: whether corresponding members of two Vector3fs are equal
  return a.x==b.x and a.y==b.y and a.z==b.z


proc `==`*(a, b: Time): bool = a.microseconds == b.microseconds
  ## *Returns*: whether two time values are equal
proc `<=`*(a, b: Time): bool = a.microseconds <= b.microseconds
  ## *Returns*: whether ``a`` is not later than ``b``
proc `<`*(a, b: Time): bool = a.microseconds < b.microseconds
  ## *Returns*: whether ``a`` is earlier than ``b``
