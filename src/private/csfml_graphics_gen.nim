
#--- SFML/Graphics ---#


#--- SFML/Graphics/BlendMode ---#

type BlendMode* {.pure, size: sizeof(cint).} = enum  ## Available blending modes for drawing
  Alpha, Add, Multiply, None


#--- SFML/Graphics/CircleShape ---#


#--- SFML/Graphics/Color ---#

type Color* {.bycopy.} = object
  ## Utility class for manpulating RGBA colors
  r*: uint8
  g*: uint8
  b*: uint8
  a*: uint8

proc color*(red: uint8, green: uint8, blue: uint8): Color {.
  cdecl, importc: "sfColor_fromRGB".}
  ## Construct a color from its 3 RGB components
  ## 
  ## *Arguments*:
  ## - ``red``:    Red component   (0 .. 255)
  ## - ``green``:  Green component (0 .. 255)
  ## - ``blue``:   Blue component  (0 .. 255)
  ## 
  ## *Returns:* Color constructed from the components

proc color*(red: uint8, green: uint8, blue: uint8, alpha: uint8): Color {.
  cdecl, importc: "sfColor_fromRGBA".}
  ## Construct a color from its 4 RGBA components
  ## 
  ## *Arguments*:
  ## - ``red``:    Red component   (0 .. 255)
  ## - ``green``:  Green component (0 .. 255)
  ## - ``blue``:   Blue component  (0 .. 255)
  ## - ``alpha``:  Alpha component (0 .. 255)
  ## 
  ## *Returns:* Color constructed from the components

proc add*(color1: Color, color2: Color): Color {.
  cdecl, importc: "sfColor_add".}
  ## Add two colors
  ## 
  ## *Arguments*:
  ## - ``color1``:  First color
  ## - ``color2``:  Second color
  ## 
  ## *Returns:* Component-wise saturated addition of the two colors

proc modulate*(color1: Color, color2: Color): Color {.
  cdecl, importc: "sfColor_modulate".}
  ## Modulate two colors
  ## 
  ## *Arguments*:
  ## - ``color1``:  First color
  ## - ``color2``:  Second color
  ## 
  ## *Returns:* Component-wise multiplication of the two colors


#--- SFML/Graphics/Rect ---#

type FloatRect* {.bycopy.} = object
  left*: cfloat
  top*: cfloat
  width*: cfloat
  height*: cfloat

type IntRect* {.bycopy.} = object
  left*: cint
  top*: cint
  width*: cint
  height*: cint

proc contains*(rect: (var FloatRect){lvalue}, x: cfloat, y: cfloat): BoolInt {.
  cdecl, importc: "sfFloatRect_contains".}
proc contains*(rect: FloatRect, x: cfloat, y: cfloat): BoolInt =
  ## Check if a point is inside a rectangle's area
  ## 
  ## *Arguments*:
  ## - ``rect``:  Rectangle to test
  ## - ``x``:     X coordinate of the point to test
  ## - ``y``:     Y coordinate of the point to test
  ## 
  ## *Returns:* True if the point is inside
  (var Crect = rect)
  contains(Crect, x, y)

proc contains*(rect: (var IntRect){lvalue}, x: cint, y: cint): BoolInt {.
  cdecl, importc: "sfIntRect_contains".}
proc contains*(rect: IntRect, x: cint, y: cint): BoolInt =
  (var Crect = rect)
  contains(Crect, x, y)

proc intersects*(rect1: (var FloatRect){lvalue}, rect2: (var FloatRect){lvalue}, intersection: var FloatRect): BoolInt {.
  cdecl, importc: "sfFloatRect_intersects".}
proc intersects*(rect1: (var FloatRect){lvalue}, rect2: FloatRect, intersection: var FloatRect): BoolInt =
  (var Crect2 = rect2)
  intersects(rect1, Crect2, intersection)
proc intersects*(rect1: FloatRect, rect2: (var FloatRect){lvalue}, intersection: var FloatRect): BoolInt =
  (var Crect1 = rect1)
  intersects(Crect1, rect2, intersection)
proc intersects*(rect1: FloatRect, rect2: FloatRect, intersection: var FloatRect): BoolInt =
  ## Check intersection between two rectangles
  ## 
  ## *Arguments*:
  ## - ``rect1``:         First rectangle to test
  ## - ``rect2``:         Second rectangle to test
  ## - ``intersection``:  Rectangle to be filled with overlapping rect (can be NULL)
  ## 
  ## *Returns:* True if rectangles overlap
  (var Crect1 = rect1; var Crect2 = rect2)
  intersects(Crect1, Crect2, intersection)

proc intersects*(rect1: (var IntRect){lvalue}, rect2: (var IntRect){lvalue}, intersection: var IntRect): BoolInt {.
  cdecl, importc: "sfIntRect_intersects".}
proc intersects*(rect1: (var IntRect){lvalue}, rect2: IntRect, intersection: var IntRect): BoolInt =
  (var Crect2 = rect2)
  intersects(rect1, Crect2, intersection)
proc intersects*(rect1: IntRect, rect2: (var IntRect){lvalue}, intersection: var IntRect): BoolInt =
  (var Crect1 = rect1)
  intersects(Crect1, rect2, intersection)
proc intersects*(rect1: IntRect, rect2: IntRect, intersection: var IntRect): BoolInt =
  (var Crect1 = rect1; var Crect2 = rect2)
  intersects(Crect1, Crect2, intersection)


#--- SFML/Graphics/Transform ---#


#--- SFML/Graphics/Types ---#

type CircleShape* = ptr object

type ConvexShape* = ptr object

type Font* = ptr object

type Image* = ptr object

type Shader* = ptr object

type RectangleShape* = ptr object

type RenderTexture* = ptr object

type RenderWindow* = ptr object

type Shape* = ptr object

type Sprite* = ptr object

type Text* = ptr object

type Texture* = ptr object

type Transformable* = ptr object

type VertexArray* = ptr object

type View* = ptr object

type Transform* {.bycopy.} = object
  ## Encapsulate a 3x3 transform matrix
  matrix*: array[0..8, cfloat]

proc transform*(a00: cfloat, a01: cfloat, a02: cfloat, a10: cfloat, a11: cfloat, a12: cfloat, a20: cfloat, a21: cfloat, a22: cfloat): Transform {.
  cdecl, importc: "sfTransform_fromMatrix".}
  ## Create a new transform from a matrix
  ## 
  ## *Arguments*:
  ## - ``a00``:  Element (0, 0) of the matrix
  ## - ``a01``:  Element (0, 1) of the matrix
  ## - ``a02``:  Element (0, 2) of the matrix
  ## - ``a10``:  Element (1, 0) of the matrix
  ## - ``a11``:  Element (1, 1) of the matrix
  ## - ``a12``:  Element (1, 2) of the matrix
  ## - ``a20``:  Element (2, 0) of the matrix
  ## - ``a21``:  Element (2, 1) of the matrix
  ## - ``a22``:  Element (2, 2) of the matrix
  ## 
  ## *Returns:* A new Transform object

proc getMatrix*(transform: (var Transform){lvalue}, matrix: ptr cfloat) {.
  cdecl, importc: "sfTransform_getMatrix".}
proc getMatrix*(transform: Transform, matrix: ptr cfloat) =
  ## Return the 4x4 matrix of a transform
  ## 
  ## This function fills an array of 16 floats with the transform
  ## converted as a 4x4 matrix, which is directly compatible with
  ## OpenGL functions.
  ## 
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``matrix``:  Pointer to the 16-element array to fill with the matrix
  (var Ctransform = transform)
  getMatrix(Ctransform, matrix)

proc inverse*(transform: (var Transform){lvalue}): Transform {.
  cdecl, importc: "sfTransform_getInverse".}
proc inverse*(transform: Transform): Transform =
  ## Return the inverse of a transform
  ## 
  ## If the inverse cannot be computed, a new identity transform
  ## is returned.
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## *Returns:* The inverse matrix
  (var Ctransform = transform)
  inverse(Ctransform)

proc transformPoint*(transform: (var Transform){lvalue}, point: Vector2f): Vector2f {.
  cdecl, importc: "sfTransform_transformPoint".}
proc transformPoint*(transform: Transform, point: Vector2f): Vector2f =
  ## Apply a transform to a 2D point
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``point``:      Point to transform
  ## 
  ## *Returns:* Transformed point
  (var Ctransform = transform)
  transformPoint(Ctransform, point)

proc transformRect*(transform: (var Transform){lvalue}, rectangle: FloatRect): FloatRect {.
  cdecl, importc: "sfTransform_transformRect".}
proc transformRect*(transform: Transform, rectangle: FloatRect): FloatRect =
  ## Apply a transform to a rectangle
  ## 
  ## Since SFML doesn't provide support for oriented rectangles,
  ## the result of this function is always an axis-aligned
  ## rectangle. Which means that if the transform contains a
  ## rotation, the bounding rectangle of the transformed rectangle
  ## is returned.
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``rectangle``:  Rectangle to transform
  ## 
  ## *Returns:* Transformed rectangle
  (var Ctransform = transform)
  transformRect(Ctransform, rectangle)

proc combine*(transform: var Transform, other: (var Transform){lvalue}) {.
  cdecl, importc: "sfTransform_combine".}
proc combine*(transform: var Transform, other: Transform) =
  ## Combine two transforms
  ## 
  ## The result is a transform that is equivalent to applying
  ## ``transform`` followed by ``other``. Mathematically, it is
  ## equivalent to a matrix multiplication.
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``right``:      Transform to combine to ``transform``
  (var Cother = other)
  combine(transform, Cother)

proc translate*(transform: var Transform, x: cfloat, y: cfloat) {.
  cdecl, importc: "sfTransform_translate".}
  ## Combine a transform with a translation
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``x``:          Offset to apply on X axis
  ## - ``y``:          Offset to apply on Y axis

proc rotate*(transform: var Transform, angle: cfloat) {.
  cdecl, importc: "sfTransform_rotate".}
  ## Combine the current transform with a rotation
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``angle``:      Rotation angle, in degrees

proc rotate*(transform: var Transform, angle: cfloat, centerX: cfloat, centerY: cfloat) {.
  cdecl, importc: "sfTransform_rotateWithCenter".}
  ## Combine the current transform with a rotation
  ## 
  ## The center of rotation is provided for convenience as a second
  ## argument, so that you can build rotations around arbitrary points
  ## more easily (and efficiently) than the usual
  ## [translate(-center), rotate(angle), translate(center)].
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``angle``:      Rotation angle, in degrees
  ## - ``centerX``:    X coordinate of the center of rotation
  ## - ``centerY``:    Y coordinate of the center of rotation

proc scale*(transform: var Transform, scaleX: cfloat, scaleY: cfloat) {.
  cdecl, importc: "sfTransform_scale".}
  ## Combine the current transform with a scaling
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``scaleX``:     Scaling factor on the X axis
  ## - ``scaleY``:     Scaling factor on the Y axis

proc scale*(transform: var Transform, scaleX: cfloat, scaleY: cfloat, centerX: cfloat, centerY: cfloat) {.
  cdecl, importc: "sfTransform_scaleWithCenter".}
  ## Combine the current transform with a scaling
  ## 
  ## The center of scaling is provided for convenience as a second
  ## argument, so that you can build scaling around arbitrary points
  ## more easily (and efficiently) than the usual
  ## [translate(-center), scale(factors), translate(center)]
  ## 
  ## *Arguments*:
  ## - ``transform``:  Transform object
  ## - ``scaleX``:     Scaling factor on X axis
  ## - ``scaleY``:     Scaling factor on Y axis
  ## - ``centerX``:    X coordinate of the center of scaling
  ## - ``centerY``:    Y coordinate of the center of scaling

proc newCircleShape*(): CircleShape {.
  cdecl, importc: "sfCircleShape_create".}
  ## Create a new circle shape
  ## 
  ## *Returns:* A new CircleShape object, or NULL if it failed

proc copy*(shape: CircleShape): CircleShape {.
  cdecl, importc: "sfCircleShape_copy".}
  ## Copy an existing circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(shape: CircleShape) {.
  destroy, cdecl, importc: "sfCircleShape_destroy".}
  ## Destroy an existing circle Shape
  ## 
  ## *Arguments*:
  ## - ``Shape``:  Shape to delete

proc `position=`*(shape: CircleShape, position: Vector2f) {.
  cdecl, importc: "sfCircleShape_setPosition".}
  ## Set the position of a circle shape
  ## 
  ## This function completely overwrites the previous position.
  ## See CircleShape_move to apply an offset based on the previous position instead.
  ## The default position of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:     Shape object
  ## - ``position``:  New position

proc `rotation=`*(shape: CircleShape, angle: cfloat) {.
  cdecl, importc: "sfCircleShape_setRotation".}
  ## Set the orientation of a circle shape
  ## 
  ## This function completely overwrites the previous rotation.
  ## See CircleShape_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a circle Shape object is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  New rotation, in degrees

proc `scale=`*(shape: CircleShape, scale: Vector2f) {.
  cdecl, importc: "sfCircleShape_setScale".}
  ## Set the scale factors of a circle shape
  ## 
  ## This function completely overwrites the previous scale.
  ## See CircleShape_scale to add a factor based on the previous scale instead.
  ## The default scale of a circle Shape object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``scale``:  New scale factors

proc `origin=`*(shape: CircleShape, origin: Vector2f) {.
  cdecl, importc: "sfCircleShape_setOrigin".}
  ## Set the local origin of a circle shape
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``origin``:  New origin

proc position*(shape: CircleShape): Vector2f {.
  cdecl, importc: "sfCircleShape_getPosition".}
  ## Get the position of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current position

proc rotation*(shape: CircleShape): cfloat {.
  cdecl, importc: "sfCircleShape_getRotation".}
  ## Get the orientation of a circle shape
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(shape: CircleShape): Vector2f {.
  cdecl, importc: "sfCircleShape_getScale".}
  ## Get the current scale of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current scale factors

proc origin*(shape: CircleShape): Vector2f {.
  cdecl, importc: "sfCircleShape_getOrigin".}
  ## Get the local origin of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current origin

proc move*(shape: CircleShape, offset: Vector2f) {.
  cdecl, importc: "sfCircleShape_move".}
  ## Move a circle shape by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike CircleShape_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``offset``:  Offset

proc rotate*(shape: CircleShape, angle: cfloat) {.
  cdecl, importc: "sfCircleShape_rotate".}
  ## Rotate a circle shape
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike CircleShape_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  Angle of rotation, in degrees

proc scale*(shape: CircleShape, factors: Vector2f) {.
  cdecl, importc: "sfCircleShape_scale".}
  ## Scale a circle shape
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike CircleShape_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:    Shape object
  ## - ``factors``:  Scale factors

proc transform*(shape: CircleShape): Transform {.
  cdecl, importc: "sfCircleShape_getTransform".}
  ## Get the combined transform of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(shape: CircleShape): Transform {.
  cdecl, importc: "sfCircleShape_getInverseTransform".}
  ## Get the inverse of the combined transform of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc setTexture*(shape: CircleShape, texture: Texture, resetRect: BoolInt) {.
  cdecl, importc: "sfCircleShape_setTexture".}
  ## Change the source texture of a circle shape
  ## 
  ## The ``texture`` argument refers to a texture that must
  ## exist as long as the shape uses it. Indeed, the shape
  ## doesn't store its own copy of the texture, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the source texture is destroyed and the shape tries to
  ## use it, the behaviour is undefined.
  ## ``texture`` can be NULL to disable texturing.
  ## If ``resetRect`` is true, the TextureRect property of
  ## the shape is automatically adjusted to the size of the new
  ## texture. If it is false, the texture rect is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``texture``:    New texture
  ## - ``resetRect``:  Should the texture rect be reset to the size of the new texture?

proc `textureRect=`*(shape: CircleShape, rect: IntRect) {.
  cdecl, importc: "sfCircleShape_setTextureRect".}
  ## Set the sub-rectangle of the texture that a circle shape will display
  ## 
  ## The texture rect is useful when you don't want to display
  ## the whole texture, but rather a part of it.
  ## By default, the texture rect covers the entire texture.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``rect``:   Rectangle defining the region of the texture to display

proc `fillColor=`*(shape: CircleShape, color: Color) {.
  cdecl, importc: "sfCircleShape_setFillColor".}
  ## Set the fill color of a circle shape
  ## 
  ## This color is modulated (multiplied) with the shape's
  ## texture if any. It can be used to colorize the shape,
  ## or change its global opacity.
  ## You can use Transparent to make the inside of
  ## the shape transparent, and have the outline alone.
  ## By default, the shape's fill color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New color of the shape

proc `outlineColor=`*(shape: CircleShape, color: Color) {.
  cdecl, importc: "sfCircleShape_setOutlineColor".}
  ## Set the outline color of a circle shape
  ## 
  ## You can use Transparent to disable the outline.
  ## By default, the shape's outline color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New outline color of the shape

proc `outlineThickness=`*(shape: CircleShape, thickness: cfloat) {.
  cdecl, importc: "sfCircleShape_setOutlineThickness".}
  ## Set the thickness of a circle shape's outline
  ## 
  ## This number cannot be negative. Using zero disables
  ## the outline.
  ## By default, the outline thickness is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``thickness``:  New outline thickness

proc texture*(shape: CircleShape): Texture {.
  cdecl, importc: "sfCircleShape_getTexture".}
  ## Get the source texture of a circle shape
  ## 
  ## If the shape has no source texture, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the texture when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Pointer to the shape's texture

proc textureRect*(shape: CircleShape): IntRect {.
  cdecl, importc: "sfCircleShape_getTextureRect".}
  ## Get the sub-rectangle of the texture displayed by a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Texture rectangle of the shape

proc fillColor*(shape: CircleShape): Color {.
  cdecl, importc: "sfCircleShape_getFillColor".}
  ## Get the fill color of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Fill color of the shape

proc outlineColor*(shape: CircleShape): Color {.
  cdecl, importc: "sfCircleShape_getOutlineColor".}
  ## Get the outline color of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline color of the shape

proc outlineThickness*(shape: CircleShape): cfloat {.
  cdecl, importc: "sfCircleShape_getOutlineThickness".}
  ## Get the outline thickness of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline thickness of the shape

proc pointCount*(shape: CircleShape): cint {.
  cdecl, importc: "sfCircleShape_getPointCount".}
  ## Get the total number of points of a circle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Number of points of the shape

proc getPoint*(shape: CircleShape, index: cint): Vector2f {.
  cdecl, importc: "sfCircleShape_getPoint".}
  ## Get a point of a circle shape
  ## 
  ## The result is undefined if ``index`` is out of the valid range.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to get, in range [0 .. getPointCount() - 1]
  ## 
  ## *Returns:* Index-th point of the shape

proc `radius=`*(shape: CircleShape, radius: cfloat) {.
  cdecl, importc: "sfCircleShape_setRadius".}
  ## Set the radius of a circle
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``radius``:  New radius of the circle

proc radius*(shape: CircleShape): cfloat {.
  cdecl, importc: "sfCircleShape_getRadius".}
  ## Get the radius of a circle
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Radius of the circle

proc `pointCount=`*(shape: CircleShape, count: cint) {.
  cdecl, importc: "sfCircleShape_setPointCount".}
  ## Set the number of points of a circle
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``count``:  New number of points of the circle

proc localBounds*(shape: CircleShape): FloatRect {.
  cdecl, importc: "sfCircleShape_getLocalBounds".}
  ## Get the local bounding rectangle of a circle shape
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(shape: CircleShape): FloatRect {.
  cdecl, importc: "sfCircleShape_getGlobalBounds".}
  ## Get the global bounding rectangle of a circle shape
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## sprite in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Global bounding rectangle of the entity


#--- SFML/Graphics/ConvexShape ---#

proc newConvexShape*(): ConvexShape {.
  cdecl, importc: "sfConvexShape_create".}
  ## Create a new convex shape
  ## 
  ## *Returns:* A new ConvexShape object, or NULL if it failed

proc copy*(shape: ConvexShape): ConvexShape {.
  cdecl, importc: "sfConvexShape_copy".}
  ## Copy an existing convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(shape: ConvexShape) {.
  destroy, cdecl, importc: "sfConvexShape_destroy".}
  ## Destroy an existing convex Shape
  ## 
  ## *Arguments*:
  ## - ``Shape``:  Shape to delete

proc `position=`*(shape: ConvexShape, position: Vector2f) {.
  cdecl, importc: "sfConvexShape_setPosition".}
  ## Set the position of a convex shape
  ## 
  ## This function completely overwrites the previous position.
  ## See ConvexShape_move to apply an offset based on the previous position instead.
  ## The default position of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:     Shape object
  ## - ``position``:  New position

proc `rotation=`*(shape: ConvexShape, angle: cfloat) {.
  cdecl, importc: "sfConvexShape_setRotation".}
  ## Set the orientation of a convex shape
  ## 
  ## This function completely overwrites the previous rotation.
  ## See ConvexShape_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a circle Shape object is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  New rotation, in degrees

proc `scale=`*(shape: ConvexShape, scale: Vector2f) {.
  cdecl, importc: "sfConvexShape_setScale".}
  ## Set the scale factors of a convex shape
  ## 
  ## This function completely overwrites the previous scale.
  ## See ConvexShape_scale to add a factor based on the previous scale instead.
  ## The default scale of a circle Shape object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``scale``:  New scale factors

proc `origin=`*(shape: ConvexShape, origin: Vector2f) {.
  cdecl, importc: "sfConvexShape_setOrigin".}
  ## Set the local origin of a convex shape
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``origin``:  New origin

proc position*(shape: ConvexShape): Vector2f {.
  cdecl, importc: "sfConvexShape_getPosition".}
  ## Get the position of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current position

proc rotation*(shape: ConvexShape): cfloat {.
  cdecl, importc: "sfConvexShape_getRotation".}
  ## Get the orientation of a convex shape
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(shape: ConvexShape): Vector2f {.
  cdecl, importc: "sfConvexShape_getScale".}
  ## Get the current scale of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current scale factors

proc origin*(shape: ConvexShape): Vector2f {.
  cdecl, importc: "sfConvexShape_getOrigin".}
  ## Get the local origin of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current origin

proc move*(shape: ConvexShape, offset: Vector2f) {.
  cdecl, importc: "sfConvexShape_move".}
  ## Move a convex shape by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike ConvexShape_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``offset``:  Offset

proc rotate*(shape: ConvexShape, angle: cfloat) {.
  cdecl, importc: "sfConvexShape_rotate".}
  ## Rotate a convex shape
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike ConvexShape_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  Angle of rotation, in degrees

proc scale*(shape: ConvexShape, factors: Vector2f) {.
  cdecl, importc: "sfConvexShape_scale".}
  ## Scale a convex shape
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike ConvexShape_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:    Shape object
  ## - ``factors``:  Scale factors

proc transform*(shape: ConvexShape): Transform {.
  cdecl, importc: "sfConvexShape_getTransform".}
  ## Get the combined transform of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(shape: ConvexShape): Transform {.
  cdecl, importc: "sfConvexShape_getInverseTransform".}
  ## Get the inverse of the combined transform of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc setTexture*(shape: ConvexShape, texture: Texture, resetRect: BoolInt) {.
  cdecl, importc: "sfConvexShape_setTexture".}
  ## Change the source texture of a convex shape
  ## 
  ## The ``texture`` argument refers to a texture that must
  ## exist as long as the shape uses it. Indeed, the shape
  ## doesn't store its own copy of the texture, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the source texture is destroyed and the shape tries to
  ## use it, the behaviour is undefined.
  ## ``texture`` can be NULL to disable texturing.
  ## If ``resetRect`` is true, the TextureRect property of
  ## the shape is automatically adjusted to the size of the new
  ## texture. If it is false, the texture rect is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``texture``:    New texture
  ## - ``resetRect``:  Should the texture rect be reset to the size of the new texture?

proc `textureRect=`*(shape: ConvexShape, rect: IntRect) {.
  cdecl, importc: "sfConvexShape_setTextureRect".}
  ## Set the sub-rectangle of the texture that a convex shape will display
  ## 
  ## The texture rect is useful when you don't want to display
  ## the whole texture, but rather a part of it.
  ## By default, the texture rect covers the entire texture.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``rect``:   Rectangle defining the region of the texture to display

proc `fillColor=`*(shape: ConvexShape, color: Color) {.
  cdecl, importc: "sfConvexShape_setFillColor".}
  ## Set the fill color of a convex shape
  ## 
  ## This color is modulated (multiplied) with the shape's
  ## texture if any. It can be used to colorize the shape,
  ## or change its global opacity.
  ## You can use Transparent to make the inside of
  ## the shape transparent, and have the outline alone.
  ## By default, the shape's fill color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New color of the shape

proc `outlineColor=`*(shape: ConvexShape, color: Color) {.
  cdecl, importc: "sfConvexShape_setOutlineColor".}
  ## Set the outline color of a convex shape
  ## 
  ## You can use Transparent to disable the outline.
  ## By default, the shape's outline color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New outline color of the shape

proc `outlineThickness=`*(shape: ConvexShape, thickness: cfloat) {.
  cdecl, importc: "sfConvexShape_setOutlineThickness".}
  ## Set the thickness of a convex shape's outline
  ## 
  ## This number cannot be negative. Using zero disables
  ## the outline.
  ## By default, the outline thickness is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``thickness``:  New outline thickness

proc texture*(shape: ConvexShape): Texture {.
  cdecl, importc: "sfConvexShape_getTexture".}
  ## Get the source texture of a convex shape
  ## 
  ## If the shape has no source texture, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the texture when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Pointer to the shape's texture

proc textureRect*(shape: ConvexShape): IntRect {.
  cdecl, importc: "sfConvexShape_getTextureRect".}
  ## Get the sub-rectangle of the texture displayed by a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Texture rectangle of the shape

proc fillColor*(shape: ConvexShape): Color {.
  cdecl, importc: "sfConvexShape_getFillColor".}
  ## Get the fill color of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Fill color of the shape

proc outlineColor*(shape: ConvexShape): Color {.
  cdecl, importc: "sfConvexShape_getOutlineColor".}
  ## Get the outline color of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline color of the shape

proc outlineThickness*(shape: ConvexShape): cfloat {.
  cdecl, importc: "sfConvexShape_getOutlineThickness".}
  ## Get the outline thickness of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline thickness of the shape

proc pointCount*(shape: ConvexShape): cint {.
  cdecl, importc: "sfConvexShape_getPointCount".}
  ## Get the total number of points of a convex shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Number of points of the shape

proc getPoint*(shape: ConvexShape, index: cint): Vector2f {.
  cdecl, importc: "sfConvexShape_getPoint".}
  ## Get a point of a convex shape
  ## 
  ## The result is undefined if ``index`` is out of the valid range.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to get, in range [0 .. getPointCount() - 1]
  ## 
  ## *Returns:* Index-th point of the shape

proc `pointCount=`*(shape: ConvexShape, count: cint) {.
  cdecl, importc: "sfConvexShape_setPointCount".}
  ## Set the number of points of a convex shap
  ## 
  ## ``count`` must be greater than 2 to define a valid shape.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``count``:  New number of points of the shape

proc setPoint*(shape: ConvexShape, index: cint, point: Vector2f) {.
  cdecl, importc: "sfConvexShape_setPoint".}
  ## Set the position of a point in a convex shape
  ## 
  ## Don't forget that the polygon must remain convex, and
  ## the points need to stay ordered!
  ## setPointCount must be called first in order to set the total
  ## number of points. The result is undefined if ``index`` is out
  ## of the valid range.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to change, in range [0 .. GetPointCount() - 1]
  ## - ``point``:  New point

proc localBounds*(shape: ConvexShape): FloatRect {.
  cdecl, importc: "sfConvexShape_getLocalBounds".}
  ## Get the local bounding rectangle of a convex shape
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(shape: ConvexShape): FloatRect {.
  cdecl, importc: "sfConvexShape_getGlobalBounds".}
  ## Get the global bounding rectangle of a convex shape
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## sprite in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Global bounding rectangle of the entity


#--- SFML/Graphics/Font ---#


#--- SFML/Graphics/Glyph ---#

type Glyph* {.bycopy.} = object
  ## Glyph describes a glyph (a visual character)
  advance*: cint
  bounds*: IntRect
  textureRect*: IntRect

proc newFont*(filename: cstring): Font {.
  cdecl, importc: "sfFont_createFromFile".}
  ## Create a new font from a file
  ## 
  ## *Arguments*:
  ## - ``filename``:  Path of the font file to load
  ## 
  ## *Returns:* A new Font object, or NULL if it failed

proc newFont*(data: pointer, sizeInBytes: int): Font {.
  cdecl, importc: "sfFont_createFromMemory".}
  ## Create a new image font a file in memory
  ## 
  ## *Arguments*:
  ## - ``data``:         Pointer to the file data in memory
  ## - ``sizeInBytes``:  Size of the data to load, in bytes
  ## 
  ## *Returns:* A new Font object, or NULL if it failed

proc newFont*(stream: var InputStream): Font {.
  cdecl, importc: "sfFont_createFromStream".}
  ## Create a new image font a custom stream
  ## 
  ## *Arguments*:
  ## - ``stream``:  Source stream to read from
  ## 
  ## *Returns:* A new Font object, or NULL if it failed

proc copy*(font: Font): Font {.
  cdecl, importc: "sfFont_copy".}
  ## Copy an existing font
  ## 
  ## *Arguments*:
  ## - ``font``:  Font to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(font: Font) {.
  destroy, cdecl, importc: "sfFont_destroy".}
  ## Destroy an existing font
  ## 
  ## *Arguments*:
  ## - ``font``:  Font to delete

proc getGlyph*(font: Font, codePoint: RuneU32, characterSize: cint, bold: BoolInt): Glyph {.
  cdecl, importc: "sfFont_getGlyph".}
  ## Get a glyph in a font
  ## 
  ## *Arguments*:
  ## - ``font``:           Source font
  ## - ``codePoint``:      Unicode code point of the character to get
  ## - ``characterSize``:  Character size, in pixels
  ## - ``bold``:           Retrieve the bold version or the regular one?
  ## 
  ## *Returns:* The corresponding glyph

proc getKerning*(font: Font, first: RuneU32, second: RuneU32, characterSize: cint): cint {.
  cdecl, importc: "sfFont_getKerning".}
  ## Get the kerning value corresponding to a given pair of characters in a font
  ## 
  ## *Arguments*:
  ## - ``font``:           Source font
  ## - ``first``:          Unicode code point of the first character
  ## - ``second``:         Unicode code point of the second character
  ## - ``characterSize``:  Character size, in pixels
  ## 
  ## *Returns:* Kerning offset, in pixels

proc getLineSpacing*(font: Font, characterSize: cint): cint {.
  cdecl, importc: "sfFont_getLineSpacing".}
  ## Get the line spacing value
  ## 
  ## *Arguments*:
  ## - ``font``:           Source font
  ## - ``characterSize``:  Character size, in pixels
  ## 
  ## *Returns:* Line spacing, in pixels

proc getTexture*(font: Font, characterSize: cint): Texture {.
  cdecl, importc: "sfFont_getTexture".}
  ## Get the texture containing the glyphs of a given size in a font
  ## 
  ## *Arguments*:
  ## - ``font``:           Source font
  ## - ``characterSize``:  Character size, in pixels
  ## 
  ## *Returns:* Read-only pointer to the texture


#--- SFML/Graphics/Image ---#

proc newImage*(width: cint, height: cint): Image {.
  cdecl, importc: "sfImage_create".}
  ## Create an image
  ## 
  ## This image is filled with black pixels.
  ## 
  ## *Arguments*:
  ## - ``width``:   Width of the image
  ## - ``height``:  Height of the image
  ## 
  ## *Returns:* A new Image object

proc newImage*(width: cint, height: cint, color: Color): Image {.
  cdecl, importc: "sfImage_createFromColor".}
  ## Create an image and fill it with a unique color
  ## 
  ## *Arguments*:
  ## - ``width``:   Width of the image
  ## - ``height``:  Height of the image
  ## - ``color``:   Fill color
  ## 
  ## *Returns:* A new Image object

proc newImage*(width: cint, height: cint, pixels: ptr uint8): Image {.
  cdecl, importc: "sfImage_createFromPixels".}
  ## Create an image from an array of pixels
  ## 
  ## The ``pixel`` array is assumed to contain 32-bits RGBA pixels,
  ## and have the given ``width`` and ``height``. If not, this is
  ## an undefined behaviour.
  ## If ``pixels`` is null, an empty image is created.
  ## 
  ## *Arguments*:
  ## - ``width``:   Width of the image
  ## - ``height``:  Height of the image
  ## - ``pixels``:  Array of pixels to copy to the image
  ## 
  ## *Returns:* A new Image object

proc newImage*(filename: cstring): Image {.
  cdecl, importc: "sfImage_createFromFile".}
  ## Create an image from a file on disk
  ## 
  ## The supported image formats are bmp, png, tga, jpg, gif,
  ## psd, hdr and pic. Some format options are not supported,
  ## like progressive jpeg.
  ## If this function fails, the image is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``filename``:  Path of the image file to load
  ## 
  ## *Returns:* A new Image object, or NULL if it failed

proc newImage*(data: pointer, size: int): Image {.
  cdecl, importc: "sfImage_createFromMemory".}
  ## Create an image from a file in memory
  ## 
  ## The supported image formats are bmp, png, tga, jpg, gif,
  ## psd, hdr and pic. Some format options are not supported,
  ## like progressive jpeg.
  ## If this function fails, the image is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``data``:  Pointer to the file data in memory
  ## - ``size``:  Size of the data to load, in bytes
  ## 
  ## *Returns:* A new Image object, or NULL if it failed

proc newImage*(stream: var InputStream): Image {.
  cdecl, importc: "sfImage_createFromStream".}
  ## Create an image from a custom stream
  ## 
  ## The supported image formats are bmp, png, tga, jpg, gif,
  ## psd, hdr and pic. Some format options are not supported,
  ## like progressive jpeg.
  ## If this function fails, the image is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``stream``:  Source stream to read from
  ## 
  ## *Returns:* A new Image object, or NULL if it failed

proc copy*(image: Image): Image {.
  cdecl, importc: "sfImage_copy".}
  ## Copy an existing image
  ## 
  ## *Arguments*:
  ## - ``image``:  Image to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(image: Image) {.
  destroy, cdecl, importc: "sfImage_destroy".}
  ## Destroy an existing image
  ## 
  ## *Arguments*:
  ## - ``image``:  Image to delete

proc saveToFile*(image: Image, filename: cstring): BoolInt {.
  cdecl, importc: "sfImage_saveToFile".}
  ## Save an image to a file on disk
  ## 
  ## The format of the image is automatically deduced from
  ## the extension. The supported image formats are bmp, png,
  ## tga and jpg. The destination file is overwritten
  ## if it already exists. This function fails if the image is empty.
  ## 
  ## *Arguments*:
  ## - ``image``:     Image object
  ## - ``filename``:  Path of the file to save
  ## 
  ## *Returns:* True if saving was successful

proc size*(image: Image): Vector2i {.
  cdecl, importc: "sfImage_getSize".}
  ## Return the size of an image
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object
  ## 
  ## *Returns:* Size in pixels

proc newImage*(image: Image, color: Color, alpha: uint8) {.
  cdecl, importc: "sfImage_createMaskFromColor".}
  ## Create a transparency mask from a specified color-key
  ## 
  ## This function sets the alpha value of every pixel matching
  ## the given color to ``alpha`` (0 by default), so that they
  ## become transparent.
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object
  ## - ``color``:  Color to make transparent
  ## - ``alpha``:  Alpha value to assign to transparent pixels

proc copyImage*(image: Image, source: Image, destX: cint, destY: cint, sourceRect: IntRect, applyAlpha: BoolInt) {.
  cdecl, importc: "sfImage_copyImage".}
  ## Copy pixels from an image onto another
  ## 
  ## This function does a slow pixel copy and should not be
  ## used intensively. It can be used to prepare a complex
  ## static image from several others, but if you need this
  ## kind of feature in real-time you'd better use RenderTexture.
  ## 
  ## If ``sourceRect`` is empty, the whole image is copied.
  ## If ``applyAlpha`` is set to true, the transparency of
  ## source pixels is applied. If it is false, the pixels are
  ## copied unchanged with their alpha value.
  ## 
  ## *Arguments*:
  ## - ``image``:       Image object
  ## - ``source``:      Source image to copy
  ## - ``destX``:       X coordinate of the destination position
  ## - ``destY``:       Y coordinate of the destination position
  ## - ``sourceRect``:  Sub-rectangle of the source image to copy
  ## - ``applyAlpha``:  Should the copy take in account the source transparency?

proc setPixel*(image: Image, x: cint, y: cint, color: Color) {.
  cdecl, importc: "sfImage_setPixel".}
  ## Change the color of a pixel in an image
  ## 
  ## This function doesn't check the validity of the pixel
  ## coordinates, using out-of-range values will result in
  ## an undefined behaviour.
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object
  ## - ``x``:      X coordinate of pixel to change
  ## - ``y``:      Y coordinate of pixel to change
  ## - ``color``:  New color of the pixel

proc getPixel*(image: Image, x: cint, y: cint): Color {.
  cdecl, importc: "sfImage_getPixel".}
  ## Get the color of a pixel in an image
  ## 
  ## This function doesn't check the validity of the pixel
  ## coordinates, using out-of-range values will result in
  ## an undefined behaviour.
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object
  ## - ``x``:      X coordinate of pixel to get
  ## - ``y``:      Y coordinate of pixel to get
  ## 
  ## *Returns:* Color of the pixel at coordinates (x, y)

proc pixelsPtr*(image: Image): ptr uint8 {.
  cdecl, importc: "sfImage_getPixelsPtr".}
  ## Get a read-only pointer to the array of pixels of an image
  ## 
  ## The returned value points to an array of RGBA pixels made of
  ## 8 bits integers components. The size of the array is
  ## getWidth() * getHeight() * 4.
  ## Warning: the returned pointer may become invalid if you
  ## modify the image, so you should never store it for too long.
  ## If the image is empty, a null pointer is returned.
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object
  ## 
  ## *Returns:* Read-only pointer to the array of pixels

proc flipHorizontally*(image: Image) {.
  cdecl, importc: "sfImage_flipHorizontally".}
  ## Flip an image horizontally (left <-> right)
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object

proc flipVertically*(image: Image) {.
  cdecl, importc: "sfImage_flipVertically".}
  ## Flip an image vertically (top <-> bottom)
  ## 
  ## *Arguments*:
  ## - ``image``:  Image object


#--- SFML/Graphics/PrimitiveType ---#

type PrimitiveType* {.pure, size: sizeof(cint).} = enum  ## Types of primitives that a sf::VertexArray can render
  ## 
  ## Points and lines have no area, therefore their thickness
  ## will always be 1 pixel, regardless the current transform
  ## and view.
  Points, Lines, LinesStrip, Triangles, TrianglesStrip, TrianglesFan, Quads


#--- SFML/Graphics/RectangleShape ---#

proc newRectangleShape*(): RectangleShape {.
  cdecl, importc: "sfRectangleShape_create".}
  ## Create a new rectangle shape
  ## 
  ## *Returns:* A new RectangleShape object, or NULL if it failed

proc copy*(shape: RectangleShape): RectangleShape {.
  cdecl, importc: "sfRectangleShape_copy".}
  ## Copy an existing rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(shape: RectangleShape) {.
  destroy, cdecl, importc: "sfRectangleShape_destroy".}
  ## Destroy an existing rectangle shape
  ## 
  ## *Arguments*:
  ## - ``Shape``:  Shape to delete

proc `position=`*(shape: RectangleShape, position: Vector2f) {.
  cdecl, importc: "sfRectangleShape_setPosition".}
  ## Set the position of a rectangle shape
  ## 
  ## This function completely overwrites the previous position.
  ## See RectangleShape_move to apply an offset based on the previous position instead.
  ## The default position of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:     Shape object
  ## - ``position``:  New position

proc `rotation=`*(shape: RectangleShape, angle: cfloat) {.
  cdecl, importc: "sfRectangleShape_setRotation".}
  ## Set the orientation of a rectangle shape
  ## 
  ## This function completely overwrites the previous rotation.
  ## See RectangleShape_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a circle Shape object is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  New rotation, in degrees

proc `scale=`*(shape: RectangleShape, scale: Vector2f) {.
  cdecl, importc: "sfRectangleShape_setScale".}
  ## Set the scale factors of a rectangle shape
  ## 
  ## This function completely overwrites the previous scale.
  ## See RectangleShape_scale to add a factor based on the previous scale instead.
  ## The default scale of a circle Shape object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``scale``:  New scale factors

proc `origin=`*(shape: RectangleShape, origin: Vector2f) {.
  cdecl, importc: "sfRectangleShape_setOrigin".}
  ## Set the local origin of a rectangle shape
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``origin``:  New origin

proc position*(shape: RectangleShape): Vector2f {.
  cdecl, importc: "sfRectangleShape_getPosition".}
  ## Get the position of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current position

proc rotation*(shape: RectangleShape): cfloat {.
  cdecl, importc: "sfRectangleShape_getRotation".}
  ## Get the orientation of a rectangle shape
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(shape: RectangleShape): Vector2f {.
  cdecl, importc: "sfRectangleShape_getScale".}
  ## Get the current scale of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current scale factors

proc origin*(shape: RectangleShape): Vector2f {.
  cdecl, importc: "sfRectangleShape_getOrigin".}
  ## Get the local origin of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current origin

proc move*(shape: RectangleShape, offset: Vector2f) {.
  cdecl, importc: "sfRectangleShape_move".}
  ## Move a rectangle shape by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike RectangleShape_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``offset``:  Offset

proc rotate*(shape: RectangleShape, angle: cfloat) {.
  cdecl, importc: "sfRectangleShape_rotate".}
  ## Rotate a rectangle shape
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike RectangleShape_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  Angle of rotation, in degrees

proc scale*(shape: RectangleShape, factors: Vector2f) {.
  cdecl, importc: "sfRectangleShape_scale".}
  ## Scale a rectangle shape
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike RectangleShape_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:    Shape object
  ## - ``factors``:  Scale factors

proc transform*(shape: RectangleShape): Transform {.
  cdecl, importc: "sfRectangleShape_getTransform".}
  ## Get the combined transform of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(shape: RectangleShape): Transform {.
  cdecl, importc: "sfRectangleShape_getInverseTransform".}
  ## Get the inverse of the combined transform of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc setTexture*(shape: RectangleShape, texture: Texture, resetRect: BoolInt) {.
  cdecl, importc: "sfRectangleShape_setTexture".}
  ## Change the source texture of a rectangle shape
  ## 
  ## The ``texture`` argument refers to a texture that must
  ## exist as long as the shape uses it. Indeed, the shape
  ## doesn't store its own copy of the texture, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the source texture is destroyed and the shape tries to
  ## use it, the behaviour is undefined.
  ## ``texture`` can be NULL to disable texturing.
  ## If ``resetRect`` is true, the TextureRect property of
  ## the shape is automatically adjusted to the size of the new
  ## texture. If it is false, the texture rect is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``texture``:    New texture
  ## - ``resetRect``:  Should the texture rect be reset to the size of the new texture?

proc `textureRect=`*(shape: RectangleShape, rect: IntRect) {.
  cdecl, importc: "sfRectangleShape_setTextureRect".}
  ## Set the sub-rectangle of the texture that a rectangle shape will display
  ## 
  ## The texture rect is useful when you don't want to display
  ## the whole texture, but rather a part of it.
  ## By default, the texture rect covers the entire texture.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``rect``:   Rectangle defining the region of the texture to display

proc `fillColor=`*(shape: RectangleShape, color: Color) {.
  cdecl, importc: "sfRectangleShape_setFillColor".}
  ## Set the fill color of a rectangle shape
  ## 
  ## This color is modulated (multiplied) with the shape's
  ## texture if any. It can be used to colorize the shape,
  ## or change its global opacity.
  ## You can use Transparent to make the inside of
  ## the shape transparent, and have the outline alone.
  ## By default, the shape's fill color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New color of the shape

proc `outlineColor=`*(shape: RectangleShape, color: Color) {.
  cdecl, importc: "sfRectangleShape_setOutlineColor".}
  ## Set the outline color of a rectangle shape
  ## 
  ## You can use Transparent to disable the outline.
  ## By default, the shape's outline color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New outline color of the shape

proc `outlineThickness=`*(shape: RectangleShape, thickness: cfloat) {.
  cdecl, importc: "sfRectangleShape_setOutlineThickness".}
  ## Set the thickness of a rectangle shape's outline
  ## 
  ## This number cannot be negative. Using zero disables
  ## the outline.
  ## By default, the outline thickness is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``thickness``:  New outline thickness

proc texture*(shape: RectangleShape): Texture {.
  cdecl, importc: "sfRectangleShape_getTexture".}
  ## Get the source texture of a rectangle shape
  ## 
  ## If the shape has no source texture, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the texture when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Pointer to the shape's texture

proc textureRect*(shape: RectangleShape): IntRect {.
  cdecl, importc: "sfRectangleShape_getTextureRect".}
  ## Get the sub-rectangle of the texture displayed by a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Texture rectangle of the shape

proc fillColor*(shape: RectangleShape): Color {.
  cdecl, importc: "sfRectangleShape_getFillColor".}
  ## Get the fill color of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Fill color of the shape

proc outlineColor*(shape: RectangleShape): Color {.
  cdecl, importc: "sfRectangleShape_getOutlineColor".}
  ## Get the outline color of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline color of the shape

proc outlineThickness*(shape: RectangleShape): cfloat {.
  cdecl, importc: "sfRectangleShape_getOutlineThickness".}
  ## Get the outline thickness of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline thickness of the shape

proc pointCount*(shape: RectangleShape): cint {.
  cdecl, importc: "sfRectangleShape_getPointCount".}
  ## Get the total number of points of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Number of points of the shape

proc getPoint*(shape: RectangleShape, index: cint): Vector2f {.
  cdecl, importc: "sfRectangleShape_getPoint".}
  ## Get a point of a rectangle shape
  ## 
  ## The result is undefined if ``index`` is out of the valid range.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to get, in range [0 .. getPointCount() - 1]
  ## 
  ## *Returns:* Index-th point of the shape

proc `size=`*(shape: RectangleShape, size: Vector2f) {.
  cdecl, importc: "sfRectangleShape_setSize".}
  ## Set the size of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``size``:   New size of the rectangle

proc size*(shape: RectangleShape): Vector2f {.
  cdecl, importc: "sfRectangleShape_getSize".}
  ## Get the size of a rectangle shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* height Size of the rectangle

proc localBounds*(shape: RectangleShape): FloatRect {.
  cdecl, importc: "sfRectangleShape_getLocalBounds".}
  ## Get the local bounding rectangle of a rectangle shape
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(shape: RectangleShape): FloatRect {.
  cdecl, importc: "sfRectangleShape_getGlobalBounds".}
  ## Get the global bounding rectangle of a rectangle shape
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## sprite in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Global bounding rectangle of the entity


#--- SFML/Graphics/RenderStates ---#

type RenderStates* {.bycopy.} = object
  ## Define the states used for drawing to a RenderTarget
  blendMode*: BlendMode
  transform*: Transform
  texture*: Texture
  shader*: Shader


#--- SFML/Graphics/RenderWindow ---#


#--- SFML/Graphics/Vertex ---#

type Vertex* {.bycopy.} = object
  position*: Vector2f
  color*: Color
  texCoords*: Vector2f

proc newRenderWindowC*(mode: VideoMode, title: cstring, style: BitMaskU32, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, importc: "sfRenderWindow_create".}
proc newRenderWindowC*(mode: VideoMode, title: cstring, style: BitMaskU32, settings: ContextSettings): RenderWindow =
  ## Construct a new render window
  ## 
  ## *Arguments*:
  ## - ``mode``:      Video mode to use
  ## - ``title``:     Title of the window
  ## - ``style``:     Window style
  ## - ``settings``:  Creation settings (pass NULL to use default values)
  (var Csettings = settings)
  newRenderWindowC(mode, title, style, Csettings)

proc newRenderWindow_U32(mode: VideoMode, title: StringU32, style: BitMaskU32, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, importc: "sfRenderWindow_createUnicode".}
proc newRenderWindow_U32(mode: VideoMode, title: StringU32, style: BitMaskU32, settings: ContextSettings): RenderWindow =
  ## Construct a new render window (with a UTF-32 title)
  ## 
  ## *Arguments*:
  ## - ``mode``:      Video mode to use
  ## - ``title``:     Title of the window (UTF-32)
  ## - ``style``:     Window style
  ## - ``settings``:  Creation settings (pass NULL to use default values)
  (var Csettings = settings)
  newRenderWindow_U32(mode, title, style, Csettings)

proc newRenderWindow*(handle: WindowHandle, settings: (var ContextSettings){lvalue}): RenderWindow {.
  cdecl, importc: "sfRenderWindow_createFromHandle".}
proc newRenderWindow*(handle: WindowHandle, settings: ContextSettings): RenderWindow =
  ## Construct a render window from an existing control
  ## 
  ## *Arguments*:
  ## - ``handle``:    Platform-specific handle of the control
  ## - ``settings``:  Creation settings (pass NULL to use default values)
  (var Csettings = settings)
  newRenderWindow(handle, Csettings)

proc destroy*(renderWindow: RenderWindow) {.
  destroy, cdecl, importc: "sfRenderWindow_destroy".}
  ## Destroy an existing render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window to destroy

proc close*(renderWindow: RenderWindow) {.
  cdecl, importc: "sfRenderWindow_close".}
  ## Close a render window (but doesn't destroy the internal data)
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window to close

proc open*(renderWindow: RenderWindow): BoolInt {.
  cdecl, importc: "sfRenderWindow_isOpen".}
  ## Tell whether or not a render window is opened
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object

proc settings*(renderWindow: RenderWindow): ContextSettings {.
  cdecl, importc: "sfRenderWindow_getSettings".}
  ## Get the creation settings of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Settings used to create the window

proc pollEvent*(renderWindow: RenderWindow, event: var Event): BoolInt {.
  cdecl, importc: "sfRenderWindow_pollEvent".}
  ## Get the event on top of event queue of a render window, if any, and pop it
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``event``:         Event to fill, if any
  ## 
  ## *Returns:* True if an event was returned, False if event queue was empty

proc waitEvent*(renderWindow: RenderWindow, event: var Event): BoolInt {.
  cdecl, importc: "sfRenderWindow_waitEvent".}
  ## Wait for an event and return it
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``event``:         Event to fill
  ## 
  ## *Returns:* False if an error occured

proc position*(renderWindow: RenderWindow): Vector2i {.
  cdecl, importc: "sfRenderWindow_getPosition".}
  ## Get the position of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Position in pixels

proc `position=`*(renderWindow: RenderWindow, position: Vector2i) {.
  cdecl, importc: "sfRenderWindow_setPosition".}
  ## Change the position of a render window on screen
  ## 
  ## Only works for top-level windows
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``position``:      New position, in pixels

proc size*(renderWindow: RenderWindow): Vector2i {.
  cdecl, importc: "sfRenderWindow_getSize".}
  ## Get the size of the rendering region of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Size in pixels

proc `size=`*(renderWindow: RenderWindow, size: Vector2i) {.
  cdecl, importc: "sfRenderWindow_setSize".}
  ## Change the size of the rendering region of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``size``:          New size, in pixels

proc `titleC=`*(renderWindow: RenderWindow, title: cstring) {.
  cdecl, importc: "sfRenderWindow_setTitle".}
  ## Change the title of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``title``:         New title

proc `title_U32=`(renderWindow: RenderWindow, title: StringU32) {.
  cdecl, importc: "sfRenderWindow_setUnicodeTitle".}
  ## Change the title of a render window (with a UTF-32 string)
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``title``:         New title

proc setIcon*(renderWindow: RenderWindow, width: cint, height: cint, pixels: ptr uint8) {.
  cdecl, importc: "sfRenderWindow_setIcon".}
  ## Change a render window's icon
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``width``:         Icon's width, in pixels
  ## - ``height``:        Icon's height, in pixels
  ## - ``pixels``:        Pointer to the pixels in memory, format must be RGBA 32 bits

proc `visible=`*(renderWindow: RenderWindow, visible: BoolInt) {.
  cdecl, importc: "sfRenderWindow_setVisible".}
  ## Show or hide a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``visible``:       True to show the window, False to hide it

proc `mouseCursorVisible=`*(renderWindow: RenderWindow, show: BoolInt) {.
  cdecl, importc: "sfRenderWindow_setMouseCursorVisible".}
  ## Show or hide the mouse cursor on a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``show``:          True to show, False to hide

proc `verticalSyncEnabled=`*(renderWindow: RenderWindow, enabled: BoolInt) {.
  cdecl, importc: "sfRenderWindow_setVerticalSyncEnabled".}
  ## Enable / disable vertical synchronization on a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``enabled``:       True to enable v-sync, False to deactivate

proc `keyRepeatEnabled=`*(renderWindow: RenderWindow, enabled: BoolInt) {.
  cdecl, importc: "sfRenderWindow_setKeyRepeatEnabled".}
  ## Enable or disable automatic key-repeat for keydown events
  ## 
  ## Automatic key-repeat is enabled by default
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``enabled``:       True to enable, False to disable

proc `active=`*(renderWindow: RenderWindow, active: BoolInt): BoolInt {.
  cdecl, importc: "sfRenderWindow_setActive".}
  ## Activate or deactivate a render window as the current target for rendering
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``active``:        True to activate, False to deactivate
  ## 
  ## *Returns:* True if operation was successful, false otherwise

proc display*(renderWindow: RenderWindow) {.
  cdecl, importc: "sfRenderWindow_display".}
  ## Display a render window on screen
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object

proc `framerateLimit=`*(renderWindow: RenderWindow, limit: cint) {.
  cdecl, importc: "sfRenderWindow_setFramerateLimit".}
  ## Limit the framerate to a maximum fixed frequency for a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``limit``:         Framerate limit, in frames per seconds (use 0 to disable limit)

proc `joystickThreshold=`*(renderWindow: RenderWindow, threshold: cfloat) {.
  cdecl, importc: "sfRenderWindow_setJoystickThreshold".}
  ## Change the joystick threshold, ie. the value below which no move event will be generated
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``threshold``:     New threshold, in range [0, 100]

proc systemHandle*(renderWindow: RenderWindow): WindowHandle {.
  cdecl, importc: "sfRenderWindow_getSystemHandle".}
  ## Retrieve the OS-specific handle of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Window handle

proc clear*(renderWindow: RenderWindow, color: Color) {.
  cdecl, importc: "sfRenderWindow_clear".}
  ## Clear a render window with the given color
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``color``:         Fill color

proc `view=`*(renderWindow: RenderWindow, view: View) {.
  cdecl, importc: "sfRenderWindow_setView".}
  ## Change the current active view of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``view``:          Pointer to the new view

proc view*(renderWindow: RenderWindow): View {.
  cdecl, importc: "sfRenderWindow_getView".}
  ## Get the current active view of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Current active view

proc defaultView*(renderWindow: RenderWindow): View {.
  cdecl, importc: "sfRenderWindow_getDefaultView".}
  ## Get the default view of a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* Default view of the render window

proc getViewport*(renderWindow: RenderWindow, view: View): IntRect {.
  cdecl, importc: "sfRenderWindow_getViewport".}
  ## Get the viewport of a view applied to this target
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``view``:          Target view
  ## 
  ## *Returns:* Viewport rectangle, expressed in pixels in the current target

proc mapPixelToCoords*(renderWindow: RenderWindow, point: Vector2i, view: View): Vector2f {.
  cdecl, importc: "sfRenderWindow_mapPixelToCoords".}
  ## Convert a point from window coordinates to world coordinates
  ## 
  ## This function finds the 2D position that matches the
  ## given pixel of the render-window. In other words, it does
  ## the inverse of what the graphics card does, to find the
  ## initial position of a rendered pixel.
  ## 
  ## Initially, both coordinate systems (world units and target pixels)
  ## match perfectly. But if you define a custom view or resize your
  ## render-window, this assertion is not true anymore, ie. a point
  ## located at (10, 50) in your render-window may map to the point
  ## (150, 75) in your 2D world -- if the view is translated by (140, 25).
  ## 
  ## This function is typically used to find which point (or object) is
  ## located below the mouse cursor.
  ## 
  ## This version uses a custom view for calculations, see the other
  ## overload of the function if you want to use the current view of the
  ## render-window.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``point``:  Pixel to convert
  ## - ``view``:  The view to use for converting the point
  ## 
  ## *Returns:* The converted point, in "world" units

proc mapCoordsToPixel*(renderWindow: RenderWindow, point: Vector2f, view: View): Vector2i {.
  cdecl, importc: "sfRenderWindow_mapCoordsToPixel".}
  ## Convert a point from world coordinates to window coordinates
  ## 
  ## This function finds the pixel of the render-window that matches
  ## the given 2D point. In other words, it goes through the same process
  ## as the graphics card, to compute the final position of a rendered point.
  ## 
  ## Initially, both coordinate systems (world units and target pixels)
  ## match perfectly. But if you define a custom view or resize your
  ## render-window, this assertion is not true anymore, ie. a point
  ## located at (150, 75) in your 2D world may map to the pixel
  ## (10, 50) of your render-window -- if the view is translated by (140, 25).
  ## 
  ## This version uses a custom view for calculations, see the other
  ## overload of the function if you want to use the current view of the
  ## render-window.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## - ``point``:  Point to convert
  ## - ``view``:  The view to use for converting the point
  ## 
  ## *Returns:* The converted point, in target coordinates (pixels)

proc drawSprite*(renderWindow: RenderWindow, obj: Sprite, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawSprite".}
proc drawSprite*(renderWindow: RenderWindow, obj: Sprite, states: RenderStates) =
  ## Draw a drawable object to the render-target
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  render window object
  ## - ``object``:        Object to draw
  ## - ``states``:        Render states to use for drawing (NULL to use the default states)
  (var Cstates = states)
  drawSprite(renderWindow, obj, Cstates)

proc drawText*(renderWindow: RenderWindow, obj: Text, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawText".}
proc drawText*(renderWindow: RenderWindow, obj: Text, states: RenderStates) =
  (var Cstates = states)
  drawText(renderWindow, obj, Cstates)

proc drawShape*(renderWindow: RenderWindow, obj: Shape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawShape".}
proc drawShape*(renderWindow: RenderWindow, obj: Shape, states: RenderStates) =
  (var Cstates = states)
  drawShape(renderWindow, obj, Cstates)

proc drawCircleShape*(renderWindow: RenderWindow, obj: CircleShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawCircleShape".}
proc drawCircleShape*(renderWindow: RenderWindow, obj: CircleShape, states: RenderStates) =
  (var Cstates = states)
  drawCircleShape(renderWindow, obj, Cstates)

proc drawConvexShape*(renderWindow: RenderWindow, obj: ConvexShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawConvexShape".}
proc drawConvexShape*(renderWindow: RenderWindow, obj: ConvexShape, states: RenderStates) =
  (var Cstates = states)
  drawConvexShape(renderWindow, obj, Cstates)

proc drawRectangleShape*(renderWindow: RenderWindow, obj: RectangleShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawRectangleShape".}
proc drawRectangleShape*(renderWindow: RenderWindow, obj: RectangleShape, states: RenderStates) =
  (var Cstates = states)
  drawRectangleShape(renderWindow, obj, Cstates)

proc drawVertexArray*(renderWindow: RenderWindow, obj: VertexArray, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawVertexArray".}
proc drawVertexArray*(renderWindow: RenderWindow, obj: VertexArray, states: RenderStates) =
  (var Cstates = states)
  drawVertexArray(renderWindow, obj, Cstates)

proc drawPrimitives*(renderWindow: RenderWindow, vertices: ptr Vertex, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderWindow_drawPrimitives".}
proc drawPrimitives*(renderWindow: RenderWindow, vertices: ptr Vertex, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  ## Draw primitives defined by an array of vertices to a render window
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  render window object
  ## - ``vertices``:      Pointer to the vertices
  ## - ``vertexCount``:   Number of vertices in the array
  ## - ``type``:          Type of primitives to draw
  ## - ``states``:        Render states to use for drawing (NULL to use the default states)
  (var Cstates = states)
  drawPrimitives(renderWindow, vertices, vertexCount, kind, Cstates)

proc pushGLStates*(renderWindow: RenderWindow) {.
  cdecl, importc: "sfRenderWindow_pushGLStates".}
  ## Save the current OpenGL render states and matrices
  ## 
  ## This function can be used when you mix SFML drawing
  ## and direct OpenGL rendering. Combined with popGLStates,
  ## it ensures that:
  ## - SFML's internal states are not messed up by your OpenGL code
  ## - your OpenGL states are not modified by a call to a SFML function
  ## 
  ## Note that this function is quite expensive: it saves all the
  ## possible OpenGL states and matrices, even the ones you
  ## don't care about. Therefore it should be used wisely.
  ## It is provided for convenience, but the best results will
  ## be achieved if you handle OpenGL states yourself (because
  ## you know which states have really changed, and need to be
  ## saved and restored). Take a look at the resetGLStates
  ## function if you do so.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  render window object

proc popGLStates*(renderWindow: RenderWindow) {.
  cdecl, importc: "sfRenderWindow_popGLStates".}
  ## Restore the previously saved OpenGL render states and matrices
  ## 
  ## See the description of pushGLStates to get a detailed
  ## description of these functions.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  render window object

proc resetGLStates*(renderWindow: RenderWindow) {.
  cdecl, importc: "sfRenderWindow_resetGLStates".}
  ## Reset the internal OpenGL states so that the target is ready for drawing
  ## 
  ## This function can be used when you mix SFML drawing
  ## and direct OpenGL rendering, if you choose not to use
  ## pushGLStates/popGLStates. It makes sure that all OpenGL
  ## states needed by SFML are set, so that subsequent RenderWindow_draw*()
  ## calls will work as expected.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  render window object

proc capture*(renderWindow: RenderWindow): Image {.
  cdecl, importc: "sfRenderWindow_capture".}
  ## Copy the current contents of a render window to an image
  ## 
  ## This is a slow operation, whose main purpose is to make
  ## screenshots of the application. If you want to update an
  ## image with the contents of the window and then use it for
  ## drawing, you should rather use a Texture and its
  ## update(Window*) function.
  ## You can also draw things directly to a texture with the
  ## RenderWindow class.
  ## 
  ## *Arguments*:
  ## - ``renderWindow``:  Render window object
  ## 
  ## *Returns:* New image containing the captured contents

proc mouse_getPosition*(relativeTo: RenderWindow): Vector2i {.
  cdecl, importc: "sfMouse_getPositionRenderWindow".}
  ## Get the current position of the mouse relatively to a render-window
  ## 
  ## This function returns the current position of the mouse
  ## cursor relative to the given render-window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``relativeTo``:  Reference window
  ## 
  ## *Returns:* Position of the mouse cursor, relative to the given render-window

proc mouse_setPosition*(position: Vector2i, relativeTo: RenderWindow) {.
  cdecl, importc: "sfMouse_setPositionRenderWindow".}
  ## Set the current position of the mouse relatively to a render-window
  ## 
  ## This function sets the current position of the mouse
  ## cursor relative to the given render-window, or desktop if NULL is passed.
  ## 
  ## *Arguments*:
  ## - ``position``:    New position of the mouse
  ## - ``relativeTo``:  Reference window


#--- SFML/Graphics/RenderTexture ---#

proc newRenderTexture*(width: cint, height: cint, depthBuffer: BoolInt): RenderTexture {.
  cdecl, importc: "sfRenderTexture_create".}
  ## Construct a new render texture
  ## 
  ## *Arguments*:
  ## - ``width``:        Width of the render texture
  ## - ``height``:       Height of the render texture
  ## - ``depthBuffer``:  Do you want a depth-buffer attached? (useful only if you're doing 3D OpenGL on the rendertexture)
  ## 
  ## *Returns:* A new RenderTexture object, or NULL if it failed

proc destroy*(renderTexture: RenderTexture) {.
  destroy, cdecl, importc: "sfRenderTexture_destroy".}
  ## Destroy an existing render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture to destroy

proc size*(renderTexture: RenderTexture): Vector2i {.
  cdecl, importc: "sfRenderTexture_getSize".}
  ## Get the size of the rendering region of a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* Size in pixels

proc `active=`*(renderTexture: RenderTexture, active: BoolInt): BoolInt {.
  cdecl, importc: "sfRenderTexture_setActive".}
  ## Activate or deactivate a render texture as the current target for rendering
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``active``:         True to activate, False to deactivate
  ## 
  ## *Returns:* True if operation was successful, false otherwise

proc display*(renderTexture: RenderTexture) {.
  cdecl, importc: "sfRenderTexture_display".}
  ## Update the contents of the target texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object

proc clear*(renderTexture: RenderTexture, color: Color) {.
  cdecl, importc: "sfRenderTexture_clear".}
  ## Clear the rendertexture with the given color
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``color``:          Fill color

proc `view=`*(renderTexture: RenderTexture, view: View) {.
  cdecl, importc: "sfRenderTexture_setView".}
  ## Change the current active view of a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``view``:           Pointer to the new view

proc view*(renderTexture: RenderTexture): View {.
  cdecl, importc: "sfRenderTexture_getView".}
  ## Get the current active view of a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* Current active view

proc defaultView*(renderTexture: RenderTexture): View {.
  cdecl, importc: "sfRenderTexture_getDefaultView".}
  ## Get the default view of a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* Default view of the rendertexture

proc getViewport*(renderTexture: RenderTexture, view: View): IntRect {.
  cdecl, importc: "sfRenderTexture_getViewport".}
  ## Get the viewport of a view applied to this target
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``view``:           Target view
  ## 
  ## *Returns:* Viewport rectangle, expressed in pixels in the current target

proc mapPixelToCoords*(renderTexture: RenderTexture, point: Vector2i, view: View): Vector2f {.
  cdecl, importc: "sfRenderTexture_mapPixelToCoords".}
  ## Convert a point from texture coordinates to world coordinates
  ## 
  ## This function finds the 2D position that matches the
  ## given pixel of the render-texture. In other words, it does
  ## the inverse of what the graphics card does, to find the
  ## initial position of a rendered pixel.
  ## 
  ## Initially, both coordinate systems (world units and target pixels)
  ## match perfectly. But if you define a custom view or resize your
  ## render-texture, this assertion is not true anymore, ie. a point
  ## located at (10, 50) in your render-texture may map to the point
  ## (150, 75) in your 2D world -- if the view is translated by (140, 25).
  ## 
  ## This version uses a custom view for calculations, see the other
  ## overload of the function if you want to use the current view of the
  ## render-texture.
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``point``:  Pixel to convert
  ## - ``view``:  The view to use for converting the point
  ## 
  ## *Returns:* The converted point, in "world" units

proc mapCoordsToPixel*(renderTexture: RenderTexture, point: Vector2f, view: View): Vector2i {.
  cdecl, importc: "sfRenderTexture_mapCoordsToPixel".}
  ## Convert a point from world coordinates to texture coordinates
  ## 
  ## This function finds the pixel of the render-texture that matches
  ## the given 2D point. In other words, it goes through the same process
  ## as the graphics card, to compute the final position of a rendered point.
  ## 
  ## Initially, both coordinate systems (world units and target pixels)
  ## match perfectly. But if you define a custom view or resize your
  ## render-texture, this assertion is not true anymore, ie. a point
  ## located at (150, 75) in your 2D world may map to the pixel
  ## (10, 50) of your render-texture -- if the view is translated by (140, 25).
  ## 
  ## This version uses a custom view for calculations, see the other
  ## overload of the function if you want to use the current view of the
  ## render-texture.
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``point``:  Point to convert
  ## - ``view``:  The view to use for converting the point
  ## 
  ## *Returns:* The converted point, in target coordinates (pixels)

proc drawSprite*(renderTexture: RenderTexture, obj: Sprite, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawSprite".}
proc drawSprite*(renderTexture: RenderTexture, obj: Sprite, states: RenderStates) =
  ## Draw a drawable object to the render-target
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``object``:         Object to draw
  ## - ``states``:         Render states to use for drawing (NULL to use the default states)
  (var Cstates = states)
  drawSprite(renderTexture, obj, Cstates)

proc drawText*(renderTexture: RenderTexture, obj: Text, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawText".}
proc drawText*(renderTexture: RenderTexture, obj: Text, states: RenderStates) =
  (var Cstates = states)
  drawText(renderTexture, obj, Cstates)

proc drawShape*(renderTexture: RenderTexture, obj: Shape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawShape".}
proc drawShape*(renderTexture: RenderTexture, obj: Shape, states: RenderStates) =
  (var Cstates = states)
  drawShape(renderTexture, obj, Cstates)

proc drawCircleShape*(renderTexture: RenderTexture, obj: CircleShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawCircleShape".}
proc drawCircleShape*(renderTexture: RenderTexture, obj: CircleShape, states: RenderStates) =
  (var Cstates = states)
  drawCircleShape(renderTexture, obj, Cstates)

proc drawConvexShape*(renderTexture: RenderTexture, obj: ConvexShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawConvexShape".}
proc drawConvexShape*(renderTexture: RenderTexture, obj: ConvexShape, states: RenderStates) =
  (var Cstates = states)
  drawConvexShape(renderTexture, obj, Cstates)

proc drawRectangleShape*(renderTexture: RenderTexture, obj: RectangleShape, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawRectangleShape".}
proc drawRectangleShape*(renderTexture: RenderTexture, obj: RectangleShape, states: RenderStates) =
  (var Cstates = states)
  drawRectangleShape(renderTexture, obj, Cstates)

proc drawVertexArray*(renderTexture: RenderTexture, obj: VertexArray, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawVertexArray".}
proc drawVertexArray*(renderTexture: RenderTexture, obj: VertexArray, states: RenderStates) =
  (var Cstates = states)
  drawVertexArray(renderTexture, obj, Cstates)

proc drawPrimitives*(renderTexture: RenderTexture, vertices: ptr Vertex, vertexCount: cint, kind: PrimitiveType, states: (var RenderStates){lvalue}) {.
  cdecl, importc: "sfRenderTexture_drawPrimitives".}
proc drawPrimitives*(renderTexture: RenderTexture, vertices: ptr Vertex, vertexCount: cint, kind: PrimitiveType, states: RenderStates) =
  ## Draw primitives defined by an array of vertices to a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``vertices``:       Pointer to the vertices
  ## - ``vertexCount``:    Number of vertices in the array
  ## - ``type``:           Type of primitives to draw
  ## - ``states``:         Render states to use for drawing (NULL to use the default states)
  (var Cstates = states)
  drawPrimitives(renderTexture, vertices, vertexCount, kind, Cstates)

proc pushGLStates*(renderTexture: RenderTexture) {.
  cdecl, importc: "sfRenderTexture_pushGLStates".}
  ## Save the current OpenGL render states and matrices
  ## 
  ## This function can be used when you mix SFML drawing
  ## and direct OpenGL rendering. Combined with popGLStates,
  ## it ensures that:
  ## - SFML's internal states are not messed up by your OpenGL code
  ## - your OpenGL states are not modified by a call to a SFML function
  ## 
  ## Note that this function is quite expensive: it saves all the
  ## possible OpenGL states and matrices, even the ones you
  ## don't care about. Therefore it should be used wisely.
  ## It is provided for convenience, but the best results will
  ## be achieved if you handle OpenGL states yourself (because
  ## you know which states have really changed, and need to be
  ## saved and restored). Take a look at the resetGLStates
  ## function if you do so.
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object

proc popGLStates*(renderTexture: RenderTexture) {.
  cdecl, importc: "sfRenderTexture_popGLStates".}
  ## Restore the previously saved OpenGL render states and matrices
  ## 
  ## See the description of pushGLStates to get a detailed
  ## description of these functions.
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object

proc resetGLStates*(renderTexture: RenderTexture) {.
  cdecl, importc: "sfRenderTexture_resetGLStates".}
  ## Reset the internal OpenGL states so that the target is ready for drawing
  ## 
  ## This function can be used when you mix SFML drawing
  ## and direct OpenGL rendering, if you choose not to use
  ## pushGLStates/popGLStates. It makes sure that all OpenGL
  ## states needed by SFML are set, so that subsequent RenderTexture_draw*()
  ## calls will work as expected.
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object

proc texture*(renderTexture: RenderTexture): Texture {.
  cdecl, importc: "sfRenderTexture_getTexture".}
  ## Get the target texture of a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* Pointer to the target texture

proc `smooth=`*(renderTexture: RenderTexture, smooth: BoolInt) {.
  cdecl, importc: "sfRenderTexture_setSmooth".}
  ## Enable or disable the smooth filter on a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``smooth``:         True to enable smoothing, False to disable it

proc smooth*(renderTexture: RenderTexture): BoolInt {.
  cdecl, importc: "sfRenderTexture_isSmooth".}
  ## Tell whether the smooth filter is enabled or not for a render texture
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* True if smoothing is enabled, False if it is disabled

proc `repeated=`*(renderTexture: RenderTexture, repeated: BoolInt) {.
  cdecl, importc: "sfRenderTexture_setRepeated".}
  ## Enable or disable texture repeating
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## - ``repeated``:       True to enable repeating, False to disable it

proc repeated*(renderTexture: RenderTexture): BoolInt {.
  cdecl, importc: "sfRenderTexture_isRepeated".}
  ## Tell whether the texture is repeated or not
  ## 
  ## *Arguments*:
  ## - ``renderTexture``:  Render texture object
  ## 
  ## *Returns:* True if repeat mode is enabled, False if it is disabled


#--- SFML/Graphics/Shader ---#

proc newShader*(vertexShaderFilename: cstring, fragmentShaderFilename: cstring): Shader {.
  cdecl, importc: "sfShader_createFromFile".}
  ## Load both the vertex and fragment shaders from files
  ## 
  ## This function can load both the vertex and the fragment
  ## shaders, or only one of them: pass NULL if you don't want to load
  ## either the vertex shader or the fragment shader.
  ## The sources must be text files containing valid shaders
  ## in GLSL language. GLSL is a C-like language dedicated to
  ## OpenGL shaders; you'll probably need to read a good documentation
  ## for it before writing your own shaders.
  ## 
  ## *Arguments*:
  ## - ``vertexShaderFilename``:    Path of the vertex shader file to load, or NULL to skip this shader
  ## - ``fragmentShaderFilename``:  Path of the fragment shader file to load, or NULL to skip this shader
  ## 
  ## *Returns:* A new Shader object, or NULL if it failed

proc newShader*(vertexShader: cstring, fragmentShader: cstring): Shader {.
  cdecl, importc: "sfShader_createFromMemory".}
  ## Load both the vertex and fragment shaders from source codes in memory
  ## 
  ## This function can load both the vertex and the fragment
  ## shaders, or only one of them: pass NULL if you don't want to load
  ## either the vertex shader or the fragment shader.
  ## The sources must be valid shaders in GLSL language. GLSL is
  ## a C-like language dedicated to OpenGL shaders; you'll
  ## probably need to read a good documentation for it before
  ## writing your own shaders.
  ## 
  ## *Arguments*:
  ## - ``vertexShader``:    String containing the source code of the vertex shader, or NULL to skip this shader
  ## - ``fragmentShader``:  String containing the source code of the fragment shader, or NULL to skip this shader
  ## 
  ## *Returns:* A new Shader object, or NULL if it failed

proc newShader*(vertexShaderStream: var InputStream, fragmentShaderStream: var InputStream): Shader {.
  cdecl, importc: "sfShader_createFromStream".}
  ## Load both the vertex and fragment shaders from custom streams
  ## 
  ## This function can load both the vertex and the fragment
  ## shaders, or only one of them: pass NULL if you don't want to load
  ## either the vertex shader or the fragment shader.
  ## The source codes must be valid shaders in GLSL language.
  ## GLSL is a C-like language dedicated to OpenGL shaders;
  ## you'll probably need to read a good documentation for
  ## it before writing your own shaders.
  ## 
  ## *Arguments*:
  ## - ``vertexShaderStream``:    Source stream to read the vertex shader from, or NULL to skip this shader
  ## - ``fragmentShaderStream``:  Source stream to read the fragment shader from, or NULL to skip this shader
  ## 
  ## *Returns:* A new Shader object, or NULL if it failed

proc destroy*(shader: Shader) {.
  destroy, cdecl, importc: "sfShader_destroy".}
  ## Destroy an existing shader
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader to delete

proc setParameter*(shader: Shader, name: cstring, x: cfloat) {.
  cdecl, importc: "sfShader_setFloatParameter".}
  ## Change a float parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a float
  ## (float GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``x``:       Value to assign

proc setParameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat) {.
  cdecl, importc: "sfShader_setFloat2Parameter".}
  ## Change a 2-components vector parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 2x1 vector
  ## (vec2 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``x``:       First component of the value to assign
  ## - ``y``:       Second component of the value to assign

proc setParameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat, z: cfloat) {.
  cdecl, importc: "sfShader_setFloat3Parameter".}
  ## Change a 3-components vector parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 3x1 vector
  ## (vec3 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``x``:       First component of the value to assign
  ## - ``y``:       Second component of the value to assign
  ## - ``z``:       Third component of the value to assign

proc setParameter*(shader: Shader, name: cstring, x: cfloat, y: cfloat, z: cfloat, w: cfloat) {.
  cdecl, importc: "sfShader_setFloat4Parameter".}
  ## Change a 4-components vector parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 4x1 vector
  ## (vec4 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``x``:       First component of the value to assign
  ## - ``y``:       Second component of the value to assign
  ## - ``z``:       Third component of the value to assign
  ## - ``w``:       Fourth component of the value to assign

proc setParameter*(shader: Shader, name: cstring, vector: Vector2f) {.
  cdecl, importc: "sfShader_setVector2Parameter".}
  ## Change a 2-components vector parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 2x1 vector
  ## (vec2 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``vector``:  Vector to assign

proc setParameter*(shader: Shader, name: cstring, vector: Vector3f) {.
  cdecl, importc: "sfShader_setVector3Parameter".}
  ## Change a 3-components vector parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 3x1 vector
  ## (vec3 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``vector``:  Vector to assign

proc setParameter*(shader: Shader, name: cstring, color: Color) {.
  cdecl, importc: "sfShader_setColorParameter".}
  ## Change a color parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 4x1 vector
  ## (vec4 GLSL type).
  ## 
  ## It is important to note that the components of the color are
  ## normalized before being passed to the shader. Therefore,
  ## they are converted from range [0 .. 255] to range [0 .. 1].
  ## For example, a sf::Color(255, 125, 0, 255) will be transformed
  ## to a vec4(1.0, 0.5, 0.0, 1.0) in the shader.
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the parameter in the shader
  ## - ``color``:   Color to assign

proc setParameter*(shader: Shader, name: cstring, transform: Transform) {.
  cdecl, importc: "sfShader_setTransformParameter".}
  ## Change a matrix parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 4x4 matrix
  ## (mat4 GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:     Shader object
  ## - ``name``:       Name of the parameter in the shader
  ## - ``transform``:  Transform to assign

proc setParameter*(shader: Shader, name: cstring, texture: Texture) {.
  cdecl, importc: "sfShader_setTextureParameter".}
  ## Change a texture parameter of a shader
  ## 
  ## ``name`` is the name of the variable to change in the shader.
  ## The corresponding parameter in the shader must be a 2D texture
  ## (sampler2D GLSL type).
  ## 
  ## It is important to note that ``texture`` must remain alive as long
  ## as the shader uses it, no copy is made internally.
  ## 
  ## To use the texture of the object being draw, which cannot be
  ## known in advance, you can use the special function
  ## Shader_setCurrentTextureParameter:
  ## 
  ## *Arguments*:
  ## - ``shader``:   Shader object
  ## - ``name``:     Name of the texture in the shader
  ## - ``texture``:  Texture to assign

proc `currentTextureParameter=`*(shader: Shader, name: cstring) {.
  cdecl, importc: "sfShader_setCurrentTextureParameter".}
  ## Change a texture parameter of a shader
  ## 
  ## This function maps a shader texture variable to the
  ## texture of the object being drawn, which cannot be
  ## known in advance.
  ## The corresponding parameter in the shader must be a 2D texture
  ## (sampler2D GLSL type).
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader object
  ## - ``name``:    Name of the texture in the shader

proc bindGL*(shader: Shader) {.
  cdecl, importc: "sfShader_bind".}
  ## Bind a shader for rendering (activate it)
  ## 
  ## This function is not part of the graphics API, it mustn't be
  ## used when drawing SFML entities. It must be used only if you
  ## mix Shader with OpenGL code.
  ## 
  ## 
  ## *Arguments*:
  ## - ``shader``:  Shader to bind, can be null to use no shader

proc shader_isAvailable*(): BoolInt {.
  cdecl, importc: "sfShader_isAvailable".}
  ## Tell whether or not the system supports shaders
  ## 
  ## This function should always be called before using
  ## the shader features. If it returns false, then
  ## any attempt to use Shader will fail.
  ## 
  ## *Returns:* True if the system can use shaders, False otherwise


#--- SFML/Graphics/Shape ---#

type ShapeGetPointCountCallback* = proc(p1: pointer): cint {.cdecl.}

type ShapeGetPointCallback* = proc(p1: cint; p2: pointer): Vector2f {.cdecl.}

proc newShape*(getPointCount: ShapeGetPointCountCallback, getPoint: ShapeGetPointCallback, userData: pointer): Shape {.
  cdecl, importc: "sfShape_create".}
  ## Create a new shape
  ## 
  ## *Arguments*:
  ## - ``getPointCount``:  Callback that provides the point count of the shape
  ## - ``getPoint``:       Callback that provides the points of the shape
  ## - ``userData``:       Data to pass to the callback functions
  ## 
  ## *Returns:* A new Shape object

proc destroy*(shape: Shape) {.
  destroy, cdecl, importc: "sfShape_destroy".}
  ## Destroy an existing shape
  ## 
  ## *Arguments*:
  ## - ``Shape``:  Shape to delete

proc `position=`*(shape: Shape, position: Vector2f) {.
  cdecl, importc: "sfShape_setPosition".}
  ## Set the position of a shape
  ## 
  ## This function completely overwrites the previous position.
  ## See Shape_move to apply an offset based on the previous position instead.
  ## The default position of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:     Shape object
  ## - ``position``:  New position

proc `rotation=`*(shape: Shape, angle: cfloat) {.
  cdecl, importc: "sfShape_setRotation".}
  ## Set the orientation of a shape
  ## 
  ## This function completely overwrites the previous rotation.
  ## See Shape_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a circle Shape object is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  New rotation, in degrees

proc `scale=`*(shape: Shape, scale: Vector2f) {.
  cdecl, importc: "sfShape_setScale".}
  ## Set the scale factors of a shape
  ## 
  ## This function completely overwrites the previous scale.
  ## See Shape_scale to add a factor based on the previous scale instead.
  ## The default scale of a circle Shape object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``scale``:  New scale factors

proc `origin=`*(shape: Shape, origin: Vector2f) {.
  cdecl, importc: "sfShape_setOrigin".}
  ## Set the local origin of a shape
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a circle Shape object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``origin``:  New origin

proc position*(shape: Shape): Vector2f {.
  cdecl, importc: "sfShape_getPosition".}
  ## Get the position of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current position

proc rotation*(shape: Shape): cfloat {.
  cdecl, importc: "sfShape_getRotation".}
  ## Get the orientation of a shape
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(shape: Shape): Vector2f {.
  cdecl, importc: "sfShape_getScale".}
  ## Get the current scale of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current scale factors

proc origin*(shape: Shape): Vector2f {.
  cdecl, importc: "sfShape_getOrigin".}
  ## Get the local origin of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Current origin

proc move*(shape: Shape, offset: Vector2f) {.
  cdecl, importc: "sfShape_move".}
  ## Move a shape by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike Shape_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:   Shape object
  ## - ``offset``:  Offset

proc rotate*(shape: Shape, angle: cfloat) {.
  cdecl, importc: "sfShape_rotate".}
  ## Rotate a shape
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike Shape_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``angle``:  Angle of rotation, in degrees

proc scale*(shape: Shape, factors: Vector2f) {.
  cdecl, importc: "sfShape_scale".}
  ## Scale a shape
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike Shape_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``shape``:    Shape object
  ## - ``factors``:  Scale factors

proc transform*(shape: Shape): Transform {.
  cdecl, importc: "sfShape_getTransform".}
  ## Get the combined transform of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(shape: Shape): Transform {.
  cdecl, importc: "sfShape_getInverseTransform".}
  ## Get the inverse of the combined transform of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  shape object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc setTexture*(shape: Shape, texture: Texture, resetRect: BoolInt) {.
  cdecl, importc: "sfShape_setTexture".}
  ## Change the source texture of a shape
  ## 
  ## The ``texture`` argument refers to a texture that must
  ## exist as long as the shape uses it. Indeed, the shape
  ## doesn't store its own copy of the texture, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the source texture is destroyed and the shape tries to
  ## use it, the behaviour is undefined.
  ## ``texture`` can be NULL to disable texturing.
  ## If ``resetRect`` is true, the TextureRect property of
  ## the shape is automatically adjusted to the size of the new
  ## texture. If it is false, the texture rect is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``texture``:    New texture
  ## - ``resetRect``:  Should the texture rect be reset to the size of the new texture?

proc `textureRect=`*(shape: Shape, rect: IntRect) {.
  cdecl, importc: "sfShape_setTextureRect".}
  ## Set the sub-rectangle of the texture that a shape will display
  ## 
  ## The texture rect is useful when you don't want to display
  ## the whole texture, but rather a part of it.
  ## By default, the texture rect covers the entire texture.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``rect``:   Rectangle defining the region of the texture to display

proc `fillColor=`*(shape: Shape, color: Color) {.
  cdecl, importc: "sfShape_setFillColor".}
  ## Set the fill color of a shape
  ## 
  ## This color is modulated (multiplied) with the shape's
  ## texture if any. It can be used to colorize the shape,
  ## or change its global opacity.
  ## You can use Transparent to make the inside of
  ## the shape transparent, and have the outline alone.
  ## By default, the shape's fill color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New color of the shape

proc `outlineColor=`*(shape: Shape, color: Color) {.
  cdecl, importc: "sfShape_setOutlineColor".}
  ## Set the outline color of a shape
  ## 
  ## You can use Transparent to disable the outline.
  ## By default, the shape's outline color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``color``:  New outline color of the shape

proc `outlineThickness=`*(shape: Shape, thickness: cfloat) {.
  cdecl, importc: "sfShape_setOutlineThickness".}
  ## Set the thickness of a shape's outline
  ## 
  ## This number cannot be negative. Using zero disables
  ## the outline.
  ## By default, the outline thickness is 0.
  ## 
  ## *Arguments*:
  ## - ``shape``:      Shape object
  ## - ``thickness``:  New outline thickness

proc texture*(shape: Shape): Texture {.
  cdecl, importc: "sfShape_getTexture".}
  ## Get the source texture of a shape
  ## 
  ## If the shape has no source texture, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the texture when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Pointer to the shape's texture

proc textureRect*(shape: Shape): IntRect {.
  cdecl, importc: "sfShape_getTextureRect".}
  ## Get the sub-rectangle of the texture displayed by a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Texture rectangle of the shape

proc fillColor*(shape: Shape): Color {.
  cdecl, importc: "sfShape_getFillColor".}
  ## Get the fill color of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Fill color of the shape

proc outlineColor*(shape: Shape): Color {.
  cdecl, importc: "sfShape_getOutlineColor".}
  ## Get the outline color of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline color of the shape

proc outlineThickness*(shape: Shape): cfloat {.
  cdecl, importc: "sfShape_getOutlineThickness".}
  ## Get the outline thickness of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Outline thickness of the shape

proc pointCount*(shape: Shape): cint {.
  cdecl, importc: "sfShape_getPointCount".}
  ## Get the total number of points of a shape
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Number of points of the shape

proc getPoint*(shape: Shape, index: cint): Vector2f {.
  cdecl, importc: "sfShape_getPoint".}
  ## Get a point of a shape
  ## 
  ## The result is undefined if ``index`` is out of the valid range.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## - ``index``:  Index of the point to get, in range [0 .. getPointCount() - 1]
  ## 
  ## *Returns:* Index-th point of the shape

proc localBounds*(shape: Shape): FloatRect {.
  cdecl, importc: "sfShape_getLocalBounds".}
  ## Get the local bounding rectangle of a shape
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(shape: Shape): FloatRect {.
  cdecl, importc: "sfShape_getGlobalBounds".}
  ## Get the global bounding rectangle of a shape
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## sprite in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``shape``:  Shape object
  ## 
  ## *Returns:* Global bounding rectangle of the entity

proc update*(shape: Shape) {.
  cdecl, importc: "sfShape_update".}
  ## Recompute the internal geometry of a shape
  ## 
  ## This function must be called by specialized shape objects
  ## everytime their points change (ie. the result of either
  ## the getPointCount or getPoint callbacks is different).


#--- SFML/Graphics/Sprite ---#

proc newSprite*(): Sprite {.
  cdecl, importc: "sfSprite_create".}
  ## Create a new sprite
  ## 
  ## *Returns:* A new Sprite object, or NULL if it failed

proc copy*(sprite: Sprite): Sprite {.
  cdecl, importc: "sfSprite_copy".}
  ## Copy an existing sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(sprite: Sprite) {.
  destroy, cdecl, importc: "sfSprite_destroy".}
  ## Destroy an existing sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite to delete

proc `position=`*(sprite: Sprite, position: Vector2f) {.
  cdecl, importc: "sfSprite_setPosition".}
  ## Set the position of a sprite
  ## 
  ## This function completely overwrites the previous position.
  ## See Sprite_move to apply an offset based on the previous position instead.
  ## The default position of a sprite Sprite object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``sprite``:    Sprite object
  ## - ``position``:  New position

proc `rotation=`*(sprite: Sprite, angle: cfloat) {.
  cdecl, importc: "sfSprite_setRotation".}
  ## Set the orientation of a sprite
  ## 
  ## This function completely overwrites the previous rotation.
  ## See Sprite_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a sprite Sprite object is 0.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``angle``:   New rotation, in degrees

proc `scale=`*(sprite: Sprite, scale: Vector2f) {.
  cdecl, importc: "sfSprite_setScale".}
  ## Set the scale factors of a sprite
  ## 
  ## This function completely overwrites the previous scale.
  ## See Sprite_scale to add a factor based on the previous scale instead.
  ## The default scale of a sprite Sprite object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``scale``:   New scale factors

proc `origin=`*(sprite: Sprite, origin: Vector2f) {.
  cdecl, importc: "sfSprite_setOrigin".}
  ## Set the local origin of a sprite
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a sprite Sprite object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``origin``:  New origin

proc position*(sprite: Sprite): Vector2f {.
  cdecl, importc: "sfSprite_getPosition".}
  ## Get the position of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Current position

proc rotation*(sprite: Sprite): cfloat {.
  cdecl, importc: "sfSprite_getRotation".}
  ## Get the orientation of a sprite
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(sprite: Sprite): Vector2f {.
  cdecl, importc: "sfSprite_getScale".}
  ## Get the current scale of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Current scale factors

proc origin*(sprite: Sprite): Vector2f {.
  cdecl, importc: "sfSprite_getOrigin".}
  ## Get the local origin of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Current origin

proc move*(sprite: Sprite, offset: Vector2f) {.
  cdecl, importc: "sfSprite_move".}
  ## Move a sprite by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike Sprite_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``offset``:  Offset

proc rotate*(sprite: Sprite, angle: cfloat) {.
  cdecl, importc: "sfSprite_rotate".}
  ## Rotate a sprite
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike Sprite_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``angle``:   Angle of rotation, in degrees

proc scale*(sprite: Sprite, factors: Vector2f) {.
  cdecl, importc: "sfSprite_scale".}
  ## Scale a sprite
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike Sprite_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``sprite``:   Sprite object
  ## - ``factors``:  Scale factors

proc transform*(sprite: Sprite): Transform {.
  cdecl, importc: "sfSprite_getTransform".}
  ## Get the combined transform of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(sprite: Sprite): Transform {.
  cdecl, importc: "sfSprite_getInverseTransform".}
  ## Get the inverse of the combined transform of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc setTexture*(sprite: Sprite, texture: Texture, resetRect: BoolInt) {.
  cdecl, importc: "sfSprite_setTexture".}
  ## Change the source texture of a sprite
  ## 
  ## The ``texture`` argument refers to a texture that must
  ## exist as long as the sprite uses it. Indeed, the sprite
  ## doesn't store its own copy of the texture, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the source texture is destroyed and the sprite tries to
  ## use it, the behaviour is undefined.
  ## If ``resetRect`` is true, the TextureRect property of
  ## the sprite is automatically adjusted to the size of the new
  ## texture. If it is false, the texture rect is left unchanged.
  ## 
  ## *Arguments*:
  ## - ``sprite``:     Sprite object
  ## - ``texture``:    New texture
  ## - ``resetRect``:  Should the texture rect be reset to the size of the new texture?

proc `textureRect=`*(sprite: Sprite, rectangle: IntRect) {.
  cdecl, importc: "sfSprite_setTextureRect".}
  ## Set the sub-rectangle of the texture that a sprite will display
  ## 
  ## The texture rect is useful when you don't want to display
  ## the whole texture, but rather a part of it.
  ## By default, the texture rect covers the entire texture.
  ## 
  ## *Arguments*:
  ## - ``sprite``:     Sprite object
  ## - ``rectangle``:  Rectangle defining the region of the texture to display

proc `color=`*(sprite: Sprite, color: Color) {.
  cdecl, importc: "sfSprite_setColor".}
  ## Set the global color of a sprite
  ## 
  ## This color is modulated (multiplied) with the sprite's
  ## texture. It can be used to colorize the sprite, or change
  ## its global opacity.
  ## By default, the sprite's color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## - ``color``:   New color of the sprite

proc texture*(sprite: Sprite): Texture {.
  cdecl, importc: "sfSprite_getTexture".}
  ## Get the source texture of a sprite
  ## 
  ## If the sprite has no source texture, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the texture when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Pointer to the sprite's texture

proc textureRect*(sprite: Sprite): IntRect {.
  cdecl, importc: "sfSprite_getTextureRect".}
  ## Get the sub-rectangle of the texture displayed by a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Texture rectangle of the sprite

proc color*(sprite: Sprite): Color {.
  cdecl, importc: "sfSprite_getColor".}
  ## Get the global color of a sprite
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Global color of the sprite

proc localBounds*(sprite: Sprite): FloatRect {.
  cdecl, importc: "sfSprite_getLocalBounds".}
  ## Get the local bounding rectangle of a sprite
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(sprite: Sprite): FloatRect {.
  cdecl, importc: "sfSprite_getGlobalBounds".}
  ## Get the global bounding rectangle of a sprite
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## sprite in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``sprite``:  Sprite object
  ## 
  ## *Returns:* Global bounding rectangle of the entity


#--- SFML/Graphics/Text ---#

type TextStyle* {.pure, size: sizeof(cint).} = enum
  Regular = 0, Bold = 1, Italic = 2, Underlined = 4

proc newText*(): Text {.
  cdecl, importc: "sfText_create".}
  ## Create a new text
  ## 
  ## *Returns:* A new Text object, or NULL if it failed

proc copy*(text: Text): Text {.
  cdecl, importc: "sfText_copy".}
  ## Copy an existing text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(text: Text) {.
  destroy, cdecl, importc: "sfText_destroy".}
  ## Destroy an existing text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text to delete

proc `position=`*(text: Text, position: Vector2f) {.
  cdecl, importc: "sfText_setPosition".}
  ## Set the position of a text
  ## 
  ## This function completely overwrites the previous position.
  ## See Text_move to apply an offset based on the previous position instead.
  ## The default position of a text Text object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``text``:      Text object
  ## - ``position``:  New position

proc `rotation=`*(text: Text, angle: cfloat) {.
  cdecl, importc: "sfText_setRotation".}
  ## Set the orientation of a text
  ## 
  ## This function completely overwrites the previous rotation.
  ## See Text_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a text Text object is 0.
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``angle``:  New rotation, in degrees

proc `scale=`*(text: Text, scale: Vector2f) {.
  cdecl, importc: "sfText_setScale".}
  ## Set the scale factors of a text
  ## 
  ## This function completely overwrites the previous scale.
  ## See Text_scale to add a factor based on the previous scale instead.
  ## The default scale of a text Text object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``scale``:  New scale factors

proc `origin=`*(text: Text, origin: Vector2f) {.
  cdecl, importc: "sfText_setOrigin".}
  ## Set the local origin of a text
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a text object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``text``:    Text object
  ## - ``origin``:  New origin

proc position*(text: Text): Vector2f {.
  cdecl, importc: "sfText_getPosition".}
  ## Get the position of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Current position

proc rotation*(text: Text): cfloat {.
  cdecl, importc: "sfText_getRotation".}
  ## Get the orientation of a text
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(text: Text): Vector2f {.
  cdecl, importc: "sfText_getScale".}
  ## Get the current scale of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Current scale factors

proc origin*(text: Text): Vector2f {.
  cdecl, importc: "sfText_getOrigin".}
  ## Get the local origin of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Current origin

proc move*(text: Text, offset: Vector2f) {.
  cdecl, importc: "sfText_move".}
  ## Move a text by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike Text_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``text``:    Text object
  ## - ``offset``:  Offset

proc rotate*(text: Text, angle: cfloat) {.
  cdecl, importc: "sfText_rotate".}
  ## Rotate a text
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike Text_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``angle``:  Angle of rotation, in degrees

proc scale*(text: Text, factors: Vector2f) {.
  cdecl, importc: "sfText_scale".}
  ## Scale a text
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike Text_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``text``:     Text object
  ## - ``factors``:  Scale factors

proc transform*(text: Text): Transform {.
  cdecl, importc: "sfText_getTransform".}
  ## Get the combined transform of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(text: Text): Transform {.
  cdecl, importc: "sfText_getInverseTransform".}
  ## Get the inverse of the combined transform of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object

proc `strC=`*(text: Text, str: cstring) {.
  cdecl, importc: "sfText_setString".}
  ## Set the string of a text (from an ANSI string)
  ## 
  ## A text's string is empty by default.
  ## 
  ## *Arguments*:
  ## - ``text``:    Text object
  ## - ``string``:  New string

proc `str_U32=`(text: Text, str: StringU32) {.
  cdecl, importc: "sfText_setUnicodeString".}
  ## Set the string of a text (from a unicode string)
  ## 
  ## *Arguments*:
  ## - ``text``:    Text object
  ## - ``string``:  New string

proc `font=`*(text: Text, font: Font) {.
  cdecl, importc: "sfText_setFont".}
  ## Set the font of a text
  ## 
  ## The ``font`` argument refers to a texture that must
  ## exist as long as the text uses it. Indeed, the text
  ## doesn't store its own copy of the font, but rather keeps
  ## a pointer to the one that you passed to this function.
  ## If the font is destroyed and the text tries to
  ## use it, the behaviour is undefined.
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## - ``font``:  New font

proc `characterSize=`*(text: Text, size: cint) {.
  cdecl, importc: "sfText_setCharacterSize".}
  ## Set the character size of a text
  ## 
  ## The default size is 30.
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## - ``size``:  New character size, in pixels

proc `style=`*(text: Text, style: BitMaskU32) {.
  cdecl, importc: "sfText_setStyle".}
  ## Set the style of a text
  ## 
  ## You can pass a combination of one or more styles, for
  ## example TextBold | TextItalic.
  ## The default style is TextRegular.
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``style``:  New style

proc `color=`*(text: Text, color: Color) {.
  cdecl, importc: "sfText_setColor".}
  ## Set the global color of a text
  ## 
  ## By default, the text's color is opaque white.
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``color``:  New color of the text

proc strC*(text: Text): cstring {.
  cdecl, importc: "sfText_getString".}
  ## Get the string of a text (returns an ANSI string)
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* String as a locale-dependant ANSI string

proc str_U32(text: Text): StringU32 {.
  cdecl, importc: "sfText_getUnicodeString".}
  ## Get the string of a text (returns a unicode string)
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* String as UTF-32

proc font*(text: Text): Font {.
  cdecl, importc: "sfText_getFont".}
  ## Get the font used by a text
  ## 
  ## If the text has no font attached, a NULL pointer is returned.
  ## The returned pointer is const, which means that you can't
  ## modify the font when you retrieve it with this function.
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Pointer to the font

proc characterSize*(text: Text): cint {.
  cdecl, importc: "sfText_getCharacterSize".}
  ## Get the size of the characters of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Size of the characters

proc style*(text: Text): BitMaskU32 {.
  cdecl, importc: "sfText_getStyle".}
  ## Get the style of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Current string style (see TextStyle enum)

proc color*(text: Text): Color {.
  cdecl, importc: "sfText_getColor".}
  ## Get the global color of a text
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Global color of the text

proc findCharacterPos*(text: Text, index: int): Vector2f {.
  cdecl, importc: "sfText_findCharacterPos".}
  ## Return the position of the ``index``-th character in a text
  ## 
  ## This function computes the visual position of a character
  ## from its index in the string. The returned position is
  ## in global coordinates (translation, rotation, scale and
  ## origin are applied).
  ## If ``index`` is out of range, the position of the end of
  ## the string is returned.
  ## 
  ## *Arguments*:
  ## - ``text``:   Text object
  ## - ``index``:  Index of the character
  ## 
  ## *Returns:* Position of the character

proc localBounds*(text: Text): FloatRect {.
  cdecl, importc: "sfText_getLocalBounds".}
  ## Get the local bounding rectangle of a text
  ## 
  ## The returned rectangle is in local coordinates, which means
  ## that it ignores the transformations (translation, rotation,
  ## scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## entity in the entity's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Local bounding rectangle of the entity

proc globalBounds*(text: Text): FloatRect {.
  cdecl, importc: "sfText_getGlobalBounds".}
  ## Get the global bounding rectangle of a text
  ## 
  ## The returned rectangle is in global coordinates, which means
  ## that it takes in account the transformations (translation,
  ## rotation, scale, ...) that are applied to the entity.
  ## In other words, this function returns the bounds of the
  ## text in the global 2D world's coordinate system.
  ## 
  ## *Arguments*:
  ## - ``text``:  Text object
  ## 
  ## *Returns:* Global bounding rectangle of the entity


#--- SFML/Graphics/Texture ---#

proc newTexture*(width: cint, height: cint): Texture {.
  cdecl, importc: "sfTexture_create".}
  ## Create a new texture
  ## 
  ## *Arguments*:
  ## - ``width``:   Texture width
  ## - ``height``:  Texture height
  ## 
  ## *Returns:* A new Texture object, or NULL if it failed

proc newTexture*(filename: cstring, area: (var IntRect){lvalue}): Texture {.
  cdecl, importc: "sfTexture_createFromFile".}
proc newTexture*(filename: cstring, area: IntRect): Texture =
  ## Create a new texture from a file
  ## 
  ## *Arguments*:
  ## - ``filename``:  Path of the image file to load
  ## - ``area``:      Area of the source image to load (NULL to load the entire image)
  ## 
  ## *Returns:* A new Texture object, or NULL if it failed
  (var Carea = area)
  newTexture(filename, Carea)

proc newTexture*(data: pointer, sizeInBytes: int, area: (var IntRect){lvalue}): Texture {.
  cdecl, importc: "sfTexture_createFromMemory".}
proc newTexture*(data: pointer, sizeInBytes: int, area: IntRect): Texture =
  ## Create a new texture from a file in memory
  ## 
  ## *Arguments*:
  ## - ``data``:         Pointer to the file data in memory
  ## - ``sizeInBytes``:  Size of the data to load, in bytes
  ## - ``area``:         Area of the source image to load (NULL to load the entire image)
  ## 
  ## *Returns:* A new Texture object, or NULL if it failed
  (var Carea = area)
  newTexture(data, sizeInBytes, Carea)

proc newTexture*(stream: var InputStream, area: (var IntRect){lvalue}): Texture {.
  cdecl, importc: "sfTexture_createFromStream".}
proc newTexture*(stream: var InputStream, area: IntRect): Texture =
  ## Create a new texture from a custom stream
  ## 
  ## *Arguments*:
  ## - ``stream``:  Source stream to read from
  ## - ``area``:    Area of the source image to load (NULL to load the entire image)
  ## 
  ## *Returns:* A new Texture object, or NULL if it failed
  (var Carea = area)
  newTexture(stream, Carea)

proc newTexture*(image: Image, area: (var IntRect){lvalue}): Texture {.
  cdecl, importc: "sfTexture_createFromImage".}
proc newTexture*(image: Image, area: IntRect): Texture =
  ## Create a new texture from an image
  ## 
  ## *Arguments*:
  ## - ``image``:  Image to upload to the texture
  ## - ``area``:   Area of the source image to load (NULL to load the entire image)
  ## 
  ## *Returns:* A new Texture object, or NULL if it failed
  (var Carea = area)
  newTexture(image, Carea)

proc copy*(texture: Texture): Texture {.
  cdecl, importc: "sfTexture_copy".}
  ## Copy an existing texture
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(texture: Texture) {.
  destroy, cdecl, importc: "sfTexture_destroy".}
  ## Destroy an existing texture
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to delete

proc size*(texture: Texture): Vector2i {.
  cdecl, importc: "sfTexture_getSize".}
  ## Return the size of the texture
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to read
  ## 
  ## *Returns:* Size in pixels

proc copyToImage*(texture: Texture): Image {.
  cdecl, importc: "sfTexture_copyToImage".}
  ## Copy a texture's pixels to an image
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to copy
  ## 
  ## *Returns:* Image containing the texture's pixels

proc updateFromPixels*(texture: Texture, pixels: ptr uint8, width: cint, height: cint, x: cint, y: cint) {.
  cdecl, importc: "sfTexture_updateFromPixels".}
  ## Update a texture from an array of pixels
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to update
  ## - ``pixels``:   Array of pixels to copy to the texture
  ## - ``width``:    Width of the pixel region contained in ``pixels``
  ## - ``height``:   Height of the pixel region contained in ``pixels``
  ## - ``x``:        X offset in the texture where to copy the source pixels
  ## - ``y``:        Y offset in the texture where to copy the source pixels

proc updateFromImage*(texture: Texture, image: Image, x: cint, y: cint) {.
  cdecl, importc: "sfTexture_updateFromImage".}
  ## Update a texture from an image
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to update
  ## - ``image``:    Image to copy to the texture
  ## - ``x``:        X offset in the texture where to copy the source pixels
  ## - ``y``:        Y offset in the texture where to copy the source pixels

proc updateFromWindow*(texture: Texture, window: Window, x: cint, y: cint) {.
  cdecl, importc: "sfTexture_updateFromWindow".}
  ## Update a texture from the contents of a window
  ## 
  ## *Arguments*:
  ## - ``texture``:  Texture to update
  ## - ``window``:   Window to copy to the texture
  ## - ``x``:        X offset in the texture where to copy the source pixels
  ## - ``y``:        Y offset in the texture where to copy the source pixels

proc updateFromRenderWindow*(texture: Texture, renderWindow: RenderWindow, x: cint, y: cint) {.
  cdecl, importc: "sfTexture_updateFromRenderWindow".}
  ## Update a texture from the contents of a render-window
  ## 
  ## *Arguments*:
  ## - ``texture``:       Texture to update
  ## - ``renderWindow``:  Render-window to copy to the texture
  ## - ``x``:             X offset in the texture where to copy the source pixels
  ## - ``y``:             Y offset in the texture where to copy the source pixels

proc `smooth=`*(texture: Texture, smooth: BoolInt) {.
  cdecl, importc: "sfTexture_setSmooth".}
  ## Enable or disable the smooth filter on a texture
  ## 
  ## *Arguments*:
  ## - ``texture``:  The texture object
  ## - ``smooth``:   True to enable smoothing, False to disable it

proc smooth*(texture: Texture): BoolInt {.
  cdecl, importc: "sfTexture_isSmooth".}
  ## Tell whether the smooth filter is enabled or not for a texture
  ## 
  ## *Arguments*:
  ## - ``texture``:  The texture object
  ## 
  ## *Returns:* True if smoothing is enabled, False if it is disabled

proc `repeated=`*(texture: Texture, repeated: BoolInt) {.
  cdecl, importc: "sfTexture_setRepeated".}
  ## Enable or disable repeating for a texture
  ## 
  ## Repeating is involved when using texture coordinates
  ## outside the texture rectangle [0, 0, width, height].
  ## In this case, if repeat mode is enabled, the whole texture
  ## will be repeated as many times as needed to reach the
  ## coordinate (for example, if the X texture coordinate is
  ## 3 * width, the texture will be repeated 3 times).
  ## If repeat mode is disabled, the "extra space" will instead
  ## be filled with border pixels.
  ## Warning: on very old graphics cards, white pixels may appear
  ## when the texture is repeated. With such cards, repeat mode
  ## can be used reliably only if the texture has power-of-two
  ## dimensions (such as 256x128).
  ## Repeating is disabled by default.
  ## 
  ## *Arguments*:
  ## - ``texture``:   The texture object
  ## - ``repeated``:  True to repeat the texture, false to disable repeating

proc repeated*(texture: Texture): BoolInt {.
  cdecl, importc: "sfTexture_isRepeated".}
  ## Tell whether a texture is repeated or not
  ## 
  ## *Arguments*:
  ## - ``texture``:  The texture object
  ## 
  ## *Returns:* True if repeat mode is enabled, False if it is disabled

proc bindGL*(texture: Texture) {.
  cdecl, importc: "sfTexture_bind".}
  ## Bind a texture for rendering
  ## 
  ## This function is not part of the graphics API, it mustn't be
  ## used when drawing SFML entities. It must be used only if you
  ## mix Texture with OpenGL code.
  ## 
  ## 
  ## *Arguments*:
  ## - ``texture``:  Pointer to the texture to bind, can be null to use no texture

proc texture_getMaximumSize*(): cint {.
  cdecl, importc: "sfTexture_getMaximumSize".}
  ## Get the maximum texture size allowed
  ## 
  ## *Returns:* Maximum size allowed for textures, in pixels


#--- SFML/Graphics/Transformable ---#

proc newTransformable*(): Transformable {.
  cdecl, importc: "sfTransformable_create".}
  ## Create a new transformable
  ## 
  ## *Returns:* A new Transformable object

proc copy*(transformable: Transformable): Transformable {.
  cdecl, importc: "sfTransformable_copy".}
  ## Copy an existing transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(transformable: Transformable) {.
  destroy, cdecl, importc: "sfTransformable_destroy".}
  ## Destroy an existing transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable to delete

proc `position=`*(transformable: Transformable, position: Vector2f) {.
  cdecl, importc: "sfTransformable_setPosition".}
  ## Set the position of a transformable
  ## 
  ## This function completely overwrites the previous position.
  ## See Transformable_move to apply an offset based on the previous position instead.
  ## The default position of a transformable Transformable object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``position``:       New position

proc `rotation=`*(transformable: Transformable, angle: cfloat) {.
  cdecl, importc: "sfTransformable_setRotation".}
  ## Set the orientation of a transformable
  ## 
  ## This function completely overwrites the previous rotation.
  ## See Transformable_rotate to add an angle based on the previous rotation instead.
  ## The default rotation of a transformable Transformable object is 0.
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``angle``:          New rotation, in degrees

proc `scale=`*(transformable: Transformable, scale: Vector2f) {.
  cdecl, importc: "sfTransformable_setScale".}
  ## Set the scale factors of a transformable
  ## 
  ## This function completely overwrites the previous scale.
  ## See Transformable_scale to add a factor based on the previous scale instead.
  ## The default scale of a transformable Transformable object is (1, 1).
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``scale``:          New scale factors

proc `origin=`*(transformable: Transformable, origin: Vector2f) {.
  cdecl, importc: "sfTransformable_setOrigin".}
  ## Set the local origin of a transformable
  ## 
  ## The origin of an object defines the center point for
  ## all transformations (position, scale, rotation).
  ## The coordinates of this point must be relative to the
  ## top-left corner of the object, and ignore all
  ## transformations (position, scale, rotation).
  ## The default origin of a transformable Transformable object is (0, 0).
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``origin``:         New origin

proc position*(transformable: Transformable): Vector2f {.
  cdecl, importc: "sfTransformable_getPosition".}
  ## Get the position of a transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Current position

proc rotation*(transformable: Transformable): cfloat {.
  cdecl, importc: "sfTransformable_getRotation".}
  ## Get the orientation of a transformable
  ## 
  ## The rotation is always in the range [0, 360].
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Current rotation, in degrees

proc scale*(transformable: Transformable): Vector2f {.
  cdecl, importc: "sfTransformable_getScale".}
  ## Get the current scale of a transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Current scale factors

proc origin*(transformable: Transformable): Vector2f {.
  cdecl, importc: "sfTransformable_getOrigin".}
  ## Get the local origin of a transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Current origin

proc move*(transformable: Transformable, offset: Vector2f) {.
  cdecl, importc: "sfTransformable_move".}
  ## Move a transformable by a given offset
  ## 
  ## This function adds to the current position of the object,
  ## unlike Transformable_setPosition which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``offset``:         Offset

proc rotate*(transformable: Transformable, angle: cfloat) {.
  cdecl, importc: "sfTransformable_rotate".}
  ## Rotate a transformable
  ## 
  ## This function adds to the current rotation of the object,
  ## unlike Transformable_setRotation which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``angle``:          Angle of rotation, in degrees

proc scale*(transformable: Transformable, factors: Vector2f) {.
  cdecl, importc: "sfTransformable_scale".}
  ## Scale a transformable
  ## 
  ## This function multiplies the current scale of the object,
  ## unlike Transformable_setScale which overwrites it.
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## - ``factors``:        Scale factors

proc transform*(transformable: Transformable): Transform {.
  cdecl, importc: "sfTransformable_getTransform".}
  ## Get the combined transform of a transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Transform combining the position/rotation/scale/origin of the object

proc inverseTransform*(transformable: Transformable): Transform {.
  cdecl, importc: "sfTransformable_getInverseTransform".}
  ## Get the inverse of the combined transform of a transformable
  ## 
  ## *Arguments*:
  ## - ``transformable``:  Transformable object
  ## 
  ## *Returns:* Inverse of the combined transformations applied to the object


#--- SFML/Graphics/VertexArray ---#

proc newVertexArray*(): VertexArray {.
  cdecl, importc: "sfVertexArray_create".}
  ## Create a new vertex array
  ## 
  ## *Returns:* A new VertexArray object

proc copy*(vertexArray: VertexArray): VertexArray {.
  cdecl, importc: "sfVertexArray_copy".}
  ## Copy an existing vertex array
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(vertexArray: VertexArray) {.
  destroy, cdecl, importc: "sfVertexArray_destroy".}
  ## Destroy an existing vertex array
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array to delete

proc vertexCount*(vertexArray: VertexArray): cint {.
  cdecl, importc: "sfVertexArray_getVertexCount".}
  ## Return the vertex count of a vertex array
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array object
  ## 
  ## *Returns:* Number of vertices in the array

proc getVertex*(vertexArray: VertexArray, index: cint): ptr Vertex {.
  cdecl, importc: "sfVertexArray_getVertex".}
  ## Get access to a vertex by its index
  ## 
  ## This function doesn't check ``index``, it must be in range
  ## [0, vertex count - 1]. The behaviour is undefined
  ## otherwise.
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array object
  ## - ``index``:        Index of the vertex to get
  ## 
  ## *Returns:* Pointer to the index-th vertex

proc clear*(vertexArray: VertexArray) {.
  cdecl, importc: "sfVertexArray_clear".}
  ## Clear a vertex array
  ## 
  ## This function removes all the vertices from the array.
  ## It doesn't deallocate the corresponding memory, so that
  ## adding new vertices after clearing doesn't involve
  ## reallocating all the memory.
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array object

proc resize*(vertexArray: VertexArray, vertexCount: cint) {.
  cdecl, importc: "sfVertexArray_resize".}
  ## Resize the vertex array
  ## 
  ## If ``vertexCount`` is greater than the current size, the previous
  ## vertices are kept and new (default-constructed) vertices are
  ## added.
  ## If ``vertexCount`` is less than the current size, existing vertices
  ## are removed from the array.
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array objet
  ## - ``vertexCount``:  New size of the array (number of vertices)

proc append*(vertexArray: VertexArray, vertex: Vertex) {.
  cdecl, importc: "sfVertexArray_append".}
  ## Add a vertex to a vertex array array
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array objet
  ## - ``vertex``:       Vertex to add

proc `primitiveType=`*(vertexArray: VertexArray, kind: PrimitiveType) {.
  cdecl, importc: "sfVertexArray_setPrimitiveType".}
  ## Set the type of primitives of a vertex array
  ## 
  ## This function defines how the vertices must be interpreted
  ## when it's time to draw them:
  ## - As points
  ## - As lines
  ## - As triangles
  ## - As quads
  ## The default primitive type is Points.
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array objet
  ## - ``type``:         Type of primitive

proc primitiveType*(vertexArray: VertexArray): PrimitiveType {.
  cdecl, importc: "sfVertexArray_getPrimitiveType".}
  ## Get the type of primitives drawn by a vertex array
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array objet
  ## 
  ## *Returns:* Primitive type

proc bounds*(vertexArray: VertexArray): FloatRect {.
  cdecl, importc: "sfVertexArray_getBounds".}
  ## Compute the bounding rectangle of a vertex array
  ## 
  ## This function returns the axis-aligned rectangle that
  ## contains all the vertices of the array.
  ## 
  ## *Arguments*:
  ## - ``vertexArray``:  Vertex array objet
  ## 
  ## *Returns:* Bounding rectangle of the vertex array


#--- SFML/Graphics/View ---#

proc newView*(): View {.
  cdecl, importc: "sfView_create".}
  ## Create a default view
  ## 
  ## This function creates a default view of (0, 0, 1000, 1000)
  ## 
  ## *Returns:* A new View object

proc newView*(rectangle: FloatRect): View {.
  cdecl, importc: "sfView_createFromRect".}
  ## Construct a view from a rectangle
  ## 
  ## *Arguments*:
  ## - ``rectangle``:  Rectangle defining the zone to display
  ## 
  ## *Returns:* A new View object

proc copy*(view: View): View {.
  cdecl, importc: "sfView_copy".}
  ## Copy an existing view
  ## 
  ## *Arguments*:
  ## - ``view``:  View to copy
  ## 
  ## *Returns:* Copied object

proc destroy*(view: View) {.
  destroy, cdecl, importc: "sfView_destroy".}
  ## Destroy an existing view
  ## 
  ## *Arguments*:
  ## - ``view``:  View to destroy

proc `center=`*(view: View, center: Vector2f) {.
  cdecl, importc: "sfView_setCenter".}
  ## Set the center of a view
  ## 
  ## *Arguments*:
  ## - ``view``:    View object
  ## - ``center``:  New center

proc `size=`*(view: View, size: Vector2f) {.
  cdecl, importc: "sfView_setSize".}
  ## Set the size of a view
  ## 
  ## *Arguments*:
  ## - ``view``:  View object
  ## - ``size``:  New size of the view

proc `rotation=`*(view: View, angle: cfloat) {.
  cdecl, importc: "sfView_setRotation".}
  ## Set the orientation of a view
  ## 
  ## The default rotation of a view is 0 degree.
  ## 
  ## *Arguments*:
  ## - ``view``:   View object
  ## - ``angle``:  New angle, in degrees

proc `viewport=`*(view: View, viewport: FloatRect) {.
  cdecl, importc: "sfView_setViewport".}
  ## Set the target viewport of a view
  ## 
  ## The viewport is the rectangle into which the contents of the
  ## view are displayed, expressed as a factor (between 0 and 1)
  ## of the size of the render target to which the view is applied.
  ## For example, a view which takes the left side of the target would
  ## be defined by a rect of (0, 0, 0.5, 1).
  ## By default, a view has a viewport which covers the entire target.
  ## 
  ## *Arguments*:
  ## - ``view``:      View object
  ## - ``viewport``:  New viewport rectangle

proc reset*(view: View, rectangle: FloatRect) {.
  cdecl, importc: "sfView_reset".}
  ## Reset a view to the given rectangle
  ## 
  ## Note that this function resets the rotation angle to 0.
  ## 
  ## *Arguments*:
  ## - ``view``:       View object
  ## - ``rectangle``:  Rectangle defining the zone to display

proc center*(view: View): Vector2f {.
  cdecl, importc: "sfView_getCenter".}
  ## Get the center of a view
  ## 
  ## *Arguments*:
  ## - ``view``:  View object
  ## 
  ## *Returns:* Center of the view

proc size*(view: View): Vector2f {.
  cdecl, importc: "sfView_getSize".}
  ## Get the size of a view
  ## 
  ## *Arguments*:
  ## - ``view``:  View object
  ## 
  ## *Returns:* Size of the view

proc rotation*(view: View): cfloat {.
  cdecl, importc: "sfView_getRotation".}
  ## Get the current orientation of a view
  ## 
  ## *Arguments*:
  ## - ``view``:  View object
  ## 
  ## *Returns:* Rotation angle of the view, in degrees

proc viewport*(view: View): FloatRect {.
  cdecl, importc: "sfView_getViewport".}
  ## Get the target viewport rectangle of a view
  ## 
  ## *Arguments*:
  ## - ``view``:  View object
  ## 
  ## *Returns:* Viewport rectangle, expressed as a factor of the target size

proc move*(view: View, offset: Vector2f) {.
  cdecl, importc: "sfView_move".}
  ## Move a view relatively to its current position
  ## 
  ## *Arguments*:
  ## - ``view``:    View object
  ## - ``offset``:  Offset

proc rotate*(view: View, angle: cfloat) {.
  cdecl, importc: "sfView_rotate".}
  ## Rotate a view relatively to its current orientation
  ## 
  ## *Arguments*:
  ## - ``view``:   View object
  ## - ``angle``:  Angle to rotate, in degrees

proc zoom*(view: View, factor: cfloat) {.
  cdecl, importc: "sfView_zoom".}
  ## Resize a view rectangle relatively to its current size
  ## 
  ## Resizing the view simulates a zoom, as the zone displayed on
  ## screen grows or shrinks.
  ## ``factor`` is a multiplier:
  ## - 1 keeps the size unchanged
  ## - > 1 makes the view bigger (objects appear smaller)
  ## - < 1 makes the view smaller (objects appear bigger)
  ## 
  ## *Arguments*:
  ## - ``view``:    View object
  ## - ``factor``:  Zoom factor to apply
