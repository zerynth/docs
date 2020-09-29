# Compiler

The ZTC compiler takes a project as input and produces an executable bytecode file ready to be uplinked on a virtualized.

The command:

```
ztc compile project target
```

compiles the source files found at `project` (the project path) for a device with target `target`.

The entry point of the program is the file `main.py`. Every additional Python module needed wil be searched in the following order:


1. Project directory


2. Directories passed with the `-I` option in the given order (see below)


3. The Zerynth standard library


4. The installed libraries

Since Zerynth programs allow mixed C/Python code, the compiler also scans for C source files and compiles them with the appropriate C compiler for `target`.
C object files are packed and included in the output bytecode.

The ```compile``` command accepts additional options:


* `-I/--include path`, adds `path` to the list of directories scanned for Zerynth modules. This option can be repeated multiple times.


* `-D/--define def`, adds a C macro definition as a parameter for native C compiler. This option can be repeated multiple times.


* `-o/--output path`, specifies the path for the output file. If not specified it is `main.vbo` in the project folder.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyOTU1Mzg2Nl19
-->