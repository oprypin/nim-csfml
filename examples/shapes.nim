import csfml

let videoMode = videoMode(200, 200)
let settings = contextSettings(depth=32, antialiasing=8)
var window = newRenderWindow(videoMode, "Shapes", settings=settings)
window.verticalSyncEnabled = true

while window.open:
    var event: Event
    while window.pollEvent(event):
        case event.kind
          of EventType.Closed:
            window.close()
          else: discard
    
    window.clear Black

    # Top left
    var vertexArray = newVertexArray(PrimitiveType.Triangles)
    vertexArray.append vertex(vec2(0, 0), Green)
    vertexArray.append vertex(vec2(100, 0), Red)
    vertexArray.append vertex(vec2(0, 100), Blue)
    window.draw vertexArray
    vertexArray.destroy()

    # Top right
    var vertexSeq = @[
        vertex(vec2(200, 0), Green),
        vertex(vec2(100, 0), Red),
        vertex(vec2(200, 100), Blue),
    ]
    window.drawPrimitives(addr(vertexSeq[0]), vertexSeq.len,
                          PrimitiveType.Triangles, renderStates())
    
    # Bottom left
    var convexShape = newConvexShape(3)
    convexShape[0] = vec2(0, 200)
    convexShape[1] = vec2(100, 200)
    convexShape[2] = vec2(0, 100)
    convexShape.fillColor = Green
    window.draw convexShape
    convexShape.destroy()
    
    # Bottom right
    proc getPointCount(p: pointer): int {.cdecl.} = 3
    proc getPoint(index: int, p: pointer): Vector2f {.cdecl.} =
        case index
        of 0: vec2(200, 200)
        of 1: vec2(100, 200)
        else: vec2(200, 100)
    var customShape = newShape(getPointCount, getPoint, nil)
    customShape.update()
    customShape.fillColor = Green
    window.draw customShape
    customShape.destroy()
    
    window.display()

window.destroy()
