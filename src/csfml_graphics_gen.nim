
#--- SFML/Graphics ---#


#--- SFML/Graphics/BlendMode ---#

type BlendMode* {.pure, size: sizeof(cint).} = enum
  Alpha, Add, Multiply, None


#--- SFML/Graphics/CircleShape ---#


#--- SFML/Graphics/Color ---#

type Color* {.pure, final.} = object
  r*: uint8
  g*: uint8
  b*: uint8
  a*: uint8

proc color*(red: uint8, green: uint8, blue: uint8): Color {.
  cdecl, dynlib: lib, importc: "sfColor_fromRGB".}

proc color*(red: uint8, green: uint8, blue: uint8, alpha: uint8): Color {.
  cdecl, dynlib: lib, importc: "sfColor_fromRGBA".}

proc add*(color1: Color, color2: Color): Color {.
  cdecl, dynlib: lib, importc: "sfColor_add".}

proc modulate*(color1: Color, color2: Color): Color {.
  cdecl, dynlib: lib, importc: "sfColor_modulate".}


#--- SFML/Graphics/Rect ---#

type FloatRect* {.pure, final.} = object
  left*: cfloat
  top*: cfloat
  width*: cfloat
  height*: cfloat

type IntRect* {.pure, final.} = object
  left*: cint
  top*: cint
  width*: cint
  height*: cint

proc contains*(rect: (var FloatRect){lvalue}, x: cfloat, y: cfloat): IntBool {.
  cdecl, dynlib: lib, importc: "sfFloatRect_contains".}
proc contains*(rect: FloatRect, x: cfloat, y: cfloat): IntBool =
  (var Crect = rect)
  return contains(Crect, x, y)

proc contains*(rect: (var IntRect){lvalue}, x: cint, y: cint): IntBool {.
  cdecl, dynlib: lib, importc: "sfIntRect_contains".}
proc contains*(rect: IntRect, x: cint, y: cint): IntBool =
  (var Crect = rect)
  return contains(Crect, x, y)

proc intersects*(rect1: (var FloatRect){lvalue}, rect2: (var FloatRect){lvalue}, intersection: var FloatRect): IntBool {.
  cdecl, dynlib: lib, importc: "sfFloatRect_intersects".}
proc intersects*(rect1: (var FloatRect){lvalue}, rect2: FloatRect, intersection: var FloatRect): IntBool =
  (var Crect2 = rect2)
  return intersects(rect1, Crect2, intersection)
proc intersects*(rect1: FloatRect, rect2: (var FloatRect){lvalue}, intersection: var FloatRect): IntBool =
  (var Crect1 = rect1)
  return intersects(Crect1, rect2, intersection)
proc intersects*(rect1: FloatRect, rect2: FloatRect, intersection: var FloatRect): IntBool =
  (var Crect1 = rect1; var Crect2 = rect2)
  return intersects(Crect1, Crect2, intersection)

proc intersects*(rect1: (var IntRect){lvalue}, rect2: (var IntRect){lvalue}, intersection: var IntRect): IntBool {.
  cdecl, dynlib: lib, importc: "sfIntRect_intersects".}
proc intersects*(rect1: (var IntRect){lvalue}, rect2: IntRect, intersection: var IntRect): IntBool =
  (var Crect2 = rect2)
  return intersects(rect1, Crect2, intersection)
proc intersects*(rect1: IntRect, rect2: (var IntRect){lvalue}, intersection: var IntRect): IntBool =
  (var Crect1 = rect1)
  return intersects(Crect1, rect2, intersection)
proc intersects*(rect1: IntRect, rect2: IntRect, intersection: var IntRect): IntBool =
  (var Crect1 = rect1; var Crect2 = rect2)
  return intersects(Crect1, Crect2, intersection)


#--- SFML/Graphics/Transform ---#


#--- SFML/Graphics/Types ---#

type
  CircleShape* = ptr TCircleShape
  TCircleShape {.pure, final.} = object

type
  ConvexShape* = ptr TConvexShape
  TConvexShape {.pure, final.} = object

type
  Font* = ptr TFont
  TFont {.pure, final.} = object

type
  Image* = ptr TImage
  TImage {.pure, final.} = object

type
  Shader* = ptr TShader
  TShader {.pure, final.} = object

type
  RectangleShape* = ptr TRectangleShape
  TRectangleShape {.pure, final.} = object

type
  RenderTexture* = ptr TRenderTexture
  TRenderTexture {.pure, final.} = object

type
  RenderWindow* = ptr TRenderWindow
  TRenderWindow {.pure, final.} = object

type
  Shape* = ptr TShape
  TShape {.pure, final.} = object

type
  Sprite* = ptr TSprite
  TSprite {.pure, final.} = object

type
  Text* = ptr TText
  TText {.pure, final.} = object

type
  Texture* = ptr TTexture
  TTexture {.pure, final.} = object

type
  Transformable* = ptr TTransformable
  TTransformable {.pure, final.} = object

type
  VertexArray* = ptr TVertexArray
  TVertexArray {.pure, final.} = object

type
  View* = ptr TView
  TView {.pure, final.} = object

type Transform* {.pure, final.} = object
  matrix*: array[0..8, cfloat]

proc transform*(a00: cfloat, a01: cfloat, a02: cfloat, a10: cfloat, a11: cfloat, a12: cfloat, a20: cfloat, a21: cfloat, a22: cfloat): Transform {.
  cdecl, dynlib: lib, importc: "sfTransform_fromMatrix".}

proc getMatrix*(transform: (var Transform){lvalue}, matrix: ptr cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_getMatrix".}
proc getMatrix*(transform: Transform, matrix: ptr cfloat) =
  (var Ctransform = transform)
  getMatrix(Ctransform, matrix)

proc inverse*(transform: (var Transform){lvalue}): Transform {.
  cdecl, dynlib: lib, importc: "sfTransform_getInverse".}
proc inverse*(transform: Transform): Transform =
  (var Ctransform = transform)
  return inverse(Ctransform)

proc transformPoint*(transform: (var Transform){lvalue}, point: Vector2f): Vector2f {.
  cdecl, dynlib: lib, importc: "sfTransform_transformPoint".}
proc transformPoint*(transform: Transform, point: Vector2f): Vector2f =
  (var Ctransform = transform)
  return transformPoint(Ctransform, point)

proc transformRect*(transform: (var Transform){lvalue}, rectangle: FloatRect): FloatRect {.
  cdecl, dynlib: lib, importc: "sfTransform_transformRect".}
proc transformRect*(transform: Transform, rectangle: FloatRect): FloatRect =
  (var Ctransform = transform)
  return transformRect(Ctransform, rectangle)

proc combine*(transform: var Transform, other: (var Transform){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfTransform_combine".}
proc combine*(transform: var Transform, other: Transform) =
  (var Cother = other)
  combine(transform, Cother)

proc translate*(transform: var Transform, x: cfloat, y: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_translate".}

proc rotate*(transform: var Transform, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_rotate".}

proc rotate*(transform: var Transform, angle: cfloat, centerX: cfloat, centerY: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_rotateWithCenter".}

proc scale*(transform: var Transform, scaleX: cfloat, scaleY: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_scale".}

proc scale*(transform: var Transform, scaleX: cfloat, scaleY: cfloat, centerX: cfloat, centerY: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransform_scaleWithCenter".}

proc newCircleShape*(): CircleShape {.
  cdecl, dynlib: lib, importc: "sfCircleShape_create".}

proc copy*(shape: CircleShape): CircleShape {.
  cdecl, dynlib: lib, importc: "sfCircleShape_copy".}

proc destroy*(shape: CircleShape) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_destroy".}

proc `position=`*(shape: CircleShape, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setPosition".}

proc `rotation=`*(shape: CircleShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setRotation".}

proc `scale=`*(shape: CircleShape, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setScale".}

proc `origin=`*(shape: CircleShape, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setOrigin".}

proc position*(shape: CircleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getPosition".}

proc rotation*(shape: CircleShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getRotation".}

proc scale*(shape: CircleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getScale".}

proc origin*(shape: CircleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getOrigin".}

proc move*(shape: CircleShape, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_move".}

proc rotate*(shape: CircleShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_rotate".}

proc scale*(shape: CircleShape, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_scale".}

proc transform*(shape: CircleShape): Transform {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getTransform".}

proc inverseTransform*(shape: CircleShape): Transform {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getInverseTransform".}

proc setTexture*(shape: CircleShape, texture: Texture, resetRect: IntBool) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setTexture".}

proc `textureRect=`*(shape: CircleShape, rect: IntRect) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setTextureRect".}

proc `fillColor=`*(shape: CircleShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setFillColor".}

proc `outlineColor=`*(shape: CircleShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setOutlineColor".}

proc `outlineThickness=`*(shape: CircleShape, thickness: cfloat) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setOutlineThickness".}

proc texture*(shape: CircleShape): Texture {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getTexture".}

proc textureRect*(shape: CircleShape): IntRect {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getTextureRect".}

proc fillColor*(shape: CircleShape): Color {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getFillColor".}

proc outlineColor*(shape: CircleShape): Color {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getOutlineColor".}

proc outlineThickness*(shape: CircleShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getOutlineThickness".}

proc pointCount*(shape: CircleShape): cint {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getPointCount".}

proc getPoint*(shape: CircleShape, index: cint): Vector2f {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getPoint".}

proc `radius=`*(shape: CircleShape, radius: cfloat) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setRadius".}

proc radius*(shape: CircleShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getRadius".}

proc `pointCount=`*(shape: CircleShape, count: cint) {.
  cdecl, dynlib: lib, importc: "sfCircleShape_setPointCount".}

proc localBounds*(shape: CircleShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getLocalBounds".}

proc globalBounds*(shape: CircleShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfCircleShape_getGlobalBounds".}


#--- SFML/Graphics/ConvexShape ---#

proc newConvexShape*(): ConvexShape {.
  cdecl, dynlib: lib, importc: "sfConvexShape_create".}

proc copy*(shape: ConvexShape): ConvexShape {.
  cdecl, dynlib: lib, importc: "sfConvexShape_copy".}

proc destroy*(shape: ConvexShape) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_destroy".}

proc `position=`*(shape: ConvexShape, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setPosition".}

proc `rotation=`*(shape: ConvexShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setRotation".}

proc `scale=`*(shape: ConvexShape, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setScale".}

proc `origin=`*(shape: ConvexShape, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setOrigin".}

proc position*(shape: ConvexShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getPosition".}

proc rotation*(shape: ConvexShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getRotation".}

proc scale*(shape: ConvexShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getScale".}

proc origin*(shape: ConvexShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getOrigin".}

proc move*(shape: ConvexShape, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_move".}

proc rotate*(shape: ConvexShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_rotate".}

proc scale*(shape: ConvexShape, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_scale".}

proc transform*(shape: ConvexShape): Transform {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getTransform".}

proc inverseTransform*(shape: ConvexShape): Transform {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getInverseTransform".}

proc setTexture*(shape: ConvexShape, texture: Texture, resetRect: IntBool) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setTexture".}

proc `textureRect=`*(shape: ConvexShape, rect: IntRect) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setTextureRect".}

proc `fillColor=`*(shape: ConvexShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setFillColor".}

proc `outlineColor=`*(shape: ConvexShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setOutlineColor".}

proc `outlineThickness=`*(shape: ConvexShape, thickness: cfloat) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setOutlineThickness".}

proc texture*(shape: ConvexShape): Texture {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getTexture".}

proc textureRect*(shape: ConvexShape): IntRect {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getTextureRect".}

proc fillColor*(shape: ConvexShape): Color {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getFillColor".}

proc outlineColor*(shape: ConvexShape): Color {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getOutlineColor".}

proc outlineThickness*(shape: ConvexShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getOutlineThickness".}

proc pointCount*(shape: ConvexShape): cint {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getPointCount".}

proc getPoint*(shape: ConvexShape, index: cint): Vector2f {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getPoint".}

proc `pointCount=`*(shape: ConvexShape, count: cint) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setPointCount".}

proc setPoint*(shape: ConvexShape, index: cint, point: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfConvexShape_setPoint".}

proc localBounds*(shape: ConvexShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getLocalBounds".}

proc globalBounds*(shape: ConvexShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfConvexShape_getGlobalBounds".}


#--- SFML/Graphics/Font ---#


#--- SFML/Graphics/Glyph ---#

type Glyph* {.pure, final.} = object
  advance*: cint
  bounds*: IntRect
  textureRect*: IntRect

proc newFont*(filename: cstring): Font {.
  cdecl, dynlib: lib, importc: "sfFont_createFromFile".}

proc newFont*(data: pointer, sizeInBytes: int): Font {.
  cdecl, dynlib: lib, importc: "sfFont_createFromMemory".}

proc newFont*(stream: var InputStream): Font {.
  cdecl, dynlib: lib, importc: "sfFont_createFromStream".}

proc copy*(font: Font): Font {.
  cdecl, dynlib: lib, importc: "sfFont_copy".}

proc destroy*(font: Font) {.
  cdecl, dynlib: lib, importc: "sfFont_destroy".}

proc getGlyph*(font: Font, codePoint: uint32, characterSize: cint, bold: IntBool): Glyph {.
  cdecl, dynlib: lib, importc: "sfFont_getGlyph".}

proc getKerning*(font: Font, first: uint32, second: uint32, characterSize: cint): cint {.
  cdecl, dynlib: lib, importc: "sfFont_getKerning".}

proc getLineSpacing*(font: Font, characterSize: cint): cint {.
  cdecl, dynlib: lib, importc: "sfFont_getLineSpacing".}

proc getTexture*(font: Font, characterSize: cint): Texture {.
  cdecl, dynlib: lib, importc: "sfFont_getTexture".}


#--- SFML/Graphics/Image ---#

proc newImage*(width: cint, height: cint): Image {.
  cdecl, dynlib: lib, importc: "sfImage_create".}

proc newImage*(width: cint, height: cint, color: Color): Image {.
  cdecl, dynlib: lib, importc: "sfImage_createFromColor".}

proc newImage*(width: cint, height: cint, pixels: ptr uint8): Image {.
  cdecl, dynlib: lib, importc: "sfImage_createFromPixels".}

proc newImage*(filename: cstring): Image {.
  cdecl, dynlib: lib, importc: "sfImage_createFromFile".}

proc newImage*(data: pointer, size: int): Image {.
  cdecl, dynlib: lib, importc: "sfImage_createFromMemory".}

proc newImage*(stream: var InputStream): Image {.
  cdecl, dynlib: lib, importc: "sfImage_createFromStream".}

proc copy*(image: Image): Image {.
  cdecl, dynlib: lib, importc: "sfImage_copy".}

proc destroy*(image: Image) {.
  cdecl, dynlib: lib, importc: "sfImage_destroy".}

proc saveToFile*(image: Image, filename: cstring): IntBool {.
  cdecl, dynlib: lib, importc: "sfImage_saveToFile".}

proc size*(image: Image): Vector2i {.
  cdecl, dynlib: lib, importc: "sfImage_getSize".}

proc newImage*(image: Image, color: Color, alpha: uint8) {.
  cdecl, dynlib: lib, importc: "sfImage_createMaskFromColor".}

proc copyImage*(image: Image, source: Image, destX: cint, destY: cint, sourceRect: IntRect, applyAlpha: IntBool) {.
  cdecl, dynlib: lib, importc: "sfImage_copyImage".}

proc setPixel*(image: Image, x: cint, y: cint, color: Color) {.
  cdecl, dynlib: lib, importc: "sfImage_setPixel".}

proc getPixel*(image: Image, x: cint, y: cint): Color {.
  cdecl, dynlib: lib, importc: "sfImage_getPixel".}

proc pixelsPtr*(image: Image): ptr uint8 {.
  cdecl, dynlib: lib, importc: "sfImage_getPixelsPtr".}

proc flipHorizontally*(image: Image) {.
  cdecl, dynlib: lib, importc: "sfImage_flipHorizontally".}

proc flipVertically*(image: Image) {.
  cdecl, dynlib: lib, importc: "sfImage_flipVertically".}


#--- SFML/Graphics/PrimitiveType ---#

type PrimitiveType* {.pure, size: sizeof(cint).} = enum
  Points, Lines, LinesStrip, Triangles, TrianglesStrip, TrianglesFan, Quads


#--- SFML/Graphics/RectangleShape ---#

proc newRectangleShape*(): RectangleShape {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_create".}

proc copy*(shape: RectangleShape): RectangleShape {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_copy".}

proc destroy*(shape: RectangleShape) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_destroy".}

proc `position=`*(shape: RectangleShape, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setPosition".}

proc `rotation=`*(shape: RectangleShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setRotation".}

proc `scale=`*(shape: RectangleShape, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setScale".}

proc `origin=`*(shape: RectangleShape, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setOrigin".}

proc position*(shape: RectangleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getPosition".}

proc rotation*(shape: RectangleShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getRotation".}

proc scale*(shape: RectangleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getScale".}

proc origin*(shape: RectangleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getOrigin".}

proc move*(shape: RectangleShape, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_move".}

proc rotate*(shape: RectangleShape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_rotate".}

proc scale*(shape: RectangleShape, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_scale".}

proc transform*(shape: RectangleShape): Transform {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getTransform".}

proc inverseTransform*(shape: RectangleShape): Transform {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getInverseTransform".}

proc setTexture*(shape: RectangleShape, texture: Texture, resetRect: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setTexture".}

proc `textureRect=`*(shape: RectangleShape, rect: IntRect) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setTextureRect".}

proc `fillColor=`*(shape: RectangleShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setFillColor".}

proc `outlineColor=`*(shape: RectangleShape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setOutlineColor".}

proc `outlineThickness=`*(shape: RectangleShape, thickness: cfloat) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setOutlineThickness".}

proc texture*(shape: RectangleShape): Texture {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getTexture".}

proc textureRect*(shape: RectangleShape): IntRect {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getTextureRect".}

proc fillColor*(shape: RectangleShape): Color {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getFillColor".}

proc outlineColor*(shape: RectangleShape): Color {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getOutlineColor".}

proc outlineThickness*(shape: RectangleShape): cfloat {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getOutlineThickness".}

proc pointCount*(shape: RectangleShape): cint {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getPointCount".}

proc getPoint*(shape: RectangleShape, index: cint): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getPoint".}

proc `size=`*(shape: RectangleShape, size: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_setSize".}

proc size*(shape: RectangleShape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getSize".}

proc localBounds*(shape: RectangleShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getLocalBounds".}

proc globalBounds*(shape: RectangleShape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfRectangleShape_getGlobalBounds".}


#--- SFML/Graphics/RenderStates ---#

type RenderStates* {.pure, final.} = object
  blendMode*: BlendMode
  transform*: Transform
  texture*: Texture
  shader*: Shader


#--- SFML/Graphics/RenderWindow ---#


#--- SFML/Graphics/Vertex ---#

type Vertex* {.pure, final.} = object
  position*: Vector2f
  color*: Color
  texCoords*: Vector2f

proc newRenderWindow*(mode: VideoMode, title: cstring, style: uint32, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_create".}
proc newRenderWindow*(mode: VideoMode, title: cstring, style: uint32, settings: ContextSettings): RenderWindow =
  (var Csettings = settings)
  return newRenderWindow(mode, title, style, Csettings)

proc newRenderWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_createUnicode".}
proc newRenderWindow*(mode: VideoMode, title: ptr uint32, style: uint32, settings: ContextSettings): RenderWindow =
  (var Csettings = settings)
  return newRenderWindow(mode, title, style, Csettings)

proc newRenderWindow*(handle: WindowHandle, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_createFromHandle".}
proc newRenderWindow*(handle: WindowHandle, settings: ContextSettings): RenderWindow =
  (var Csettings = settings)
  return newRenderWindow(handle, Csettings)

proc destroy*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_destroy".}

proc close*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_close".}

proc isOpen*(renderWindow: RenderWindow): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_isOpen".}

proc settings*(renderWindow: RenderWindow): ContextSettings {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getSettings".}

proc pollEvent*(renderWindow: RenderWindow, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_pollEvent".}

proc waitEvent*(renderWindow: RenderWindow, event: var Event): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_waitEvent".}

proc position*(renderWindow: RenderWindow): Vector2i {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getPosition".}

proc `position=`*(renderWindow: RenderWindow, position: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setPosition".}

proc size*(renderWindow: RenderWindow): Vector2i {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getSize".}

proc `size=`*(renderWindow: RenderWindow, size: Vector2i) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setSize".}

proc `title=`*(renderWindow: RenderWindow, title: cstring) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setTitle".}

proc `unicodeTitle=`*(renderWindow: RenderWindow, title: ptr uint32) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setUnicodeTitle".}

proc setIcon*(renderWindow: RenderWindow, width: cint, height: cint, pixels: ptr uint8) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setIcon".}

proc `visible=`*(renderWindow: RenderWindow, visible: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setVisible".}

proc `mouseCursorVisible=`*(renderWindow: RenderWindow, show: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setMouseCursorVisible".}

proc `verticalSyncEnabled=`*(renderWindow: RenderWindow, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setVerticalSyncEnabled".}

proc `keyRepeatEnabled=`*(renderWindow: RenderWindow, enabled: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setKeyRepeatEnabled".}

proc `active=`*(renderWindow: RenderWindow, active: IntBool): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setActive".}

proc display*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_display".}

proc `framerateLimit=`*(renderWindow: RenderWindow, limit: cint) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setFramerateLimit".}

proc `joystickThreshold=`*(renderWindow: RenderWindow, threshold: cfloat) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setJoystickThreshold".}

proc systemHandle*(renderWindow: RenderWindow): WindowHandle {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getSystemHandle".}

proc clear*(renderWindow: RenderWindow, color: Color) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_clear".}

proc `view=`*(renderWindow: RenderWindow, view: View) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_setView".}

proc view*(renderWindow: RenderWindow): View {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getView".}

proc defaultView*(renderWindow: RenderWindow): View {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getDefaultView".}

proc getViewport*(renderWindow: RenderWindow, view: View): IntRect {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_getViewport".}

proc mapPixelToCoords*(renderWindow: RenderWindow, point: Vector2i, view: View): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_mapPixelToCoords".}

proc mapCoordsToPixel*(renderWindow: RenderWindow, point: Vector2f, view: View): Vector2i {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_mapCoordsToPixel".}

proc drawSprite*(renderWindow: RenderWindow, obj: Sprite, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawSprite".}
proc drawSprite*(renderWindow: RenderWindow, obj: Sprite, states: RenderStates) =
  (var Cstates = states)
  drawSprite(renderWindow, obj, Cstates)

proc drawText*(renderWindow: RenderWindow, obj: Text, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawText".}
proc drawText*(renderWindow: RenderWindow, obj: Text, states: RenderStates) =
  (var Cstates = states)
  drawText(renderWindow, obj, Cstates)

proc drawShape*(renderWindow: RenderWindow, obj: Shape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawShape".}
proc drawShape*(renderWindow: RenderWindow, obj: Shape, states: RenderStates) =
  (var Cstates = states)
  drawShape(renderWindow, obj, Cstates)

proc drawCircleShape*(renderWindow: RenderWindow, obj: CircleShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawCircleShape".}
proc drawCircleShape*(renderWindow: RenderWindow, obj: CircleShape, states: RenderStates) =
  (var Cstates = states)
  drawCircleShape(renderWindow, obj, Cstates)

proc drawConvexShape*(renderWindow: RenderWindow, obj: ConvexShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawConvexShape".}
proc drawConvexShape*(renderWindow: RenderWindow, obj: ConvexShape, states: RenderStates) =
  (var Cstates = states)
  drawConvexShape(renderWindow, obj, Cstates)

proc drawRectangleShape*(renderWindow: RenderWindow, obj: RectangleShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawRectangleShape".}
proc drawRectangleShape*(renderWindow: RenderWindow, obj: RectangleShape, states: RenderStates) =
  (var Cstates = states)
  drawRectangleShape(renderWindow, obj, Cstates)

proc drawVertexArray*(renderWindow: RenderWindow, obj: VertexArray, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawVertexArray".}
proc drawVertexArray*(renderWindow: RenderWindow, obj: VertexArray, states: RenderStates) =
  (var Cstates = states)
  drawVertexArray(renderWindow, obj, Cstates)

proc drawPrimitives*(renderWindow: RenderWindow, vertices: (var Vertex){lvalue}, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_drawPrimitives".}
proc drawPrimitives*(renderWindow: RenderWindow, vertices: (var Vertex){lvalue}, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  (var Cstates = states)
  drawPrimitives(renderWindow, vertices, vertexCount, kind, Cstates)
proc drawPrimitives*(renderWindow: RenderWindow, vertices: Vertex, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) =
  (var Cvertices = vertices)
  drawPrimitives(renderWindow, Cvertices, vertexCount, kind, states)
proc drawPrimitives*(renderWindow: RenderWindow, vertices: Vertex, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  (var Cvertices = vertices; var Cstates = states)
  drawPrimitives(renderWindow, Cvertices, vertexCount, kind, Cstates)

proc pushGLStates*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_pushGLStates".}

proc popGLStates*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_popGLStates".}

proc resetGLStates*(renderWindow: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_resetGLStates".}

proc capture*(renderWindow: RenderWindow): Image {.
  cdecl, dynlib: lib, importc: "sfRenderWindow_capture".}

proc mouse_getPositionRenderWindow*(relativeTo: RenderWindow): Vector2i {.
  cdecl, dynlib: lib, importc: "sfMouse_getPositionRenderWindow".}

proc mouse_setPositionRenderWindow*(position: Vector2i, relativeTo: RenderWindow) {.
  cdecl, dynlib: lib, importc: "sfMouse_setPositionRenderWindow".}


#--- SFML/Graphics/RenderTexture ---#

proc newRenderTexture*(width: cint, height: cint, depthBuffer: IntBool): RenderTexture {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_create".}

proc destroy*(renderTexture: RenderTexture) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_destroy".}

proc size*(renderTexture: RenderTexture): Vector2i {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_getSize".}

proc `active=`*(renderTexture: RenderTexture, active: IntBool): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_setActive".}

proc display*(renderTexture: RenderTexture) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_display".}

proc clear*(renderTexture: RenderTexture, color: Color) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_clear".}

proc `view=`*(renderTexture: RenderTexture, view: View) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_setView".}

proc view*(renderTexture: RenderTexture): View {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_getView".}

proc defaultView*(renderTexture: RenderTexture): View {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_getDefaultView".}

proc getViewport*(renderTexture: RenderTexture, view: View): IntRect {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_getViewport".}

proc mapPixelToCoords*(renderTexture: RenderTexture, point: Vector2i, view: View): Vector2f {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_mapPixelToCoords".}

proc mapCoordsToPixel*(renderTexture: RenderTexture, point: Vector2f, view: View): Vector2i {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_mapCoordsToPixel".}

proc drawSprite*(renderTexture: RenderTexture, obj: Sprite, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawSprite".}
proc drawSprite*(renderTexture: RenderTexture, obj: Sprite, states: RenderStates) =
  (var Cstates = states)
  drawSprite(renderTexture, obj, Cstates)

proc drawText*(renderTexture: RenderTexture, obj: Text, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawText".}
proc drawText*(renderTexture: RenderTexture, obj: Text, states: RenderStates) =
  (var Cstates = states)
  drawText(renderTexture, obj, Cstates)

proc drawShape*(renderTexture: RenderTexture, obj: Shape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawShape".}
proc drawShape*(renderTexture: RenderTexture, obj: Shape, states: RenderStates) =
  (var Cstates = states)
  drawShape(renderTexture, obj, Cstates)

proc drawCircleShape*(renderTexture: RenderTexture, obj: CircleShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawCircleShape".}
proc drawCircleShape*(renderTexture: RenderTexture, obj: CircleShape, states: RenderStates) =
  (var Cstates = states)
  drawCircleShape(renderTexture, obj, Cstates)

proc drawConvexShape*(renderTexture: RenderTexture, obj: ConvexShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawConvexShape".}
proc drawConvexShape*(renderTexture: RenderTexture, obj: ConvexShape, states: RenderStates) =
  (var Cstates = states)
  drawConvexShape(renderTexture, obj, Cstates)

proc drawRectangleShape*(renderTexture: RenderTexture, obj: RectangleShape, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawRectangleShape".}
proc drawRectangleShape*(renderTexture: RenderTexture, obj: RectangleShape, states: RenderStates) =
  (var Cstates = states)
  drawRectangleShape(renderTexture, obj, Cstates)

proc drawVertexArray*(renderTexture: RenderTexture, obj: VertexArray, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawVertexArray".}
proc drawVertexArray*(renderTexture: RenderTexture, obj: VertexArray, states: RenderStates) =
  (var Cstates = states)
  drawVertexArray(renderTexture, obj, Cstates)

proc drawPrimitives*(renderTexture: RenderTexture, vertices: (var Vertex){lvalue}, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_drawPrimitives".}
proc drawPrimitives*(renderTexture: RenderTexture, vertices: (var Vertex){lvalue}, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  (var Cstates = states)
  drawPrimitives(renderTexture, vertices, vertexCount, kind, Cstates)
proc drawPrimitives*(renderTexture: RenderTexture, vertices: Vertex, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) =
  (var Cvertices = vertices)
  drawPrimitives(renderTexture, Cvertices, vertexCount, kind, states)
proc drawPrimitives*(renderTexture: RenderTexture, vertices: Vertex, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  (var Cvertices = vertices; var Cstates = states)
  drawPrimitives(renderTexture, Cvertices, vertexCount, kind, Cstates)

proc pushGLStates*(renderTexture: RenderTexture) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_pushGLStates".}

proc popGLStates*(renderTexture: RenderTexture) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_popGLStates".}

proc resetGLStates*(renderTexture: RenderTexture) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_resetGLStates".}

proc texture*(renderTexture: RenderTexture): Texture {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_getTexture".}

proc `smooth=`*(renderTexture: RenderTexture, smooth: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_setSmooth".}

proc isSmooth*(renderTexture: RenderTexture): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_isSmooth".}

proc `repeated=`*(renderTexture: RenderTexture, repeated: IntBool) {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_setRepeated".}

proc isRepeated*(renderTexture: RenderTexture): IntBool {.
  cdecl, dynlib: lib, importc: "sfRenderTexture_isRepeated".}


#--- SFML/Graphics/Shader ---#

proc newShader*(vertexShaderFilename: cstring, fragmentShaderFilename: cstring): Shader {.
  cdecl, dynlib: lib, importc: "sfShader_createFromFile".}

proc newShader*(vertexShader: cstring, fragmentShader: cstring): Shader {.
  cdecl, dynlib: lib, importc: "sfShader_createFromMemory".}

proc newShader*(vertexShaderStream: var InputStream, fragmentShaderStream: var InputStream): Shader {.
  cdecl, dynlib: lib, importc: "sfShader_createFromStream".}

proc destroy*(shader: Shader) {.
  cdecl, dynlib: lib, importc: "sfShader_destroy".}

proc setFloatParameter*(shader: Shader, name: cstring, x: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShader_setFloatParameter".}

proc setFloat2Parameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShader_setFloat2Parameter".}

proc setFloat3Parameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat, z: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShader_setFloat3Parameter".}

proc setFloat4Parameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat, z: cfloat, w: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShader_setFloat4Parameter".}

proc setVector2Parameter*(shader: Shader, name: cstring, vector: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShader_setVector2Parameter".}

proc setVector3Parameter*(shader: Shader, name: cstring, vector: Vector3f) {.
  cdecl, dynlib: lib, importc: "sfShader_setVector3Parameter".}

proc setColorParameter*(shader: Shader, name: cstring, color: Color) {.
  cdecl, dynlib: lib, importc: "sfShader_setColorParameter".}

proc setTransformParameter*(shader: Shader, name: cstring, transform: Transform) {.
  cdecl, dynlib: lib, importc: "sfShader_setTransformParameter".}

proc setTextureParameter*(shader: Shader, name: cstring, texture: Texture) {.
  cdecl, dynlib: lib, importc: "sfShader_setTextureParameter".}

proc `currentTextureParameter=`*(shader: Shader, name: cstring) {.
  cdecl, dynlib: lib, importc: "sfShader_setCurrentTextureParameter".}

proc bindGL*(shader: Shader) {.
  cdecl, dynlib: lib, importc: "sfShader_bind".}

proc shader_isAvailable*(): IntBool {.
  cdecl, dynlib: lib, importc: "sfShader_isAvailable".}


#--- SFML/Graphics/Shape ---#

type ShapeGetPointCountCallback* = proc(p1: pointer): cint {.cdecl.}

type ShapeGetPointCallback* = proc(p1: cint; p2: pointer): Vector2f {.cdecl.}

proc newShape*(getPointCount: ShapeGetPointCountCallback, getPoint: ShapeGetPointCallback, userData: pointer): Shape {.
  cdecl, dynlib: lib, importc: "sfShape_create".}

proc destroy*(shape: Shape) {.
  cdecl, dynlib: lib, importc: "sfShape_destroy".}

proc `position=`*(shape: Shape, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShape_setPosition".}

proc `rotation=`*(shape: Shape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShape_setRotation".}

proc `scale=`*(shape: Shape, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShape_setScale".}

proc `origin=`*(shape: Shape, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShape_setOrigin".}

proc position*(shape: Shape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfShape_getPosition".}

proc rotation*(shape: Shape): cfloat {.
  cdecl, dynlib: lib, importc: "sfShape_getRotation".}

proc scale*(shape: Shape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfShape_getScale".}

proc origin*(shape: Shape): Vector2f {.
  cdecl, dynlib: lib, importc: "sfShape_getOrigin".}

proc move*(shape: Shape, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShape_move".}

proc rotate*(shape: Shape, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShape_rotate".}

proc scale*(shape: Shape, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfShape_scale".}

proc transform*(shape: Shape): Transform {.
  cdecl, dynlib: lib, importc: "sfShape_getTransform".}

proc inverseTransform*(shape: Shape): Transform {.
  cdecl, dynlib: lib, importc: "sfShape_getInverseTransform".}

proc setTexture*(shape: Shape, texture: Texture, resetRect: IntBool) {.
  cdecl, dynlib: lib, importc: "sfShape_setTexture".}

proc `textureRect=`*(shape: Shape, rect: IntRect) {.
  cdecl, dynlib: lib, importc: "sfShape_setTextureRect".}

proc `fillColor=`*(shape: Shape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfShape_setFillColor".}

proc `outlineColor=`*(shape: Shape, color: Color) {.
  cdecl, dynlib: lib, importc: "sfShape_setOutlineColor".}

proc `outlineThickness=`*(shape: Shape, thickness: cfloat) {.
  cdecl, dynlib: lib, importc: "sfShape_setOutlineThickness".}

proc texture*(shape: Shape): Texture {.
  cdecl, dynlib: lib, importc: "sfShape_getTexture".}

proc textureRect*(shape: Shape): IntRect {.
  cdecl, dynlib: lib, importc: "sfShape_getTextureRect".}

proc fillColor*(shape: Shape): Color {.
  cdecl, dynlib: lib, importc: "sfShape_getFillColor".}

proc outlineColor*(shape: Shape): Color {.
  cdecl, dynlib: lib, importc: "sfShape_getOutlineColor".}

proc outlineThickness*(shape: Shape): cfloat {.
  cdecl, dynlib: lib, importc: "sfShape_getOutlineThickness".}

proc pointCount*(shape: Shape): cint {.
  cdecl, dynlib: lib, importc: "sfShape_getPointCount".}

proc getPoint*(shape: Shape, index: cint): Vector2f {.
  cdecl, dynlib: lib, importc: "sfShape_getPoint".}

proc localBounds*(shape: Shape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfShape_getLocalBounds".}

proc globalBounds*(shape: Shape): FloatRect {.
  cdecl, dynlib: lib, importc: "sfShape_getGlobalBounds".}

proc update*(shape: Shape) {.
  cdecl, dynlib: lib, importc: "sfShape_update".}


#--- SFML/Graphics/Sprite ---#

proc newSprite*(): Sprite {.
  cdecl, dynlib: lib, importc: "sfSprite_create".}

proc copy*(sprite: Sprite): Sprite {.
  cdecl, dynlib: lib, importc: "sfSprite_copy".}

proc destroy*(sprite: Sprite) {.
  cdecl, dynlib: lib, importc: "sfSprite_destroy".}

proc `position=`*(sprite: Sprite, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfSprite_setPosition".}

proc `rotation=`*(sprite: Sprite, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSprite_setRotation".}

proc `scale=`*(sprite: Sprite, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfSprite_setScale".}

proc `origin=`*(sprite: Sprite, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfSprite_setOrigin".}

proc position*(sprite: Sprite): Vector2f {.
  cdecl, dynlib: lib, importc: "sfSprite_getPosition".}

proc rotation*(sprite: Sprite): cfloat {.
  cdecl, dynlib: lib, importc: "sfSprite_getRotation".}

proc scale*(sprite: Sprite): Vector2f {.
  cdecl, dynlib: lib, importc: "sfSprite_getScale".}

proc origin*(sprite: Sprite): Vector2f {.
  cdecl, dynlib: lib, importc: "sfSprite_getOrigin".}

proc move*(sprite: Sprite, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfSprite_move".}

proc rotate*(sprite: Sprite, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfSprite_rotate".}

proc scale*(sprite: Sprite, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfSprite_scale".}

proc transform*(sprite: Sprite): Transform {.
  cdecl, dynlib: lib, importc: "sfSprite_getTransform".}

proc inverseTransform*(sprite: Sprite): Transform {.
  cdecl, dynlib: lib, importc: "sfSprite_getInverseTransform".}

proc setTexture*(sprite: Sprite, texture: Texture, resetRect: IntBool) {.
  cdecl, dynlib: lib, importc: "sfSprite_setTexture".}

proc `textureRect=`*(sprite: Sprite, rectangle: IntRect) {.
  cdecl, dynlib: lib, importc: "sfSprite_setTextureRect".}

proc `color=`*(sprite: Sprite, color: Color) {.
  cdecl, dynlib: lib, importc: "sfSprite_setColor".}

proc texture*(sprite: Sprite): Texture {.
  cdecl, dynlib: lib, importc: "sfSprite_getTexture".}

proc textureRect*(sprite: Sprite): IntRect {.
  cdecl, dynlib: lib, importc: "sfSprite_getTextureRect".}

proc color*(sprite: Sprite): Color {.
  cdecl, dynlib: lib, importc: "sfSprite_getColor".}

proc localBounds*(sprite: Sprite): FloatRect {.
  cdecl, dynlib: lib, importc: "sfSprite_getLocalBounds".}

proc globalBounds*(sprite: Sprite): FloatRect {.
  cdecl, dynlib: lib, importc: "sfSprite_getGlobalBounds".}


#--- SFML/Graphics/Text ---#

type TextStyle* {.pure, size: sizeof(cint).} = enum
  Regular = 0, Bold = 1, Italic = 2, Underlined = 4

proc newText*(): Text {.
  cdecl, dynlib: lib, importc: "sfText_create".}

proc copy*(text: Text): Text {.
  cdecl, dynlib: lib, importc: "sfText_copy".}

proc destroy*(text: Text) {.
  cdecl, dynlib: lib, importc: "sfText_destroy".}

proc `position=`*(text: Text, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfText_setPosition".}

proc `rotation=`*(text: Text, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfText_setRotation".}

proc `scale=`*(text: Text, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfText_setScale".}

proc `origin=`*(text: Text, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfText_setOrigin".}

proc position*(text: Text): Vector2f {.
  cdecl, dynlib: lib, importc: "sfText_getPosition".}

proc rotation*(text: Text): cfloat {.
  cdecl, dynlib: lib, importc: "sfText_getRotation".}

proc scale*(text: Text): Vector2f {.
  cdecl, dynlib: lib, importc: "sfText_getScale".}

proc origin*(text: Text): Vector2f {.
  cdecl, dynlib: lib, importc: "sfText_getOrigin".}

proc move*(text: Text, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfText_move".}

proc rotate*(text: Text, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfText_rotate".}

proc scale*(text: Text, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfText_scale".}

proc transform*(text: Text): Transform {.
  cdecl, dynlib: lib, importc: "sfText_getTransform".}

proc inverseTransform*(text: Text): Transform {.
  cdecl, dynlib: lib, importc: "sfText_getInverseTransform".}

proc `string=`*(text: Text, string: cstring) {.
  cdecl, dynlib: lib, importc: "sfText_setString".}

proc `unicodeString=`*(text: Text, string: ptr uint32) {.
  cdecl, dynlib: lib, importc: "sfText_setUnicodeString".}

proc `font=`*(text: Text, font: Font) {.
  cdecl, dynlib: lib, importc: "sfText_setFont".}

proc `characterSize=`*(text: Text, size: cint) {.
  cdecl, dynlib: lib, importc: "sfText_setCharacterSize".}

proc `style=`*(text: Text, style: uint32) {.
  cdecl, dynlib: lib, importc: "sfText_setStyle".}

proc `color=`*(text: Text, color: Color) {.
  cdecl, dynlib: lib, importc: "sfText_setColor".}

proc string*(text: Text): cstring {.
  cdecl, dynlib: lib, importc: "sfText_getString".}

proc unicodeString*(text: Text): ptr uint32 {.
  cdecl, dynlib: lib, importc: "sfText_getUnicodeString".}

proc font*(text: Text): Font {.
  cdecl, dynlib: lib, importc: "sfText_getFont".}

proc characterSize*(text: Text): cint {.
  cdecl, dynlib: lib, importc: "sfText_getCharacterSize".}

proc style*(text: Text): uint32 {.
  cdecl, dynlib: lib, importc: "sfText_getStyle".}

proc color*(text: Text): Color {.
  cdecl, dynlib: lib, importc: "sfText_getColor".}

proc findCharacterPos*(text: Text, index: int): Vector2f {.
  cdecl, dynlib: lib, importc: "sfText_findCharacterPos".}

proc localBounds*(text: Text): FloatRect {.
  cdecl, dynlib: lib, importc: "sfText_getLocalBounds".}

proc globalBounds*(text: Text): FloatRect {.
  cdecl, dynlib: lib, importc: "sfText_getGlobalBounds".}


#--- SFML/Graphics/Texture ---#

proc newTexture*(width: cint, height: cint): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_create".}

proc newTexture*(filename: cstring, area: (var IntRect){lvalue}): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_createFromFile".}
proc newTexture*(filename: cstring, area: IntRect): Texture =
  (var Carea = area)
  return newTexture(filename, Carea)

proc newTexture*(data: pointer, sizeInBytes: int, area: (var IntRect){lvalue}): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_createFromMemory".}
proc newTexture*(data: pointer, sizeInBytes: int, area: IntRect): Texture =
  (var Carea = area)
  return newTexture(data, sizeInBytes, Carea)

proc newTexture*(stream: var InputStream, area: (var IntRect){lvalue}): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_createFromStream".}
proc newTexture*(stream: var InputStream, area: IntRect): Texture =
  (var Carea = area)
  return newTexture(stream, Carea)

proc newTexture*(image: Image, area: (var IntRect){lvalue}): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_createFromImage".}
proc newTexture*(image: Image, area: IntRect): Texture =
  (var Carea = area)
  return newTexture(image, Carea)

proc copy*(texture: Texture): Texture {.
  cdecl, dynlib: lib, importc: "sfTexture_copy".}

proc destroy*(texture: Texture) {.
  cdecl, dynlib: lib, importc: "sfTexture_destroy".}

proc size*(texture: Texture): Vector2i {.
  cdecl, dynlib: lib, importc: "sfTexture_getSize".}

proc copyToImage*(texture: Texture): Image {.
  cdecl, dynlib: lib, importc: "sfTexture_copyToImage".}

proc updateFromPixels*(texture: Texture, pixels: ptr uint8, width: cint, height: cint, x: cint, y: cint) {.
  cdecl, dynlib: lib, importc: "sfTexture_updateFromPixels".}

proc updateFromImage*(texture: Texture, image: Image, x: cint, y: cint) {.
  cdecl, dynlib: lib, importc: "sfTexture_updateFromImage".}

proc updateFromWindow*(texture: Texture, window: Window, x: cint, y: cint) {.
  cdecl, dynlib: lib, importc: "sfTexture_updateFromWindow".}

proc updateFromRenderWindow*(texture: Texture, renderWindow: RenderWindow, x: cint, y: cint) {.
  cdecl, dynlib: lib, importc: "sfTexture_updateFromRenderWindow".}

proc `smooth=`*(texture: Texture, smooth: IntBool) {.
  cdecl, dynlib: lib, importc: "sfTexture_setSmooth".}

proc isSmooth*(texture: Texture): IntBool {.
  cdecl, dynlib: lib, importc: "sfTexture_isSmooth".}

proc `repeated=`*(texture: Texture, repeated: IntBool) {.
  cdecl, dynlib: lib, importc: "sfTexture_setRepeated".}

proc isRepeated*(texture: Texture): IntBool {.
  cdecl, dynlib: lib, importc: "sfTexture_isRepeated".}

proc bindGL*(texture: Texture) {.
  cdecl, dynlib: lib, importc: "sfTexture_bind".}

proc texture_getMaximumSize*(): cint {.
  cdecl, dynlib: lib, importc: "sfTexture_getMaximumSize".}


#--- SFML/Graphics/Transformable ---#

proc newTransformable*(): Transformable {.
  cdecl, dynlib: lib, importc: "sfTransformable_create".}

proc copy*(transformable: Transformable): Transformable {.
  cdecl, dynlib: lib, importc: "sfTransformable_copy".}

proc destroy*(transformable: Transformable) {.
  cdecl, dynlib: lib, importc: "sfTransformable_destroy".}

proc `position=`*(transformable: Transformable, position: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfTransformable_setPosition".}

proc `rotation=`*(transformable: Transformable, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransformable_setRotation".}

proc `scale=`*(transformable: Transformable, scale: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfTransformable_setScale".}

proc `origin=`*(transformable: Transformable, origin: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfTransformable_setOrigin".}

proc position*(transformable: Transformable): Vector2f {.
  cdecl, dynlib: lib, importc: "sfTransformable_getPosition".}

proc rotation*(transformable: Transformable): cfloat {.
  cdecl, dynlib: lib, importc: "sfTransformable_getRotation".}

proc scale*(transformable: Transformable): Vector2f {.
  cdecl, dynlib: lib, importc: "sfTransformable_getScale".}

proc origin*(transformable: Transformable): Vector2f {.
  cdecl, dynlib: lib, importc: "sfTransformable_getOrigin".}

proc move*(transformable: Transformable, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfTransformable_move".}

proc rotate*(transformable: Transformable, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfTransformable_rotate".}

proc scale*(transformable: Transformable, factors: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfTransformable_scale".}

proc transform*(transformable: Transformable): Transform {.
  cdecl, dynlib: lib, importc: "sfTransformable_getTransform".}

proc inverseTransform*(transformable: Transformable): Transform {.
  cdecl, dynlib: lib, importc: "sfTransformable_getInverseTransform".}


#--- SFML/Graphics/VertexArray ---#

proc newVertexArray*(): VertexArray {.
  cdecl, dynlib: lib, importc: "sfVertexArray_create".}

proc copy*(vertexArray: VertexArray): VertexArray {.
  cdecl, dynlib: lib, importc: "sfVertexArray_copy".}

proc destroy*(vertexArray: VertexArray) {.
  cdecl, dynlib: lib, importc: "sfVertexArray_destroy".}

proc vertexCount*(vertexArray: VertexArray): cint {.
  cdecl, dynlib: lib, importc: "sfVertexArray_getVertexCount".}

proc getVertex*(vertexArray: VertexArray, index: cint): var Vertex {.
  cdecl, dynlib: lib, importc: "sfVertexArray_getVertex".}

proc clear*(vertexArray: VertexArray) {.
  cdecl, dynlib: lib, importc: "sfVertexArray_clear".}

proc resize*(vertexArray: VertexArray, vertexCount: cint) {.
  cdecl, dynlib: lib, importc: "sfVertexArray_resize".}

proc append*(vertexArray: VertexArray, vertex: Vertex) {.
  cdecl, dynlib: lib, importc: "sfVertexArray_append".}

proc `primitiveType=`*(vertexArray: VertexArray, kind: PrimitiveType) {.
  cdecl, dynlib: lib, importc: "sfVertexArray_setPrimitiveType".}

proc primitiveType*(vertexArray: VertexArray): PrimitiveType {.
  cdecl, dynlib: lib, importc: "sfVertexArray_getPrimitiveType".}

proc bounds*(vertexArray: VertexArray): FloatRect {.
  cdecl, dynlib: lib, importc: "sfVertexArray_getBounds".}


#--- SFML/Graphics/View ---#

proc newView*(): View {.
  cdecl, dynlib: lib, importc: "sfView_create".}

proc newView*(rectangle: FloatRect): View {.
  cdecl, dynlib: lib, importc: "sfView_createFromRect".}

proc copy*(view: View): View {.
  cdecl, dynlib: lib, importc: "sfView_copy".}

proc destroy*(view: View) {.
  cdecl, dynlib: lib, importc: "sfView_destroy".}

proc `center=`*(view: View, center: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfView_setCenter".}

proc `size=`*(view: View, size: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfView_setSize".}

proc `rotation=`*(view: View, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfView_setRotation".}

proc `viewport=`*(view: View, viewport: FloatRect) {.
  cdecl, dynlib: lib, importc: "sfView_setViewport".}

proc reset*(view: View, rectangle: FloatRect) {.
  cdecl, dynlib: lib, importc: "sfView_reset".}

proc center*(view: View): Vector2f {.
  cdecl, dynlib: lib, importc: "sfView_getCenter".}

proc size*(view: View): Vector2f {.
  cdecl, dynlib: lib, importc: "sfView_getSize".}

proc rotation*(view: View): cfloat {.
  cdecl, dynlib: lib, importc: "sfView_getRotation".}

proc viewport*(view: View): FloatRect {.
  cdecl, dynlib: lib, importc: "sfView_getViewport".}

proc move*(view: View, offset: Vector2f) {.
  cdecl, dynlib: lib, importc: "sfView_move".}

proc rotate*(view: View, angle: cfloat) {.
  cdecl, dynlib: lib, importc: "sfView_rotate".}

proc zoom*(view: View, factor: cfloat) {.
  cdecl, dynlib: lib, importc: "sfView_zoom".}
