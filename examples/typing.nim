import csfml

import unicode

var window = new_RenderWindow(video_mode(800, 600), "Typing")
window.vertical_sync_enabled = true

var str = newSeq[Rune]()

var font = new_Font("sansation.ttf")

var text = new_Text()
text.font = font
text.color = Black

while window.open:
    var event: Event
    while window.poll_event(event):
        if event.kind == EventType.Closed:
            window.close()
        if event.kind == EventType.KeyPressed:
            if event.key.code == KeyCode.Escape:
                window.close()
            if event.key.code == KeyCode.Back:
                if str.len > 0:
                    discard str.pop()
                    text.str = $str
        if event.kind == EventType.TextEntered:
            if ord(event.text.unicode) >= ord(' '):
                str.add event.text.unicode
                text.str = $str

    window.clear White
    window.draw text
    window.display()