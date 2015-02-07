import httpclient, math
import csfml


type Scene = enum
    scPixelate, scWaveBlur
randomize()
var scene = Scene(random(2))

proc cycle[T](x: var T) =
    x = if x == T.high: T.low
        else: succ(x)


let texture = newTexture("resources/background.jpg", rect(0, 0, 0, 0))
var sprite = newSprite(texture)
var pxShader = newShader(nil, fragmentShaderFilename="resources/pixelate.frag")
pxShader.currentTextureParameter = "texture"


let ipsum = getContent("http://loripsum.net/api/12/short/plaintext")
let font = newFont("resources/sansation.ttf")
var text = newText(ipsum, font, 22)
text.position = vec2(30, 20)
text.color = Black
var wbShader = newShader(vertexShaderFilename="resources/wave.vert",
                         fragmentShaderFilename="resources/blur.frag")


var window = newRenderWindow(videoMode(800, 600), "SFML Shader",
                             WindowStyle.Titlebar|WindowStyle.Close)
window.verticalSyncEnabled = true

var clock = newClock()
while window.open:
    var event: Event
    while window.pollEvent(event):
        if event.kind == EventType.Closed:
            window.close()
        elif event.kind in {EventType.MouseButtonPressed, EventType.KeyPressed}:
            cycle(scene)
    
    let cursor = mouseGetPositionRenderWindow(window)
    let x = cursor.x / window.size.x
    let y = cursor.y / window.size.y
    let time = clock.elapsedTime.asSeconds
    
    case scene
      of scPixelate:
        pxShader.setFloatParameter "pixel_threshold", (x+y)/30
        
        window.draw sprite, renderStates(shader=pxShader)
    
      of scWaveBlur:
        wbShader.setFloatParameter "wave_phase", time
        wbShader.setFloat2Parameter "wave_amplitude", x*40, y*40
        wbShader.setFloatParameter "blur_radius", (x+y)*0.008
        
        window.clear White
        window.draw text, renderStates(shader=wbShader)
    
    window.display()
