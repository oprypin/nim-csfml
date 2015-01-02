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
  const lib = "csfml-window-(2|2.0|2.1|2.2|2.3).dll"
else:
  const lib = "libcsfml-window.so"

import csfml_system
import csfml_util


when defined(windows) or defined(mac):
  type WindowHandle* = pointer
else:
  type WindowHandle* = culong

include csfml_window_gen


proc videoMode*(modeWidth, modeHeight: cint, bitsPerPixel: cint = 32): VideoMode =
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
proc `<=`*(a, b: VideoMode): bool =
  return not(b < a)


proc contextSettings*(depth: cint = 0, stencil: cint = 0, antialiasing: cint = 0, major: cint = 2, minor: cint = 0): ContextSettings =
  result.depthBits = depth
  result.stencilBits = stencil
  result.antialiasingLevel = antialiasing
  result.majorVersion = major
  result.minorVersion = minor


proc `title=`*(window: Window, title: string) =
  var t = utf8to32(title)
  window.unicodeTitle = addr(t[0])
proc newWindow*(mode: VideoMode, title: string, style: uint32 = DefaultStyle, settings: ContextSettings = contextSettings()): Window =
  var t = utf8to32(title)
  return newWindow(mode, addr(t[0]), style, settings)