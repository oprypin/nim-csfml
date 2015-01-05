# Adapted from SFML Pong example
# https://github.com/LaurentGomila/SFML/blob/master/examples/pong/Pong.cpp

import math
import csfml, csfml_audio


randomize()

# Define some constants
const gameWidth = 800
const gameHeight = 600
let paddleSize = vec2(25, 100)
let ballRadius = 10.0

# Create the window of the application
var window = newRenderWindow(
  videoMode(gameWidth, gameHeight), "SFML Pong",
  WindowStyle.Titlebar|WindowStyle.Close)
window.verticalSyncEnabled = true

# Load the sounds used in the game
var ballSoundBuffer = newSoundBuffer("ball.wav")
var ballSound = newSound(ballSoundBuffer)

# Create the left paddle
var leftPaddle = newRectangleShape(size = paddleSize - vec2(3, 3))
leftPaddle.outlineThickness = 3
leftPaddle.outlineColor = Black
leftPaddle.fillColor = color(100, 100, 200)
leftPaddle.origin = paddleSize / 2.0

# Create the right paddle
var rightPaddle = newRectangleShape(size = paddleSize - vec2(3, 3))
rightPaddle.outlineThickness = 3
rightPaddle.outlineColor = Black
rightPaddle.fillColor = color(200, 100, 100)
rightPaddle.origin = paddleSize / 2.0

# Create the ball
var ball = newCircleShape(radius = ballRadius - 3)
ball.outlineThickness = 3
ball.outlineColor = Black
ball.fillColor = White
ball.origin = vec2(ballRadius / 2, ballRadius / 2)

# Load the text font
var font = newFont("sansation.ttf")

# Initialize the pause message
var pauseMessage = newText("Welcome to SFML pong!\nPress space to start the game", font, 40)
pauseMessage.position = vec2(170.0, 150.0)
pauseMessage.color = White

# Define the paddles properties
var AITimer = newClock()
let AITime = 0.1.seconds
const paddleSpeed = 400.0
var rightPaddleSpeed = 0.0
const ballSpeed = 400.0
var ballAngle = 0.0 # to be changed later

var clock = newClock()
var isPlaying = false
while window.open:
    # Handle events
    var event: Event
    while window.pollEvent(event):
        # Window closed or escape key pressed: exit
        if event.kind == EventType.Closed or
          (event.kind == EventType.KeyPressed and event.key.code == KeyCode.Escape):
            window.close()
            break

        # Space key pressed: play
        if event.kind == EventType.KeyPressed and event.key.code == KeyCode.Space:
            if not isPlaying:
                # (re)start the game
                isPlaying = true
                discard clock.restart()

                # Reset the position of the paddles and ball
                leftPaddle.position = vec2(10 + paddleSize.x / 2, gameHeight / 2)
                rightPaddle.position = vec2(gameWidth - 10 - paddleSize.x / 2, gameHeight / 2)
                ball.position = vec2(gameWidth / 2, gameHeight / 2)

                # Reset the ball angle
                while true:
                    # Make sure the ball initial angle is not too much vertical
                    ballAngle = random(360.0) * 2 * PI / 360
                    if abs(cos ballAngle) > 0.7:
                        break

    if isPlaying:
        var deltaTime = clock.restart().asSeconds

        # Move the player's paddle
        if keyboardIsKeyPressed(KeyCode.Up):
            if leftPaddle.position.y - paddleSize.y / 2 > 5.0:
                leftPaddle.move vec2(0.0, -paddleSpeed * deltaTime)
        if keyboardIsKeyPressed(KeyCode.Down):
            if leftPaddle.position.y + paddleSize.y / 2 < gameHeight - 5.0:
                leftPaddle.move vec2(0.0, paddleSpeed * deltaTime)

        # Move the computer's paddle
        if (rightPaddleSpeed < 0.0 and rightPaddle.position.y - paddleSize.y / 2 > 5.0) or
          (rightPaddleSpeed > 0.0 and rightPaddle.position.y + paddleSize.y / 2 < gameHeight - 5.0):
            rightPaddle.move vec2(0.0, rightPaddleSpeed * deltaTime)

        # Update the computer's paddle direction according to the ball position
        if AITimer.elapsedTime > AITime:
            discard AITimer.restart()
            if ball.position.y + ballRadius > rightPaddle.position.y + paddleSize.y / 2:
                rightPaddleSpeed = paddleSpeed
            elif ball.position.y - ballRadius < rightPaddle.position.y - paddleSize.y / 2:
                rightPaddleSpeed = -paddleSpeed
            else:
                rightPaddleSpeed = 0.0

        # Move the ball
        var factor = ballSpeed * deltaTime
        ball.move vec2(cos(ballAngle) * factor, sin(ballAngle) * factor)

        # Check collisions between the ball and the screen
        if ball.position.x - ballRadius < 0.0:
            isPlaying = false
            pauseMessage.str = "You lost!\nPress space to restart or\nescape to exit"
        if ball.position.x + ballRadius > gameWidth:
            isPlaying = false
            pauseMessage.str = "You won!\nPress space to restart or\nescape to exit"
        if ball.position.y - ballRadius < 0.0:
            ballSound.play()
            ballAngle = -ballAngle
            ball.position = vec2(ball.position.x, ballRadius + 0.1)
        if ball.position.y + ballRadius > gameHeight:
            ballSound.play()
            ballAngle = -ballAngle
            ball.position = vec2(ball.position.x, gameHeight - ballRadius - 0.1)

        # Check the collisions between the ball and the paddles
        # Left Paddle
        if ball.position.x - ballRadius < leftPaddle.position.x + paddleSize.x / 2 and 
          ball.position.x - ballRadius > leftPaddle.position.x and
          ball.position.y + ballRadius >= leftPaddle.position.y - paddleSize.y / 2 and
          ball.position.y - ballRadius <= leftPaddle.position.y + paddleSize.y / 2:
            if ball.position.y > leftPaddle.position.y:
                ballAngle = PI - ballAngle + random(20.0) * PI / 180.0
            else:
                ballAngle = PI - ballAngle - random(20.0) * PI / 180.0

            ballSound.play()
            ball.position = vec2(leftPaddle.position.x + ballRadius + paddleSize.x / 2 + 0.1, ball.position.y)

        # Right Paddle
        if ball.position.x + ballRadius > rightPaddle.position.x - paddleSize.x / 2 and
          ball.position.x + ballRadius < rightPaddle.position.x and
          ball.position.y + ballRadius >= rightPaddle.position.y - paddleSize.y / 2 and
          ball.position.y - ballRadius <= rightPaddle.position.y + paddleSize.y / 2:
            if ball.position.y > rightPaddle.position.y:
                ballAngle = PI - ballAngle + random(20.0) * PI / 180.0
            else:
                ballAngle = PI - ballAngle - random(20.0) * PI / 180.0

            ballSound.play()
            ball.position = vec2(rightPaddle.position.x - ballRadius - paddleSize.x / 2 - 0.1, ball.position.y)

    # Clear the window
    window.clear color(50, 200, 50)

    if isPlaying:
        # Draw the paddles and the ball
        window.draw leftPaddle
        window.draw rightPaddle
        window.draw ball
    else:
        # Draw the pause message
        window.draw pauseMessage

    # Display things on screen
    window.display()
