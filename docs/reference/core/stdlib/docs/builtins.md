# Builtins

This module contains builtins functions and constants. It is automatically loaded and you don’t need to prefix the
module name to call its functions. For example it is not necessary to write `__builtins__.print()` but only `print()` will suffice.
The explicit name `__builtins__` must be used when there is a need to modify a builtin name. For example, to change the default stream it is necessary to write `__builtins__.__default_stream=mystream`.

## Builtins Constants

Zerynth VM defines the following Python builtin constants:


`False()`

The false value of the `bool()` type. Assignments to `False`
are illegal and raise a :exc:`SyntaxError`.

`True()`

The true value of the `bool()` type. Assignments to `True`
are illegal and raise a :exc:`SyntaxError`.


`None()`

The sole value of the type `NoneType`.  `None` is frequently used to
represent the absence of a value, as when default arguments are not passed to a function. Assignments to `None` are illegal and raise a :exc:`SyntaxError`.

Zerynth VM recognizes a set of pre-defined uppercase names representing constants:


* Pin Names:


    * `D0` to `D127` representing the names of digital pins.


    * `A0` to `A127` representing the names of analog pins.


    * `LED0` to `LED32` representing the names of the board leds.


    * `BTN0` to `BTN32` representing the names of the board buttons.


* Pin Modes and Values:


    * `INPUT, OUTPUT, INPUT_PULLUP, INPUT_PULLDOWN, OUTPUT_PUSHPULL, OUTPUT_OPENDRAIN, INPUT_ANALOG` representing pin modes.


    * `LOW, HIGH` representing digital pin states.


* Time Units:


    * `MICROS` to select microseconds


    * `MILLIS` to select milliseconds


    * `SECONDS` to select seconds


* Peripherals Names:


    * `SERIAL0` to `SERIAL7` representing the name of the nth serial port of a board.


    * `ADC0` to `ADC7` representing the name of the nth analog to digital converter of a board.

## Builtin Exceptions

Zerynth VM exceptions are different from Python exceptions. In Python, exceptions are very powerful because they are implemented as classes, contain error messages, and one can examine the full exceution stack when an exception is raised.
However, in the embedded world, resources are precious and keeping class definition in memory, creating a class instance everytime an exception is raised, can be very resource-consuming.

Zerynth VM exceptions are therefore implemented as error codes with optional static error messages organized as a tree:

```
Exception
  +-- StopIteration
  +-- ArithmeticError
  |    +-- FloatingPointError
  |    +-- OverflowError
  |    +-- ZeroDivisionError
  +-- AttributeError
  +-- LookupError
  |    +-- IndexError
  |    +-- KeyError
  +-- MemoryError
  +-- NameError
  +-- PeripheralError
  |    +-- InvalidPinError
  |    +-- InvalidHardwareStatusError
  |    +-- HardwareInitializationError
  +-- IOError
  |    +-- ConnectionError
  |    |    +-- ConnectionAbortedError
  |    |    +-- ConnectionRefusedError
  |    |    +-- ConnectionResetError
  |    +-- TimeoutError
  +-- RuntimeError
  |    +-- NotImplementedError
  |    +-- UnsupportedError
  +-- TypeError
  +-- ValueError
```

This way, the inheritance mechanism of classes is mantained and trasposed to the exception matching mechanism transparently.
The following is valid Zerynth code:

```
try:
    # raise ZeroDivisionError
    x = 1/0
except ArithmeticError as e:
    print(e)
```

The main difference between Zerynth exceptions and Python exceptions is in the way new exceptions are created and used.
To create a user defined exception in Zerynth you need to use the following code:

```
new_exception(MyExceptionName, MyExceptionParent, MyErrorMessage)
```

The builtin function `new_exception` always needs 2 arguments and an optional message:


* the first one is the user defined exception name


* the second is the name of the parent exception in the exception tree


* the third one is a static error message, where static in this context means both that it is not stored in ram as a Python string and that it can be defined only once and never changed later.

Behind the scenes `MyExceptionName` is created and placed under `MyExceptionParent` in the exception tree. An exception object is returned.
The exception object can only be compared to other exceptions, printed (as an error code plus message error) or raised again.

When an exception is printed, the error message is concatenated with the error code and, if the exception has been raised, with the bytecode position where the error happened.

Zerynth exceptions are not garbage collected. They also are not scoped: this means that an exception defined in a module is not contained in that module, but it is moved at builtin scope, so that it can be accessible by all other modules simply by name.
This feature has a drawback: two modules defining an exception with the same name, can’t be compiled in the same program. Exception names must be ```manually``` scoped by correctly choosing them (i.e. preprending the module name to the actual name).

## Builtin GPIO Functions

Zerynth VM extends Python with builtins functions to handle the General Purpose Input Output pins of the embedded device.
These functions resembles the ones used by Arduino, but are more flexible.


---
#### `#!py3 pinMode()`

!!!abstract "`#!py3 pinMode(pin, mode)`"

Sets the pin ```pin``` in mode ```mode```. Allowed values for ```mode``` are `INPUT, OUTPUT, INPUT_PULLUP, INPUT_PULLDOWN, OUTPUT_PUSHPULL, OUTPUT_OPENDRAIN, INPUT_ANALOG`


---
#### `#!py3 digitalRead()`

!!!abstract "`#!py3 digitalRead(pin)`"

Returns the state of the pin ```pin```. The state can be `LOW` or `HIGH`


---
#### `#!py3 digitalWrite()`

!!!abstract "`#!py3 digitalWrite(pin, val)`"

Sets the pin ```pin``` to the value ```val```. If val is zero, ```pin``` is set to `LOW`, otherwise to `HIGH`


---
#### `#!py3 pinToggle()`

!!!abstract "`#!py3 pinToggle(pin)`"

Sets the pin ```pin``` to the value opposite to the current pin value. If value is zero, ```pin``` is set to `HIGH`, otherwise to `LOW`


---
#### `#!py3 analogRead()`

!!!abstract "`#!py3 analogRead(pin, samples=1)`"

Reads analog values from ```pin``` that must be one of the Ax pins. If ```samples``` is 1 or not given, returns the integer value read from ```pin```.
If ```samples``` is greater than 1, returns a tuple of integers of size ```samples```.
The maximum value returned by analogRead depends on the analog resolution of the board.

analogRead works by calling the adc driver (Analog to Digital Converter) that must be imported and configured:

```
# import the adc driver
import adc

# adc is now configured with default parameters, analogRead can be used as
x = analogRead(A3)
```

analogRead also accepts lists or tuples of pins and returns the corresponding tuple of tuples of samples:

```
import adc

x = analogRead([A4,A3,A5],6)
```

this piece of code sets ```x``` to ((…),(…),(…)) where each inner tuple contains 6 samples taken from the corresponding channel.
To used less memory, the inner tuples can be `bytes()`, or `shorts()` or normal tuples, depending on the hardware resolution of the adc unit.
The number of sequentials pins that can be read in a single analogRead call depends on the specific board.

The analogRead function is provided as a builtin to ease the passage from the Arduino Wiring to Zerynth. However the preferred way to read an analog pin in Zerynth is:

```
# import the adc driver
import adc

x = adc.read(A3)
```


---
#### `#!py3 analogWrite()`

!!!abstract "`#!py3 analogWrite(pin, period, pulse, time_unit=MILLIS, npulses=0)`"

Activate PWM (Pulse Width Modulation) on pin ```pin``` (must be one of the PWMx pins). The state of ```pin``` is periodically switched between `LOW` and `HIGH` according to parameters:


* ```period``` is the duration of a pwm square wave


* ```pulse``` is the time the pwm square wave stays in the `HIGH` state


* ```time_unit``` is the unit of time ```period``` and ```pulse``` are expressed in ```time_unit```

A PWM wave can be depicted as a train of elements like this:

```
HIGH  _________________          _________________
     |                 |        |                 |
     |                 |        |                 |
_____|                 |________|                 |____ LOW

     <-----PULSE------>
     <-----PERIOD-------------->
```

Here are some examples:

```
#Remember to import the pwm module
import pwm

# A 1000 milliseconds wave that stays HIGH for 100 milliseconds and LOW for 900
analogWrite(D5.PWM,1000,100)

# A 500 microseconds wave that stays HIGH for 10 microseconds and LOW for 490
analogWrite(D5.PWM,500,10,MICROS)

# Disable pwm
analogWrite(D5.PWM,0,0)
```

Some boards have restrictions on how pwm pins can be used, refer to the single board documentation for details.

The parameter ```npulses``` is used to specify a limited train of pulses. When ```npulses``` is zero or less, PWM is activated on
the pin and the function returns. When ```npulses``` is more than zero, analogWrite becomes blocking and returns only after a number of pulses
equal to ```npulses``` has been generated on the pin; PWM is disabled on return. For very small pulses in the range of a few ten microseconds,
the actual number of pulses produced may be greater than ```npulses``` by one or two units.

The analogWrite function is provided as a builtin to ease the passage from the Arduino Wiring to Zerynth. However the preferred way to use pwm in Zerynth is:

```
# import the pwm driver
import pwm

pwm.write(D3.PWM,400,10,MICROS)
```


---
#### `#!py3 onPinRise()`

!!!abstract "`#!py3 onPinRise(pin, fun, \*args, debounce=0, time_unit=MILLIS)`"

Executes ```fun``` with arguments `\*args` everytime ```pin``` goes from `LOW` to `HIGH`.
If ```fun``` is `None` the corresponding interrupt is disabled.
Each Zerynth VM has its own maximum number of slots for pin interrupts: if they are all full, a `RuntimeError` is raised.

Can be used together with `onPinFall()` on the same pin.

```fun``` is executed in a high priority thread that takes control of the mcu and puts to sleep every other thread.
Therefore ```fun``` should contains fast code.

```debounce``` and ```time_unit``` are used to define a timeout such that ```fun``` is called only if ```pin``` stays high for all the duration of the timeout.


---
#### `#!py3 onPinFall()`

!!!abstract "`#!py3 onPinFall(pin, fun, \*args, debounce=0, time_unit=MILLIS)`"

Executes ```fun``` with arguments `\*args` everytime ```pin``` goes from `HIGH` to `LOW`.
If ```fun``` is `None` the corresponding interrupt is disabled.
Each Zerynth VM has its own maximum number of slots for pin interrupts: if they are all full, a `RuntimeError` is raised.

Can be used together with `onPinRise()` on the same pin.

```fun``` is executed in a high priority thread that takes control of the mcu and puts to sleep every other thread. Therefore ```fun``` should contains fast code.

```debounce``` and ```time_unit``` are used to define a timeout such that ```fun``` is called only if ```pin``` stays high for all the duration of the timeout.

## Builtin Functions


---
#### `#!py3 int()`

!!!abstract "`#!py3 int(x=0, base=10)`"

Return an integer object constructed from a number or string ```x```, or return
`0` if no arguments are given.  If ```x``` is a floating point number, it is
truncated towards zero.

If ```x``` is not a number or if ```base``` is given, then ```x``` must be a string,
`bytes()`, or `bytearray()` instance representing an :integer
in radix ```base```.  Optionally, the literal can be
preceded by `+` or `-` (with no space in between) and surrounded by
whitespace.  A base-n literal consists of the digits 0 to n-1, with `a`
to `z` (or `A` to `Z`) having
values 10 to 35.  The default ```base``` is 10. The allowed values are 0 and 2-36.
Base-2, -8, and -16 literals can be optionally prefixed with `0b`/`0B`,
`0o`/`0O`, or `0x`/`0X`, as with integer literals in code.  Base 0
means to interpret exactly as a code literal, so that the actual base is 2,
8, 10, or 16, and so that `int('010', 0)` is not legal, while
`int('010')` is, as well as `int('010', 8)`.


---
#### `#!py3 type()`

!!!abstract "`#!py3 type(x)`"

Return an integer representing the type of x.
The following are the builtin constants returned by type():

```
PSMALLINT, PINTEGER, PFLOAT, PBOOL, PSTRING, PBYTES, PBYTEARRAY, PSHORTS, PSHORTARRAY, PLIST, PTUPLE, PRANGE,
PFROZENSET, PSET, PDICT, PFUNCTION, PMETHOD, PCLASS, PINSTANCE, PMODULE, PITERATOR,
PNONE, PEXCEPTION, PNATIVE, PSYSOBJ, PDRIVER, PTHREAD
```


---
#### `#!py3 thread()`

!!!abstract "`#!py3 thread(fun, \*args, prio=PRIO_NORMAL, size=-1)`"

Function ```fun``` is launched in a new thread using args as its parameters.
```fun``` must be a normal function or a methods, other callables are not supported yet.

```prio``` sets the thread priority and accepts one of `PRIO_LOWEST`, `PRIO_LOWER`, `PRIO_LOW`, `PRIO_NORMAL`, `PRIO_HIGH`, `PRIO_HIGHER`, `PRIO_HIGHEST`.
```size``` is the memory in bytes , reserved for the thread inner workings. Negative values select the VM default size.

Returns the created thread, already started. Raises 

```
:exc:`RuntimeError`
```

 if no more threads can be created.


---
#### `#!py3 sleep()`

!!!abstract "`#!py3 sleep(time, time_unit=MILLIS)`"

Suspend the current thread for ```time``` expressed in ```time_units```. All the other threads are free to continue their execution.
If ```time_unit``` is MICROS, sleep does not suspend the current thread, but starts polling the cycles counter in a loop.

For high precision sleep refer to :mod:`

```
`
```

hwtimers


---
#### `#!py3 random()`

!!!abstract "`#!py3 random()`"


---
#### `#!py3 random()`

!!!abstract "`#!py3 random(a, b)`"

Returns a random integer. If ```a``` and ```b``` are given, the random integer is contained in the range [a,b]. If the board has a builtin Random Number Generator, it is used.


---
#### `#!py3 range()`

!!!abstract "`#!py3 range(stop)`"


---
#### `#!py3 range()`

!!!abstract "`#!py3 range(start, stop, )`"

Creates a range object.


---
#### `#!py3 bytearray()`

!!!abstract "`#!py3 bytearray()`"

Return a new array of bytes. A bytearray is a mutable
sequence of integers in the range 0 <= x < 256.  It has most of the usual
methods of mutable sequences, described in typesseq-mutable, as well
as most methods that the `bytes()` type has, see Bytes and Bytearray Operations.

The optional ```source``` parameter can be used to initialize the array in a few
different ways:


* If it is a ```string```, `bytearray()` then converts the string to
bytes.


* If it is an ```integer```, the array will have that size and will be
initialized with null bytes.

Without an argument, an array of size 0 is created.


---
#### `#!py3 bytes()`

!!!abstract "`#!py3 bytes()`"

Return a new “bytes” object, which is an immutable sequence of integers in
the range `0 <= x < 256`.  `bytes()` is an immutable version of
`bytearray()` – it has the same non-mutating methods and the same
indexing and slicing behavior.

Accordingly, constructor arguments are interpreted as for `bytearray()`.


---
#### `#!py3 shortarray()`

!!!abstract "`#!py3 shortarray()`"

Return a new array of shorts. A shortarray is a mutable
sequence of integers in the range 0 <= x < 65536.  It has most of the usual
methods of mutable sequences, described in typesseq-mutable, as well
as most methods that the `shorts()` type has, see shorts-methods.

The optional ```source``` parameter can be used to initialize the array in a few
different ways:


* If it is an ```integer```, the array will have that size and will be
initialized with zeros.


* If it is a sequence, the array will be a copy of ```source``` with its elements converted into shorts.
If the conversion is not possible, an exception is raised.

Without an argument, an array of size 0 is created.


---
#### `#!py3 shorts()`

!!!abstract "`#!py3 shorts()`"

Return a new shorts object, which is an immutable sequence of integers in
the range `0 <= x < 65536`.  `shorts()` is an immutable version of
`shortarray()` – it has the same non-mutating methods and the same
indexing and slicing behavior.

Accordingly, constructor arguments are interpreted as for `shortarray()`.


---
#### `#!py3 enumerate()`

!!!abstract "`#!py3 enumerate(iterable, start=0)`"

Return an enumerate object. ```iterable``` must be a sequence, an
iterator, or some other object which supports iteration.
The `__next__()` method of the iterator returned by
`enumerate()` returns a tuple containing a count (from ```start``` which
defaults to 0) and the values obtained from iterating over ```iterable```.

It is normally used in `for` loops:

```
ints = [10,20,30]
for idx, val in enumerate(ints):
    print(idx, val)

# prints out the following:
>>> 0 10
>>> 1 20
>>> 2 30
```

In this version of the VM, enumerate works only for primitive iterable types, not yet for instances with `__next__` and `__iter__` methods.


---
#### `#!py3 reversed()`

!!!abstract "`#!py3 reversed(seq)`"

Return a reverse iterator.  ```seq``` must be an object which has
a `__reversed__()` method or supports the sequence protocol (the
`__len__()` method and the `__getitem__()` method with integer
arguments starting at `0`).

In this version of the VM, reversed works only for primitive iterable types, not yet for instances with `__next__` and `__iter__` methods.


---
#### `#!py3 ord()`

!!!abstract "`#!py3 ord(c)`"

Given a string representing one character, return an integer
representing that character.  For example, `ord('a')` returns the integer `97`.
This is the inverse of `chr()`.

When ```c``` is a literal string, the compiler macro __ORD(c) can be used to reduce code size.
For example:

```
x = ord(":")
```

is valid Zerynth code. During its execution a string must be created containing “:” and ```ord``` must be called on it.
After ```ord``` is executed the created string is probably immediately garbage collected.
In the embedded world, this is time and resource consuming.
The operation `ord(":")` can be executed during compilation because the result is known before the execution of
the Zerynth program. To enable this feature use the following code:

```
x = __ORD(":")
```

Now, no string is created and no function is called, because the compiler knows that you want to assign to `x`
the result of `ord(":")` (which is 58). The compiler transforms our program to a faster and equivalent version:

```
x = 58
```


---
#### `#!py3 chr()`

!!!abstract "`#!py3 chr(i)`"

Return the string representing a character whose byte representation is the integer
```i```.  For example, `chr(97)` returns the string `'a'`. This is the
inverse of `ord()`. 

```
:exc:`ValueError`
```

 will be raised if ```i``` is
outside the valid range.


---
#### `#!py3 isinstance()`

!!!abstract "`#!py3 isinstance(object, class)`"

Return true if the ```object``` argument is an instance of the ```class```
argument, or of a (direct, indirect) subclass thereof.  If ```object``` is not
an object of the given type, the function always returns false.  If ```class``` is not a class,
a 

```
:exc:`TypeError`
```

 exception is raised.

In this version of the VM, isinstance is still not compliant with the Python one.
It is suggested to use isinstance to determine the hierarchy of instances and to use `type()` for primitive types.


---
#### `#!py3 print()`

!!!abstract "`#!py3 print(\*args, sep=" ", end="\\n", stream=None)`"

Print ```objects``` to the stream ```stream```, separated by ```sep``` and followed
by ```end```.  ```sep```, ```end``` and ```stream```, if present, must be given as keyword
arguments.

All non-keyword arguments are converted to strings like `str()` does and
written to the stream, separated by ```sep``` and followed by ```end```.  Both ```sep```
and ```end``` must be strings. If no ```objects``` are given, `print()` will just write
```end```.

The ```stream``` argument must be an object with a `write(string)` method; if it
is not present or `None`, `__default_stream` will be used.

Whether output is buffered is usually determined by ```stream```.


---
#### `#!py3 abs()`

!!!abstract "`#!py3 abs(x)`"

Return the absolute value of a number.  The argument may be an
integer or a floating point number.


---
#### `#!py3 all()`

!!!abstract "`#!py3 all(iterable)`"

Return `True` if all elements of the ```iterable``` are true (or if the iterable
is empty).  Equivalent to:

```
def all(iterable):
    for element in iterable:
        if not element:
            return False
    return True
```


---
#### `#!py3 any()`

!!!abstract "`#!py3 any(iterable)`"

Return `True` if any element of the ```iterable``` is true.  If the iterable
is empty, return `False`.  Equivalent to:

```
def any(iterable):
    for element in iterable:
        if element:
            return True
    return False
```


---
#### `#!py3 sum()`

!!!abstract "`#!py3 sum(iterable, )`"

Sums ```start``` and the items of an ```iterable``` from left to right and returns the
total.  ```start``` defaults to `0`.


---
#### `#!py3 max()`

!!!abstract "`#!py3 max(\*args)`"

Return the largest item in args.


---
#### `#!py3 min()`

!!!abstract "`#!py3 min(\*args)`"

Return the smallest item in args.


---
#### `#!py3 len()`

!!!abstract "`#!py3 len(s)`"

Return the length (the number of items) of an object.  The argument may be a
sequence (such as a string, bytes, tuple, list, or range) or a collection
(such as a dictionary, set, or frozen set), or any instance defining the method `__len__`.


---
#### `#!py3 hex()`

!!!abstract "`#!py3 hex(x, prefix="0x")`"

Convert an integer number to a lowercase hexadecimal string
prefixed with ```prefix``` (if not given “0x” is used), for example:

```python
>>> hex(255)
'0xff'
>>> hex(-42)
'-0x2a'
```

See also `int()` for converting a hexadecimal string to an
integer using a base of 16.


---
#### `#!py3 str()`

!!!abstract "`#!py3 str(x="")`"

Return a string version of ```x```.  If ```x``` is not
provided, returns the empty string.
Returns the “informal” or nicely printable string representation of ```object```.  For string objects, this is
the string itself. For primitive types like list, tuples, dicts a standard representation is returned. For all other types, the method __str__ is called.


---
#### `#!py3 dict()`

!!!abstract "`#!py3 dict(\*args)`"

Return a new dictionary initialized from an optional 

```
*
```

args.

If no 

```
*
```

args is given, an empty dictionary is created. If a single positional argument is given and it is a mapping object, a dictionary is created with the same key-value pairs as the mapping object.
Otherwise, if more than a positional argument is given, each pair of arguments is inserted in the dictionary with the first argument of the pair being the key and the second argument the value.
If a key occurs more than once, the last value for that key becomes the corresponding value in the new dictionary.
If the number of positional arguments is odd, the value for the last key is None.


---
#### `#!py3 set()`

!!!abstract "`#!py3 set(\*args)`"

Return a new set initialized from an optional *

```
*
```

args.

If no *

```
*
```

args is given, an empty set is created. If a single positional argument is given and it is an iterable object, a set is created and filled with the values of the iterable.
Otherwise, if more than a positional argument is given, each argument is inserted in the set.

frozenset(
---
#### `#!py3 frozenset()`

!!!abstract "`#!py3 frozenset(\*args)`"

Return a new frozenset initialized from an optional *args.

If no *

```
*
```

args.

If no 

```
*
```

args is given, an empty frozenset is created. If a single positional argument is given and it is an iterable object, a frozenset is created and filled with the values of the iterable.
Otherwise, if more than a positional argument is given, each argument is inserted in the frozenset.

**
---
#### `#!py3 open()`

!!!abstract "`#!py3 open(file, mode="rb")**`"

Return an object similar to a stream with read and write methods. The object class depends on the type of file opened.

If ```file``` starts with “resource://”, open returns a ResourceStream of a flash saved resource.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTM2NTYzMTk0NiwxOTQ2OTAzODg4LDEyNj
Q1NzQxMDIsMTU4OTc3NjcyMiwtMjA1NTcxNDc5MSwtMjE1OTEy
ODkwLC0xNzg4ODIyODQyXX0=
-->