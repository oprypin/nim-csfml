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

const module = "window"
include private/csfml_common

import csfml_system


when defined(windows) or defined(mac):
  type WindowHandle* = pointer
else:
  type WindowHandle* = culong

{.push dynlib: lib.}
include private/csfml_window_gen
{.pop.}


proc contextSettings*(depth: cint = 0, stencil: cint = 0, antialiasing: cint = 0, major: cint = 2, minor: cint = 0): ContextSettings =
  ## *Arguments*:
  ## ``depth``: Depth buffer bits
  ## ``stencil``: Stencil buffer bits
  ## ``antialiasing``: Antialiasing level
  ## ``major``: Major number of the context version
  ## ``minor``: Minor number of the context version
  ##
  ## *Returns*: ContextSettings with these members
  result.depthBits = depth
  result.stencilBits = stencil
  result.antialiasingLevel = antialiasing
  result.majorVersion = major
  result.minorVersion = minor


proc mouse_getPosition*(): Vector2i = mouse_getPosition(nil)
  ## *Returns*: The current position of mouse cursor relative to desktop

proc mouse_setPosition*(position: Vector2i) = mouse_setPosition(position, nil)
  ## Set the current position of the mouse relative to desktop
  ##
  ## *Arguments*:
  ## - ``position``: New position of the mouse


proc videoMode*(): VideoMode = result
  ## *Returns*: a VideoMode with all members set to 0
proc videoMode*(modeWidth, modeHeight: cint, bitsPerPixel: cint = 32): VideoMode =
  ## *Arguments*:
  ## - ``modeWidth``: Width in pixels
  ## - ``modeHeight``: Height in pixels
  ## - ``modeBitsPerPixel``: Pixel depths in bits per pixel
  ##
  ## *Returns*: a VideoMode with these members
  result.width = modeWidth
  result.height = modeHeight
  result.bitsPerPixel = bitsPerPixel

proc `==`*(a, b: VideoMode): bool =
  return a.width == b.width and a.height == b.height and a.bitsPerPixel == b.bitsPerPixel
proc `<`*(a, b: VideoMode): bool =
  if a.bitsPerPixel == b.bitsPerPixel:
    if a.width == b.width:
      return a.height < b.height
    return a.width < b.width
  return a.bitsPerPixel < b.bitsPerPixel
proc `<=`*(a, b: VideoMode): bool = not(b < a)

proc videoMode_getFullscreenModes*(): seq[VideoMode] =
  ## Wrapper proc that returns a seq instead of exposing pointers
  ##
  ## *Returns:* seq containing all the supported fullscreen modes
  var count: int
  var p = cast[int](videoMode_getFullscreenModes(addr count))
  result = newSeq[VideoMode](count)
  for i in result.low..result.high:
    result[i] = cast[ptr VideoMode](p)[]
    p += sizeof(VideoMode)


converter toBitMaskU32*(a: WindowStyle): BitMaskU32 = BitMaskU32 a
  ## Allows WindowStyle values to be combined using the | operator and be used in functions

proc `title=`*(window: Window, title: string) =
  ## Change the title of a window (with a normal UTF-8 string)
  ##
  ## *Arguments*:
  ## - ``window``: Window object
  ## - ``title``: New title
  var t = utf8to32(title)
  window.title_U32 = addr(t[0])

proc newWindow*(mode: VideoMode, title: string, style: BitMaskU32 = WindowStyle.Default,
                settings = contextSettings()): Window =
  ## Construct a new window (with a UTF-8 title)
  ##
  ## This function creates the window with the size and pixel
  ## depth defined in ``mode``. An optional style can be passed to
  ## customize the look and behaviour of the window (borders,
  ## title bar, resizable, closable, ...). If ``style`` contains
  ## Fullscreen, then ``mode`` must be a valid video mode.
  ##
  ## The fourth parameter is a pointer to a structure specifying
  ## advanced OpenGL context settings such as antialiasing,
  ## depth-buffer bits, etc.
  ##
  ## *Arguments*:
  ## - ``mode``: Video mode to use (defines the width, height and depth of the rendering area of the window)
  ## - ``title``: Title of the window (normal UTF-8 string)
  ## - ``style``: Window style
  ## - ``settings``: Additional settings for the underlying OpenGL context
  ##
  ## *Returns:* A new Window object
  var t = utf8to32(title)
  newWindow_U32(mode, addr(t[0]), style, settings)
