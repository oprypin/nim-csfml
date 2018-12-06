import csfml
import opengl

var window = newRenderWindow(videoMode(500, 500), "OpenGL")
window.verticalSyncEnabled = true

opengl.loadExtensions()

var event: Event

while window.open:
  while window.pollEvent(event):
    case event.kind
      of EventType.Resized:
        glViewport(0, 0, event.size.width, event.size.height)
      of EventType.Closed:
        window.close()
      else: discard

  window.clear Black

  glBegin GL_TRIANGLES; block:
    glColor3f(0.0, 1.0, 0.0); glVertex2f(-1.0,  1.0)
    glColor3f(1.0, 0.5, 0.0); glVertex2f( 1.0,  0.0)
    glColor3f(0.0, 0.5, 1.0); glVertex2f( 0.0, -1.0)
  glEnd()

  window.display()

window.destroy()
