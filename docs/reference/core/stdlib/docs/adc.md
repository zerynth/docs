# Analog to Digital Conversion

This module loads the Analog to Digital Converter (adc) driver of the embedded device.

When imported, automatically sets the system adc driver to  the default one.


---
#### `#!py3 init()`

!!!abstract "`#!py3 init(drvname, samples_per_second=800000)`"

Loads the adc driver identified by ```drvname``` and sets it up to read ```samples_per_second``` samples per second. The default is a sampling frequency of 0.8 MHz,
valid values are dependent on the board.

Returns the previous driver without disabling it.


---
#### `#!py3 done()`

!!!abstract "`#!py3 done(drvname)`"

Unloads the adc driver identified by ```drvname```.


---
#### `#!py3 read()`

!!!abstract "`#!py3 read(pin, samples=1)`"

Reads analog values from ```pin``` that must be one of the Ax pins. If ```samples``` is 1 or not given, returns the integer value read from ```pin```.
If ```samples``` is greater than 1, returns a tuple of integers of size ```samples```.
The maximum value returned by analogRead depends on the analog resolution of the board.

```read``` also accepts lists or tuples of pins and returns the corresponding tuple of tuples of samples:

```
import adc

x = adc.read([A4,A3,A5],6)
```

this piece of code sets ```x``` to ((…),(…),(…)) where each inner tuple contains 6 samples taken from the corresponding channel.
To use less memory, the inner tuples can be `bytes()`, or `shorts()` or normal tuples, depending on the hardware resolution of the adc unit.
The number of sequentials pins that can be read in a single call depends on the specific board.
