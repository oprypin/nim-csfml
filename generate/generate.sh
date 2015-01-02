#!/bin/sh

python3 headers.py > headers_gen.h &&
python3 generate.py headers_gen.h &&
cp -r *.nim ../src &&
rm *.nim
rm ../src/csfml_config_gen.nim