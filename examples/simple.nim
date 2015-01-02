import csfml

var window = newWindow(videoMode(800, 600), "SFML works!")

while window.open:
  var event: Event
  while window.pollEvent event:
    if event.kind == EventType.Closed:
      window.close()
    window.display()