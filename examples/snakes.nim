import math, sequtils
import csfml


var window = new_RenderWindow(
    video_mode(800, 800), "Snakes",
    WindowStyle.Default, context_settings(32, antialiasing=8)
)
window.framerate_limit = 10


let
    Left = vec2(-1, 0)
    Up = vec2(0, -1)
    Right = vec2(1, 0)
    Down = vec2(0, 1)
let directions = [Left, Up, Right, Down]

randomize()

proc random_color(): Color =
    color(random(128)+128, random(128)+128, random(128)+128)

proc modulo[T](a, b: T): T =
    ## mod with wraparound: modulo(-7, 5)==3
    T(float(a) mod float(b))



type
    Food = object
        position: Vector2i
        color: Color
    
    Snake = ref object
        field: Field
        body: seq[Vector2i]
        color: Color
        direction: Vector2i
    
    Field = ref object
        size: Vector2i
        snakes: seq[Snake]
        foods: seq[Food]



proc init_Food(position: Vector2i, color: Color): Food =
    result.position = position
    result.color = color

proc draw[T](self: Food, target: T, states: RenderStates) =
    var circle = new_CircleShape(radius=0.9/2)
    circle.position = vec2(self.position)+vec2(0.05, 0.05)
    circle.fill_color = self.color
    target.draw circle, states



proc new_Snake(field: Field, start: Vector2i, color: Color): Snake =
    new result
    result.field = field
    result.color = color
    result.direction = Up
    result.body = @[]
    for i in 0..2:
        result.body.add vec2(start.x, start.y+i)

proc step(self: Snake) =
    var head = self.body[0]+self.direction
    head.x = modulo(head.x, self.field.size.x)
    head.y = modulo(head.y, self.field.size.y)
    self.body.insert head
    discard self.body.pop()

proc turn(self: Snake, direction: Vector2i) =
    if self.body[1] != self.body[0]+direction:
        self.direction = direction

proc grow(self: Snake) =
    let tail = self.body[self.body.high]
    for i in 1..3:
        self.body.add tail

proc collide(self: Snake, other: Snake): bool =
    for part in other.body:
        if self.body[0] == part:
            return true
    return false

proc collide(self: Snake, food: Food): bool =
    self.body[0] == food.position

proc collide(self: Snake): bool =
    var first = true
    for part in self.body:
        if self.body[0] == part and not first:
            return true
        first = false
    return false

proc draw[T](self: Snake, target: T, states: RenderStates) =
    for i in self.body.low..self.body.high:
        let current = self.body[i]

        var segment = new_CircleShape(radius=0.9/2)
        segment.position = vec2(current)+vec2(0.05, 0.05)
        segment.fill_color = self.color
        target.draw segment, states

        # The following is eye candy and may be removed
        # but change the above to RectangleShape of size (0.9, 0.9)

        # Look in 4 directions around this segment. If there is another one
        # neighboring it, draw a square between them
        for d in directions:
            let td = vec2(
              modulo((current+d).x, self.field.size.x),
              modulo((current+d).y, self.field.size.y))
            
            if (i > self.body.low and td == self.body[i-1]) or
              (i < self.body.high and td == self.body[i+1]):
                var connection = new_RectangleShape(size=vec2(0.9, 0.9))
                connection.position = vec2(current)+vec2(float(d.x)/2.0+0.05, float(d.y)/2.0+0.05)
                connection.fill_color = self.color
                target.draw connection, states
        
        # Draw eyes with a darkened color
        var eye = new_CircleShape(radius=0.2/2)
        eye.fill_color = color(
          self.color.red div 3, self.color.green div 3, self.color.blue div 3)

        let delta = vec2(abs(self.direction.y)/4, abs(self.direction.x)/4)
        eye.position = self.body[0]+vec2(0.4, 0.4)+delta
        target.draw eye, states
        eye.position = self.body[0]+vec2(0.4, 0.4)-delta
        target.draw eye, states



proc new_Field(size: Vector2i): Field =
    new result
    result.size = size
    result.snakes = @[]
    result.foods = @[]

proc step(self: Field) =
    while self.foods.len < self.snakes.len+1:
        let food = init_Food(
          vec2(random(self.size.x), random(self.size.y)),
          random_color())
        
        block check: # Don't allow new food on top of a snake
            for snake in self.snakes:
                if collide(snake, food):
                    break check
            self.foods.add food

    
    for snake in self.snakes:
        snake.step()

        self.foods = self.foods.filter do (food: Food) -> bool:
            if collide(snake, food):
                snake.grow()
                return false
            return true
    
    let snakes = self.snakes
    self.snakes = snakes.filter do (snake: Snake) -> bool:
        if snake.collide():
            return false
        for snake2 in snakes:
            if snake != snake2 and collide(snake, snake2):
                return false
        return true

proc draw[T](self: Field, target: T, states: RenderStates) =
    for snake in self.snakes:
        target.draw snake, states
    for food in self.foods:
        target.draw food, states




var field = new_Field(vec2(40, 40))

var snake1 = new_Snake(field, vec2(field.size.x div 2-5, field.size.y div 2), random_color())
var snake2 = new_Snake(field, vec2(field.size.x div 2+5, field.size.y div 2), random_color())
field.snakes.add snake1
field.snakes.add snake2

var transform = Identity
transform.scale vec2(20, 20)

let states = render_states(transform=transform)

while window.open:
    var event: Event
    while window.poll_event(event):
        if event.kind == EventType.Closed or
          (event.kind == EventType.KeyPressed and event.key.code == KeyCode.Escape):
            window.close()
        
        elif event.kind == EventType.KeyPressed:
            case event.key.code
                of KeyCode.A: snake1.turn Left
                of KeyCode.W: snake1.turn Up
                of KeyCode.D: snake1.turn Right
                of KeyCode.S: snake1.turn Down

                of KeyCode.Left: snake2.turn Left
                of KeyCode.Up: snake2.turn Up
                of KeyCode.Right: snake2.turn Right
                of KeyCode.Down: snake2.turn Down

                else: discard

    field.step()

    window.clear Black
    window.draw field, states
    
    window.display()
