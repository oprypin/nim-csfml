import httpclient, math, random
import csfml, csfml/ext


type Scene = enum
    scPixelate, scWaveBlur
randomize()
var scene = Scene(random(2))

proc cycle[T](x: var T) =
    x = if x == T.high: T.low
        else: succ(x)


let texture = newTexture("resources/background.jpg")
var sprite = newSprite(texture)
var pxShader = newShader(nil, fragmentShaderFilename="resources/pixelate.frag")
pxShader["texture"] = CurrentTexture


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
    for event in window.events:
        if event.kind == EventType.Closed:
            window.close()
        elif event.kind in {EventType.MouseButtonPressed, EventType.KeyPressed}:
            cycle(scene)
    
    let cursor = mouseGetPosition(window)
    let x = cursor.x / window.size.x
    let y = cursor.y / window.size.y
    let time = clock.elapsedTime.asSeconds
    
    case scene
      of scPixelate:
        pxShader["pixel_threshold"] = (x+y)/30
        
        window.draw sprite, renderStates(shader=pxShader)
    
      of scWaveBlur:
        wbShader["wave_phase"] = time
        wbShader["wave_amplitude"] = (x*40, y*40)
        wbShader["blur_radius"] = (x+y)*0.008
        
        window.clear White
        window.draw text, renderStates(shader=wbShader)
    
    window.display()

clock.destroy()
window.destroy()
wbShader.destroy()
text.destroy()
font.destroy()
pxShader.destroy()
sprite.destroy()
texture.destroy()
