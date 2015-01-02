import csfml

block:
  var a = vec2(2, 3)
  assert a+vec2(-1, 5) == vec2(1, 8)
  assert a/2 == vec2(1, 1)
  
  var b = vec2(4.0, 6)
  assert b-vec2(5, 3) == vec2(-1.0, 3)
  
  assert 2.0 > (b/2.5).x
  
  var c = vec3(1.0, 2.0, 3.0)
  assert c != vec3(2.4, 1.6, 4.2)

block:
  var clock = newClock()

  sleep(seconds(0.2))

  let t1 = clock.restart().asSeconds
  assert t1 > 0.15
  assert t1 < 0.25

  sleep(seconds(0.1))

  let t2 = clock.elapsedTime.asMicroseconds
  assert t2 > 50000
  assert t2 < 150000

