Run *generate.sh* on Linux to (re)create <em>[src](../src)/csfml\_*\_gen.nim</em> source files based on CSFML's header files.

This automatic generator expects the header files to be in */usr/include/SFML*. It requires [Python][] 3.3+ and [pycparser][].

The generator's code is very messy, and there some specific replacements that make the word "automatic" a bit dishonest. Still, it should allow transitioning to new CSFML versions with little to no intervention.



[python]: http://python.org
[pycparser]: https://pypi.python.org/pypi/pycparser
