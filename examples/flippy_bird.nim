import csfml

var window = new_RenderWindow(video_mode(800, 600), "pɹıq ʎddılɟ")
window.vertical_sync_enabled = true

let bird_texture = new_Texture("resources/bird.png")
let sz = bird_texture.size

var bird = new_Sprite(bird_texture)
bird.origin = vec2(sz.x/2, sz.y/2)
bird.scale = vec2(2.5, 2.5)
bird.position = vec2(window.size.x/3, window.size.y/2)

var speed = 0.0

while window.open:
    var event: Event
    while window.poll_event(event):
        case event.kind
          of EventType.Closed:
            window.close()
          of EventType.KeyPressed:
            case event.key.code
              of KeyCode.Escape:
                window.close()
              else:
                speed = -9.0
          else: discard
    
    speed += 0.3
    bird.move vec2(0.0, speed)
    bird.rotation =
      if speed*8.0 < 90.0: speed*8.0
      else: 90.0
     
    window.clear color(112, 197, 206)
    window.draw bird

    window.display()

bird.destroy()
bird_texture.destroy()
window.destroy()
