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
  const lib = "csfml-graphics-(2|2.0|2.1|2.2|2.3).dll"
else:
  const lib = "libcsfml-graphics.so"

import csfml_system, csfml_window
import csfml_util


include csfml_graphics_gen


import unsigned


proc color*(red, green, blue: int, alpha: int = 255): Color =
  result.r = uint8 red
  result.g = uint8 green
  result.b = uint8 blue
  result.a = uint8 alpha

proc red*(color: Color): int = int color.r
proc green*(color: Color): int = int color.g
proc blue*(color: Color): int = int color.b
proc alpha*(color: Color): int = int color.a

proc `red=`(color: var Color, red: int) =
  color.r = uint8 red
proc `green=`(color: var Color, green: int) =
  color.g = uint8 green
proc `blue=`(color: var Color, blue: int) =
  color.b = uint8 blue
proc `alpha=`(color: var Color, alpha: int) =
  color.a = uint8 alpha

proc `==`*(a, b: Color): bool =
  return a.r==b.r and a.g==b.g and a.b==b.b and a.a==b.a
proc `+`*(a, b: Color): Color =
  return add(a, b)
proc `*`*(a, b: Color): Color =
  return modulate(a, b)
proc `-`*(a, b: Color): Color =
  if a.r <= b.r: result.r = 0
  else: result.r = a.r-b.r
  if a.g <= b.g: result.g = 0
  else: result.g = a.g-b.g
  if a.b <= b.b: result.b = 0
  else: result.b = a.b-b.b
  if a.a <= b.a: result.a = 0
  else: result.a = a.a-b.a

let
  Black* = color(0, 0, 0)
  White* = color(255, 255, 255)
  Red* = color(255, 0, 0)
  Green* = color(0, 255, 0)
  Blue* = color(0, 0, 255)
  Yellow* = color(255, 255, 0)
  Magenta* = color(255, 0, 255)
  Cyan* = color(0, 255, 255)
  Transparent* = color(0, 0, 0, 0)


proc rect*(left, top, width, height: cint): IntRect =
  return IntRect(left: left, top: top, width: width, height: height)
proc rect*(left, top, width, height: int): IntRect =
  result.left = cint left
  result.top = cint top
  result.width = cint width
  result.height = cint height
proc rect*(left, top, width, height: cfloat): FloatRect =
  return FloatRect(left: left, top: top, width: width, height: height)
proc rect*(left, top, width, height: float): FloatRect =
  result.left = cfloat left
  result.top = cfloat top
  result.width = cfloat width
  result.height = cfloat height
converter rect*(r: IntRect): FloatRect =
  result.left = cfloat r.left
  result.top = cfloat r.top
  result.width = cfloat r.width
  result.height = cfloat r.height

proc `==`*(a, b: IntRect): bool =
  return a.left==b.left and a.top==b.top and a.width==b.width and a.height==b.height

proc contains*(rect: IntRect, point: Vector2i): bool =
  var copy = rect
  return copy.contains(point.x, point.y)
proc contains*(rect: FloatRect, point: Vector2f): bool =
  var copy = rect
  return copy.contains(point.x, point.y)


proc transform*(): Transform =
  return transform(1.0, 0.0, 0.0,  0.0, 1.0, 0.0,  0.0, 0.0, 1.0)
let Identity* = transform()

proc transformPoint*(transform: Transform, x, y: cfloat): Vector2f =
  var copy = transform
  return copy.transformPoint(vec2(x, y))
proc translate*(transform: var Transform, offset: Vector2f) =
  transform.translate(offset.x, offset.y)
proc rotate*(transform: var Transform, angle: cfloat, center: Vector2f) =
  transform.rotate(angle, center.x, center.y)
proc scale*(transform: var Transform, factors: Vector2f) =
  transform.scale(factors.x, factors.y)
proc scale*(transform: var Transform, factors, center: Vector2f) =
  transform.scale(factors.x, factors.y, center.x, center.y)

proc `*`*(a, b: Transform): Transform =
  result = a
  result.combine(b)
proc `*=`*(a: var Transform, b: Transform) =
  a.combine(b)
proc `*`*(a: Transform, b: Vector2f): Vector2f =
  return a.transformPoint(b)


proc renderStates*(blendMode: BlendMode = BlendMode.Alpha, transform: Transform = Identity, texture: Texture = nil, shader: Shader = nil): RenderStates =
  result.blendMode = blendMode
  result.transform = transform
  result.texture = texture
  result.shader = shader


proc `title=`*(window: RenderWindow, title: string) =
  var t = utf8to32(title)
  window.unicodeTitle = addr(t[0])
proc newRenderWindow*(mode: VideoMode, title: string, style: uint32 = DefaultStyle, settings: ContextSettings = contextSettings()): RenderWindow =
  var t = utf8to32(title)
  return newRenderWindow(mode, addr(t[0]), style, settings)


proc `string=`*(text: Text, string: string) =
  var t = utf8to32(string)
  text.unicodeString = addr(t[0])


template defDraw(name: expr) {.immediate.} =
  proc draw*[T: RenderTexture|RenderWindow](renderTarget: T, obj: `name`, states: RenderStates = renderStates()) =
    `"draw" name`(renderTarget, obj, states)
defDraw CircleShape
defDraw ConvexShape
defDraw RectangleShape
defDraw Shape
defDraw Sprite
defDraw Text
defDraw VertexArray

template draw*[T: RenderTexture|RenderWindow, O](renderTarget: T, obj: O, states: RenderStates = renderStates()): stmt =
    obj.draw(renderTarget, states)