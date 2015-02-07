Examples
========

### [simple](simple.nim)

- Show a `Window`
- React to close event

### [flippy_bird](flippy_bird.nim)

- Show a `RenderWindow`
- Setup antialiasing
- Unicode window title
- React to close and keyboard events
- Use a `Texture` and a `Sprite`
    - Move, scale, rotate, draw

### [pong](pong.nim)

Pong example [from SFML][pong]

- `Sound` and `SoundBuffer`
- `RectangleShape` and `CircleShape`
- `Text` and `Font`
- `Clock`
- Keyboard querying
- Math

### [snakes](snakes.nim)

- Object-oriented
- Custom drawables
- `RenderStates`
- Keyboard events

### [sound_capture](sound_capture.nim)

Sound Capture example [from SFML][sound_capture]

- Record sound
- Play sound
- Save sound

### [shapes](shapes.nim)

- `VertexArray`
- `drawPrimitives`
- `ConvexShape`
- Custom `Shape`

### [gl](gl.nim)

- Basic OpenGL

### [shader](shader.nim)

Parts of the Shader example [from SFML][shader]

- Fragment and vertex shaders
    - Load from file
    - Set arguments
    - Apply

### [typing](typing.nim)

- Keyboard events, `TextEntered`
- Unicode (Rune) string



Acknowledgements
----------------

- *pong.nim* was adapted from [SFML's Pong example][pong]
- *sound_capture.nim* was adapted from [SFML's Sound Capture example][sound_capture]
- *shader.nim* was adapted from [SFML's Shader example][shader]
- *resources*: *sansation.ttf*, *ball.wav*, *background.jpg*, *pixelate.frag*, *wave.vert*, *blur.frag*
  were taken [from SFML's repository](https://github.com/LaurentGomila/SFML/blob/master/examples)
- All the other files in this *examples* folder may be used without any limitations.


[pong]: https://github.com/LaurentGomila/SFML/blob/master/examples/pong
[sound_capture]: https://github.com/LaurentGomila/SFML/blob/master/examples/sound_capture/
[shader]: https://github.com/LaurentGomila/SFML/blob/master/examples/shader/