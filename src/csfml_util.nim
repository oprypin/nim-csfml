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


## Types and conversions exported by all modules of nim-csfml

import unicode, unsigned

type
  BoolInt* = distinct cint ## CSFML uses cint as bool
  RuneU32* = distinct uint32 ## CSFML uses uint32 for Unicode characters
  StringU32* = ptr RuneU32 ## CSFML uses uint32* for Unicode strings
  BitMaskU32* = distinct uint32 ## CSFML uses uint32 for bitmask enum arguments

proc utf8to32*(s: string): seq[RuneU32] =
  ## Converts a UTF-8 string to a zero-terminated sequence of Runes
  result = @[]
  for c in s.runes:
    result.add RuneU32(c)
  result.add RuneU32(0)

converter toBool*(x: BoolInt): bool = cint(x) != 0
  ## Converts BoolInt to bool
converter toBoolInt*(x: bool): BoolInt = BoolInt(if x: 1 else: 0)
  ## Converts bool to BoolInt

proc `|`*(a, b: BitMaskU32): BitMaskU32 = BitMaskU32(uint32(a) or uint32(b))
  ## Operator for combining two bitmask values

converter toRuneU32*(x: Rune): RuneU32 = RuneU32 x
  ## Converts Rune to RuneU32
converter toRune*(x: RuneU32): Rune = Rune x
  ## Converts RuneU32 to Rune
