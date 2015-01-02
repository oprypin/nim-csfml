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


type
  Event* {.pure.} = object
    case kind*: EventType
      of EventType.KeyPressed, EventType.KeyReleased:
        key*: KeyEvent
      of EventType.MouseButtonPressed, EventType.MouseButtonReleased:
        mouseButton*: MouseButtonEvent
      of EventType.TextEntered:
        text*: TextEvent
      of EventType.JoystickConnected, EventType.JoystickDisconnected:
        joystickConnect*: JoystickConnectEvent
      of EventType.JoystickMoved:
        joystickMove*: JoystickMoveEvent
      of EventType.JoystickButtonPressed, EventType.JoystickButtonReleased:
        joystickButton*: JoystickButtonEvent
      of EventType.Resized:
        size*: SizeEvent
      of EventType.MouseMoved, EventType.MouseEntered, EventType.MouseLeft:
        mouseMove*: MouseMoveEvent
      of EventType.MouseWheelMoved:
        mouseWheel*: MouseWheelEvent
      else: nil