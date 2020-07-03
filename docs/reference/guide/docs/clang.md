# C Language Interface

Zerynth allows mixing Python and C code in the same project. The Python language is compiled to bytecode and executed by the VM independently of the target board; C language is compiled to object code dependent on the target microcontroller instruction set. The two can coexist because during the uplinking phase, Zerynth resolves any unresolved symbol from the C code and saves C function addresses in the bytecode.

This kind of “hybrid” programming is extremely useful in those scenarios where the programmer needs to write or has already written performant low level code for time critical tasks, but wants to retain Python flexibility and readability for non time critical sections.

In Zerynth it is therefore possible to call C functions from Python, but not (yet) Python functions from C. To call a C function from Python follow this procedure:


1. Define an “empty” Python function decorated with `@c_native` (let’s call it `pyfn`)
2. As arguments of `@c_native` pass the name of the C function to be called (let’s call it `cfn`), the source files where `cfn` implementation resides and a list of C macros to be defined during compilation
3. Create the C source file containing `cfn` and declare `cfn` using the C macro `C_NATIVE()`

At compile time, `@c_native` parameters will be used to locate the C source code files and compile them with the appropriate macros defined. When `pyfn` is called, the VM translates the Python call to a C call.

## C function call example

A minimal example of C function calling from Python follows.

In Python:

```py
# main.py

@c_native("my_c_function",["my_c_source.c"],[])
def my_py_function(a,b):
        """
        a simple function that returns the sum of a and b, with a and b integers
        """"
        # just pass, the body of my_py_fun is ignored by the compiler
        pass
```

In C:

```c
    // my_c_source.c

    //include zerynth header
    #include "zerynth.h"


    C_NATIVE(my_c_function) {
    C_NATIVE_UNWARN();
    int32_t a,b;
    if (parse_py_args("ii",nargs,args,&a,&b)!=2)
            return ERR_TYPE_EXC;

    *res = PSMALLINT_NEW(a+b);
    return ERR_OK;
}
```

In `main.py` the empty function `my_py_function` is defined, decorated with `@c_native`. The `@c_native` decorator informs the compiler that the body of `my_py_fun` will be a
C function called `my_c_function` implemented in the file `my_c_source.c` in the same directory where `main.py` is residing.

In `my_c_source.c` the function `my_c_function` is implemented. The macro `C_NATIVE(my_c_function)` expands to:

```py
err_t my_c_function(int32_t nargs, PObject *self, PObject **args, PObject **res)
```

where:


* **nargs** is the number of arguments passed to `my_py_function`
* **self**` is the self parameter in case `my_py_function` is a method
* **args** is an array of PObject\*, the generic structure used by the VM to represent Python objects
* **res** is a pointer to a PObject containing the result of the function call


* the returned value is of type `err_t`

The VM passes Python arguments to the C function without touching them; it is responsibility of the C function to convert them as needed. To help the conversion, the function `parse_py_args` is provided by the VM.

The return value of function `my_py_function` must be set into *res* and must be of type PObject*. The actual return value of `my_c_function` is an error code indicating success (ERR_OK) or an exception that is subsequently raised by the VM.

For more details on the low level VM functions and macros available for hybrid programming, refer to VM Guide.

## Macros

Some utility macros are added on top of the VM defined macro by the header `zerynth.h`.


**`C_NATIVE(fn)`**

Used to define the implementation of a C function callable from Python. It equals to:

```c
err_t fn(int nargs, PObject *self, PObject **args, PObject **res)
```


**`C_NATIVE_UNWARN`**

Silences C warnings about unused `C_NATIVE` arguments in the body of a C function callable from Python


**`debug(...)`**

If the user defines `ZERYNTH_DEBUG` before including `zerynth.h`, this macro behaves like a printf, writing to the default serial port of the virtual machine. Otherwise it does nothing.

The printf funcionalities are limited to the following placeholders: `%s` `%i` `%I` `%d` `%D` `%u` `%U` `%x` `%X` `%p` `%c` `%%`.


**`printf(...)`**

If the user defines `ZERYNTH_PRINTF` before including `zerynth.h`, this macro behaves like a printf, writing to the default serial port of the virtual machine. Otherwise it does nothing.

The printf funcionalities are limited to the following placeholders: `%s` `%i` `%I` `%d` `%D` `%u` `%U` `%x` `%X` `%p` `%c` `%%`.

## Zerynth “C” Limitations

C functions callable from Python have some limitations:


* floating point math can not be used (yet)
* C standard library function are not available. Only the following subset can be used:
   * `memcpy`, `memset`, `memmove`, `memcmp`, `memchr`
   * `malloc`, `free` (implemented as macros calling the garbage collector allocator)
   * `strlen`

Refer to [VM Guide](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/vm.html#zerynthvm) for the available api.

