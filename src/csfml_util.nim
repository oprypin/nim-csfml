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


import unicode

proc utf8to32*(s: string): seq[uint32] =
  result = @[]
  for c in runes(s):
    result.add(uint32(c))
  result.add 0

type IntBool* = distinct cint
converter toBool*(x: IntBool): bool =
    cint(x) != 0
converter toIntBool*(x: bool): IntBool =
    IntBool(if x: 1 else: 0)
