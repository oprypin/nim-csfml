import unicode
import csfml

var window = new_RenderWindow(video_mode(800, 600), "Typing")
window.vertical_sync_enabled = true

var str = new_seq[Rune]()

var font = new_Font("resources/sansation.ttf")

var text = new_Text("_", font)
text.color = Black

while window.open:
    var event: Event
    while window.poll_event(event):
        case event.kind
        of EventType.KeyPressed:
            case event.key.code
            of KeyCode.Escape:
                window.close()
            of KeyCode.Backspace:
                if str.len > 0:
                    discard str.pop()
            of KeyCode.Enter:
                str.add Rune(10)
            else: discard
        of EventType.TextEntered:
            if ord(event.text.unicode) >= ord(' '):
                str.add event.text.unicode
            text.str = $str & "_"
        of EventType.Closed:
            window.close()
        else: discard

    window.clear White
    window.draw text
    window.display()

text.destroy()
font.destroy()
window.destroy()
