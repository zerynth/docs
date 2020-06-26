# Input Capture Unit

This module loads the Input Capture (icu) driver of the embedded device.

An Input Capture unit is a mcu peripheral that is able to read a digital signal on a pin and measure times
between `HIGH` and `LOW` transition.

Imagine to have this signal on a digital pin:

```
HIGH  _______            ________________     _________
     |       |          |                |   |         |
     |       |          |                |   |         |
_____|       |__________|                |___|         |____  LOW

     <------><----------><---------------><-><--------->
        T0        T1             T2        T3     T4
```

Often it is very useful to know T0,T1, etc.. with a very good precision (such as in IR decoder).
Writing a program that listens for transitions from `HIGH` to `LOW` or viceversa and saves the time passed in between can surely be done,
but a modern mcu is usually equipped with a piece of hardware (being it a timer or a dedicated input capture unit) that can
obtain the same result with almost no code and a staggering precision (in the order of sub-microseconds).

The icu module is a general interface with such mcu hardware.


`init(drvname)`

Loads the icu driver identified by ```drvname```

Returns the previous driver without disabling it.

`capture(pin, trigger, max_samples, time_window=1000, time_unit=MILLIS, pull=LOW, bits=-1)`

Activates the Input Capture Unit on ```pin``` and starts capturing the signal with the following constraints:


* waits until the signal on ```pin``` is equal to ```trigger```. If trigger is `LOW` the capture starts when a transition `HIGH` to `LOW` is detected. Otherwise the capture starts when a transition `LOW` to `HIGH` is detected. Synonyms for `LOW` transition are `HIGH_TO_LOW` or `FALLING_EDGE`. Synonyms for `HIGH` are `LOW_TO_HIGH` or `RISING_EDGE`. It is possible to select a trigger on any edge with `BOTH_EDGES`.


* once the capture is started, the input capture units starts saving times at each transition.


* the capture ends if ```max_samples``` are captured or if ```time_window``` expires, whichever condition verifies first.


* ```pin``` is set to INPUT_PULLDOWN if ```pull``` is LOW else is set to INPUT_PULLUP

This function is blocking and returns a tuple of times expressed in microseconds as soon as the capture ends.
The type of the returned value can be changed by setting ```bits``` to a non negative value.
If ```bits``` is 0, a tuple is returned, the first item being the times, the second item being the digital value
of ```pin``` during the first captured time. If ```bits``` is 1, the result is a tuple, the first item being the times, the second
item being a tuple of zeros and ones representing the digital value of ```pin``` during each captured time. Non negative values for ```bits``` other than 0 and 1 are reserved and will be used in future
enhancements of the function.

Imagine to have this signal on ```pin```:

```
HIGH    _______            ________________     _________
       |       |          |                |   |         |
       |       |          |                |   |         |
_______|       |__________|                |___|         |____  LOW (forever)

       ^       ^          ^                ^   ^         ^
edges  0       1          2                3   4         5

       <------><----------><---------------><-><--------->
   ms      7          10           16        3      9
```

Here are some examples:

```
import icu

# Case 1:
x = icu.capture(D3.ICU,HIGH,10,50)

# trigger is set to HIGH, so capture starts at edge 0
# x is (7000,10000,16000,3000,9000) --> result in microseconds

# Case 2:
x = icu.capture(D3.ICU,HIGH_TO_LOW,10,50)

# trigger is set to HIGH_TO_LOW, so capture starts at edge 1
# x is (10000,16000,3000,9000) --> result in microseconds


# Case 3:
x = icu.capture(D3.ICU,RISING_EDGE,10,18)

# trigger is set to RISING_EDGE, so capture starts at edge 0
# x is (7000,10000) --> time_window is 18 so after the first 18 ms,
#                       the capture ends

# Case 4:
x,y = icu.capture(D3.ICU,BOTH_EDGES,10,18,bits=1)

# trigger is set to BOTH_EDGES, so capture starts at first available edge, edge 0
# x is (7000,10000) --> time_window is 18 so after the first 18 ms,
#                       the capture ends
# y is (1,0)        --> first captured time (7000) was HIGH, second captured time (10000) was LOW
```

Some boards have restrictions on how icu pins can be used, refer to the single board documentation for details.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTczOTA3NTY3NV19
-->