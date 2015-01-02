import sys
import re

(fn,) = sys.argv[1:]

with open(fn) as f:
    s = f.read()

# MouseButton.ButtonCount -> MouseButton.Count
s = s.replace('sfMouseButtonCount', 'sfMouseCount')

# (anonymous struct) -> WindowStyle
# https://github.com/LaurentGomila/CSFML/commit/ed44d9e0db2e65f49ce6eb2f1dc0de755066e24b
s = re.sub(
    r'(enum\s*?\{\s*?sfNone([^\{]|\n)+?sfDefaultStyle.+?\})',
    r'typedef \1 sfWindowStyle', s, flags=re.S
)

# WindowStyle.DefaultStyle -> WindowStyle.Default
s = s.replace('sfDefaultStyle', 'sfDefault')

with open(fn, 'w') as f:
    f.write(s)