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

const module = "graphics"
include private/csfml_common

import csfml_system, csfml_window


{.push dynlib: lib.}
include private/csfml_graphics_gen
{.pop.}


import unsigned, unicode


proc color*(red, green, blue: int, alpha: int = 255): Color =
  ## *Arguments*:
  ## - ``red``: Red component (in the range [0, 255])
  ## - ``green``: Green component (in the range [0, 255])
  ## - ``blue``: Blue component (in the range [0, 255])
  ## - ``alpha``: Alpha (opacity) component (in the range [0, 255]) 
  ##
  ## *Returns*: Color from its 4 RGBA components
  result.r = uint8 red
  result.g = uint8 green
  result.b = uint8 blue
  result.a = uint8 alpha

proc `==`*(a, b: Color): bool =
  ## *Returns*: whether all components of two Colors are equal
  a.r==b.r and a.g==b.g and a.b==b.b and a.a==b.a
proc `+`*(a, b: Color): Color =
  ## Alias for add
  ##
  ## *Returns:* The component-wise sum of two colors. Components that exceed 255 are clamped to 255.
  add(a, b)
proc `*`*(a, b: Color): Color =
  ## Alias for modulate
  ##
  ## *Returns:* The component-wise multiplication (also called "modulation") of two colors.
  ## Components are then divided by 255 so that the result is still in the range [0, 255].
  modulate(a, b)
proc `-`*(a, b: Color): Color =
  ## *Returns:* The component-wise subtraction of two colors. Components below 0 are clamped to 0.
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
  ## *Returns*: IntRect with these members
  IntRect(left: left, top: top, width: width, height: height)
proc rect*(left, top, width, height: int): IntRect =
  ## *Returns*: IntRect with these members
  rect(cint(left), cint(top), cint(width), cint(height))
proc rect*(left, top, width, height: cfloat): FloatRect =
  ## *Returns*: FloatRect with these members
  FloatRect(left: left, top: top, width: width, height: height)
proc rect*(left, top, width, height: float): FloatRect =
  ## *Returns*: FloatRect with these members
  rect(cfloat(left), cfloat(top), cfloat(width), cfloat(height))
converter rect*(r: IntRect): FloatRect =
  ## Conversion from IntRect to FloatRect
  rect(cfloat(r.left), cfloat(r.top), cfloat(r.width), cfloat(r.height))

proc `==`*(a, b: IntRect): bool =
  ## *Returns*: whether corresponding members of two IntRects are equal
  a.left==b.left and a.top==b.top and a.width==b.width and a.height==b.height
proc `==`*(a, b: FloatRect): bool =
  ## *Returns*: whether corresponding members of two FloatRects are equal
  a.left==b.left and a.top==b.top and a.width==b.width and a.height==b.height

proc contains*(rect: IntRect, point: Vector2i): bool =
  var copy = rect
  copy.contains(point.x, point.y)
proc contains*(rect: FloatRect, point: Vector2f): bool =
  var copy = rect
  copy.contains(point.x, point.y)


proc transform*(): Transform =
  ## *Returns*: An identity Transform (a transform that does nothing). 
  transform(1.0, 0.0, 0.0,  0.0, 1.0, 0.0,  0.0, 0.0, 1.0)
let Identity* = transform()

proc transformPoint*(transform: Transform, x, y: cfloat): Vector2f =
  var copy = transform
  copy.transformPoint(vec2(x, y))
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
  a.transformPoint(b)

proc matrixGL*(transform: Transform): array[0..15, cfloat] =
  ## This function fills an array of 16 floats with the transform
  ## converted as a 4x4 matrix, which is directly compatible with
  ## OpenGL functions.
  ##
  ## *Arguments*:
  ## - ``transform``: Transform object
  ##
  ## *Returns*: 16-element array
  transform.getMatrix(addr(result[0]))


proc renderStates*(blendMode = BlendMode.Alpha, transform = Identity,
                   texture: Texture = nil, shader: Shader = nil): RenderStates =
  ## *Returns*: a RenderStates with these members
  result.blendMode = blendMode
  result.transform = transform
  result.texture = texture
  result.shader = shader


proc `title=`*(window: RenderWindow, title: string) =
  ## Change the title of a render window (with a normal UTF-8 string)
  ##
  ## *Arguments*:
  ## - ``renderWindow``: Render window object
  ## - ``title``: New title
  var t = utf8to32(title)
  window.title_U32 = addr(t[0])
proc newRenderWindow*(mode: VideoMode, title: string, style: BitMaskU32 = WindowStyle.Default,
                      settings = contextSettings()): RenderWindow =
  ## Construct a new render window (with a UTF-8 title)
  ##
  ## *Arguments*:
  ## - ``mode``: Video mode to use
  ## - ``title``: Title of the window (UTF-8)
  ## - ``style``: Window style
  ## - ``settings``: Creation settings
  var t = utf8to32(title)
  newRenderWindow_U32(mode, addr(t[0]), style, settings)


proc str*(text: Text): string =
  ## Get the string of a text
  ##
  ## *Arguments*:
  ## - ``text``: Text object
  ##
  ## *Returns:* String as UTF-8
  var ip = cast[int](text.str_U32)
  var r = newSeq[Rune]()
  while true:
    var p = cast[ptr[RuneU32]](ip)
    if uint32(p[]) == 0:
      break
    r.add p[]
    ip += sizeof(RuneU32)
  $r
proc `str=`*(text: Text, str: string) =
  ## Set the string of a text (from a normal UTF-8 string)
  ##
  ## *Arguments*:
  ## - ``text``: Text object
  ## - ``str``: New string
  var t = utf8to32(str)
  text.str_U32 = addr(t[0])


converter toBitMaskU32*(a: TextStyle): BitMaskU32 = BitMaskU32 a
  ## Allows TextStyle values to be combined using the | operator and be used in functions


template defDraw(name: expr) {.immediate, dirty.} =
  proc draw*[T: RenderTexture|RenderWindow](renderTarget: T, obj: `name`, states = renderStates()) =
    ## Allows the syntax ``renderTarget.draw(drawable[, states])``
    ## by turning it into ``renderTarget.drawDrawableType(drawable, states)``
    `"draw" name`(renderTarget, obj, states)
defDraw CircleShape
defDraw ConvexShape
defDraw RectangleShape
defDraw Shape
defDraw Sprite
defDraw Text
defDraw VertexArray

proc draw*[T: RenderTexture|RenderWindow, O] (
  renderTarget: T, obj: O, states = renderStates()) =
  ## Allows the syntax ``renderTarget.draw(drawable[, states])``
  ## by turning it into ``drawable.draw(renderTarget, states)``
  obj.draw(renderTarget, states)

proc draw*[T: RenderTexture|RenderWindow] (
  renderTarget: T, vertices: var seq[Vertex], kind: PrimitiveType, states = renderStates()) =
  ## Draw primitives defined by an array of vertices to a render window.
  ## Wrapper for drawPrimitives.
  if vertices.len > 0:
    drawPrimitives(renderTarget, addr(vertices[0]), cint(vertices.len), kind, states)


proc newCircleShape*(radius: cfloat, pointCount = 30): CircleShape =
  ## *Returns:* A new CircleShape with these members, or nil if it failed
  result = newCircleShape()
  if result == nil: return nil
  result.radius = radius
  result.pointCount = cint(pointCount)


proc newRectangleShape*(size: Vector2f): RectangleShape =
  ## *Returns:* A new RectangleShape with this size, or nil if it failed
  result = newRectangleShape()
  if result == nil: return nil
  result.size = size


proc newConvexShape*(pointCount: int): ConvexShape =
  ## *Returns:* A new ConvexShape with this pointCount, or nil if it failed
  result = newConvexShape()
  if result == nil: return nil
  result.pointCount = cint(pointCount)

proc `[]`*(shape: ConvexShape, index: int): Vector2f =
  ## Get a point of a convex shape
  ##
  ## The result is undefined if ``index`` is out of the valid range.
  ##
  ## *Arguments*:
  ## - ``shape``: Shape object
  ## - ``index``: Index of the point to get, in range [0 .. pointCount - 1]
  ##
  ## *Returns:* Index-th point of the shape
  shape.getPoint(cint(index))
proc `[]=`*(shape: ConvexShape, index: int, point: Vector2f) =
  ## Set the position of a point in a convex shape
  ##
  ## Don't forget that the polygon must remain convex, and
  ## the points need to stay ordered!
  ## pointCount= must be called first in order to set the total
  ## number of points. The result is undefined if ``index`` is out
  ## of the valid range.
  ##
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to change, in range [0 .. GetPointCount() - 1]
  ## - ``point``:  New point
  shape.setPoint(cint(index), point)


proc `texture=`*(sprite: Sprite, texture: Texture) =
  ## Change the source texture of a sprite without resetting textureRect
  sprite.setTexture(texture, resetRect = false)

proc newSprite*(texture: Texture): Sprite =
  ## *Returns:* A new Sprite with this texture, or nil if it failed
  result = newSprite()
  if result == nil: return nil
  result.setTexture(texture, resetRect = true)
proc newSprite*(texture: Texture, rectangle: IntRect): Sprite =
  ## Construct the sprite from a sub-rectangle of a source texture
  ##
  ## *Returns:* A new Sprite with this texture and textureRect, or nil if it failed
  result = newSprite()
  if result == nil: return nil
  result.texture = texture
  result.textureRect = rectangle


proc newText*(str: string, font: Font, characterSize = 30): Text =
  ## *Returns*: Text with these members
  result = newText()
  if result == nil: return nil
  result.str = str
  result.font = font
  result.characterSize = cint(characterSize)


proc vertex*(position = vec2(0.0, 0.0), color = White, texCoords = vec2(0.0, 0.0)): Vertex =
  ## *Returns*: Vertex with these members
  result.position = position
  result.color = color
  result.texCoords = texCoords


proc newVertexArray*(primitiveType: PrimitiveType, vertexCount = 0): VertexArray =
  ## *Returns*: VertexArray with this type of primitives and initial number of vertices
  result = newVertexArray()
  result.primitiveType = primitiveType
  result.resize(cint(vertexCount))

proc `[]`*(vertexArray: VertexArray, index: int): Vertex =
  ## Get a vertex by its index
  ##
  ## This function doesn't check ``index``, it must be in range
  ## [0, vertex count - 1]. The behaviour is undefined
  ## otherwise.
  ##
  ## *Returns:* The index-th vertex
  vertexArray.getVertex(cint(index))[]
proc `[]=`*(vertexArray: VertexArray, index: int, vertex: Vertex) =
  ## Set a vertex by its index
  ##
  ## This function doesn't check ``index``, it must be in range
  ## [0, vertex count - 1]. The behaviour is undefined
  ## otherwise.
  vertexArray.getVertex(cint(index))[] = vertex


proc newView*(center: Vector2f, size: Vector2f): View =
  ## *Returns*: View with these members
  result = newView()
  result.center = center
  result.size = size


proc newRenderTexture*(width: cint, height: cint): RenderTexture =
  ## *Returns:* A new RenderTexture object with this size and depthBuffer = false,
  ## or nil if it failed
  newRenderTexture(width, height, false)
