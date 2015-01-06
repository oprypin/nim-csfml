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


proc vec2*(x, y: cint): Vector2i = Vector2i(x: x, y: y)
  ## *Returns*: Vector2i with these coordinates
proc vec2*(x, y: int): Vector2i = vec2(cint(x), cint(y))
  ## *Returns*: Vector2i with these coordinates
proc vec2*(x, y: cfloat): Vector2f = Vector2f(x: x, y: y)
  ## *Returns*: Vector2f with these coordinates
proc vec2*(x, y: float): Vector2f = vec2(cfloat(x), cfloat(y))
  ## *Returns*: Vector2f with these coordinates
converter vec2*(a: Vector2i): Vector2f = vec2(cfloat(a.x), cfloat(a.y))
  ## Conversion from Vector2i to Vector2f

proc vec3*(x, y, z: cfloat): Vector3f = Vector3f(x: x, y: y, z: y)
  ## *Returns*: Vector3f with these coordinates
proc vec3*(x, y, z: float): Vector3f = vec3(cfloat(x), cfloat(y), cfloat(z))
  ## *Returns*: Vector3f with these coordinates

proc `+`*(a, b: Vector2f): Vector2f = vec2(a.x+b.x, a.y+b.y)
  ## *Returns*: memberwise addition
proc `-`*(a, b: Vector2f): Vector2f = vec2(a.x-b.x, a.y-b.y)
  ## *Returns*: memberwise subtraction
proc `*`*(a: Vector2f, b: cfloat): Vector2f = vec2(a.x*b, a.y*b)
  ## *Returns*: memberwise multiplication by ``b``
proc `/`*(a: Vector2f, b: cfloat): Vector2f = vec2(a.x/b, a.y/b)
  ## *Returns*: memberwise division by ``b``
proc `-`*(a: Vector2f): Vector2f = vec2(-a.x, -a.y)
  ## *Returns*: memberwise opposite
proc `==`*(a, b: Vector2f): bool = a.x==b.x and a.y==b.y
  ## *Returns*: whether corresponding members of two Vector2fs are equal

proc `+`*(a, b: Vector2i): Vector2i = vec2(a.x+b.x, a.y+b.y)
  ## *Returns*: memberwise addition
proc `-`*(a, b: Vector2i): Vector2i = vec2(a.x-b.x, a.y-b.y)
  ## *Returns*: memberwise subtraction
proc `*`*(a: Vector2i, b: cint): Vector2i = vec2(a.x*b, a.y*b)
  ## *Returns*: memberwise multiplication by ``b``
proc `div`*(a: Vector2i, b: cint): Vector2i = vec2(a.x div b, a.y div b)
  ## *Returns*: memberwise integer division by ``b``
proc `-`*(a: Vector2i): Vector2i = vec2(-a.x, -a.y)
  ## *Returns*: memberwise opposite
proc `==`*(a, b: Vector2i): bool = a.x==b.x and a.y==b.y
  ## *Returns*: whether corresponding members of two Vector2is are equal

proc `+`*(a, b: Vector3f): Vector3f = vec3(a.x+b.x, a.y+b.y, a.z+b.z)
  ## *Returns*: memberwise addition
proc `-`*(a, b: Vector3f): Vector3f = vec3(a.x-b.x, a.y-b.y, a.z-b.z)
  ## *Returns*: memberwise subtraction
proc `*`*(a: Vector3f, b: cfloat): Vector3f = vec3(a.x*b, a.y*b, a.z*b)
  ## *Returns*: memberwise multiplication by ``b``
proc `/`*(a: Vector3f, b: cfloat): Vector3f = vec3(a.x/b, a.y/b, a.z/b)
  ## *Returns*: memberwise division by ``b``
proc `-`*(a: Vector3f): Vector3f = vec3(-a.x, -a.y, -a.z)
  ## *Returns*: memberwise opposite
proc `==`*(a, b: Vector3f): bool = a.x==b.x and a.y==b.y and a.z==b.z
  ## *Returns*: whether corresponding members of two Vector3fs are equal


proc `==`*(a, b: Time): bool = a.microseconds == b.microseconds
  ## *Returns*: whether two time values are equal
proc `<=`*(a, b: Time): bool = a.microseconds <= b.microseconds
  ## *Returns*: whether ``a`` is not later than ``b``
proc `<`*(a, b: Time): bool = a.microseconds < b.microseconds
  ## *Returns*: whether ``a`` is earlier than ``b``
proc `-`*(a: Time): Time = microseconds(-a.microseconds)
  ## *Returns*: negated Time value
proc `+`*(a, b: Time): Time = microseconds(a.microseconds+b.microseconds)
  ## *Returns*: sum of the two Time values
proc `-`*(a, b: Time): Time = microseconds(a.microseconds+b.microseconds)
  ## *Returns*: difference of the two Time values
