nim-csfml
=========

This is a work in progress. See [examples](examples).

- The files <em>[src](src)/csfml\_\*\_gen.nim</em> are [automatically generated](generate) from CSFML's header files. They provide the base CSFML API.
- The files <em>csfml_\*.nim</em> build upon them, adding some compatibility with SFML API.
- *csfml.nim* automatically imports *system*, *window* and *graphics*.
- *audio* should be imported separately.
- *network* is not implemented.

*nim-csfml* has been tested with SFML 2.1 and CSFML 2.1 on Linux.

This library can be installed using [Nimble][].

[SFML][] and [CSFML][] must be installed to use *nim-csfml*.


Acknowledgements
----------------

[License](LICENSE): zlib/libpng

This library uses and is based on [SFML][] and [CSFML][].

[nimrod-sfml][] was a great source of knowledge.

[Nim][] and [Python][] programming languages are used.



[sfml]: http://www.sfml-dev.org/ "Simple and Fast Multimedia Library"
[csfml]: http://www.sfml-dev.org/download/csfml/
[nim]: http://nim-lang.org/
[python]: http://python.org/
[nimble]: https://github.com/nim-lang/nimble
[nimrod-sfml]: https://github.com/fowlmouth/nimrod-sfml