#!/bin/sh

python3 headers.py &&
python3 replacements.py headers_gen.h &&
python3 generate.py &&
cp -r *.nim ../src/csfml/private &&
rm *.nim
rm ../src/csfml/private/config_gen.nim
