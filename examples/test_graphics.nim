import csfml

block:
  assert color(7, 8, 9) == color(7, 8, 9, 255)
  assert color(0, 0, 0) != color(0, 0, 0, 0)
  
  assert color(123, 51, 64)*color(255, 45, 12, 200) == color(123, 9, 3, 200)
  
  assert color(0, 5, 10)-color(3, 5, 7) == color(0, 0, 3, 0)
  
  assert Yellow == color(255, 255, 0)

block:
  let s = "Випробування"
  var txt = newText()
  txt.str = s
  assert txt.str == s