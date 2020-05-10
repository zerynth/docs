# Programming Guide

Zerynth scripts are developed in Python 3.4. Most of the Python Standard Library functions, types and operators are available also in Zerynth, some high level processing features have been removed because not usable in embedded setups and also to reduce the VM dimension allowing the embedded porting. Differences from Zerynth and Python 3.4 standard library are reported in VM Guide.

The following guide is consequently an adaptation of [Python 3.0 official standard library guide](https://docs.python.org/3/library/index.html) that can be used for Python syntax, types, operators and constants details and use.

The “Python standard library” contains several different kinds of components. It contains data types that would normally be considered part of the “core” of a language, such as numbers and lists.  In addition, the Zerynth library also contains a set of builtins that can be used in Zerynth scripts without the need of an import statement.

The bulk of the library, however, consists of a collection of modules (that require import to be used in scripts). Some modules provide interfaces that are highly specific to Zerynth, like managing threads and the board’s hardware and peripherals and connections; some other provides interfaces that are specific for particular sensors, shields and auxiliary boards.

This manual is organized “from top to bottom” it first describes how to start with Zerynth, then shows you some examples and finally goes in details with description of Zerynth built-in functions and  modules.


