<!-- _digitalSensor -->
<!-- module: digitalSensor -->
# Digital Sensor Library

This module contains class definitions for digital sensors. DigitalSensor class is a subclass of the generic Sensor class and provides a simple way to handle sensors sensing quantities that can assume only two different values.

Every DigitalSensor instance inherits the whole set of methods from generic Sensor class and it also implements the following methods:


* onSequence: see method [onSequence](https://docs.zerynth.com/latest/official/lib.zerynth.smartsensors/docs/official_lib.zerynth.smartsensors_digitalSensors.html#onsequence)
* onRiseAndFall: see method [onRiseAndFall](https://docs.zerynth.com/latest/official/lib.zerynth.smartsensors/docs/official_lib.zerynth.smartsensors_digitalSensors.html#onriseandfall)
* onFallAndRise: see method [onFallAndRise](https://docs.zerynth.com/latest/official/lib.zerynth.smartsensors/docs/official_lib.zerynth.smartsensors_digitalSensors.html#onfallandrise)
* onRise: alias for onPinRise on the instance pin
* onFall: alias for onPinFall on the instance pin

An instance of a digitalSensor can be used both in interrupt mode and sampling mode.

## DigitalSensor class


**`class DigitalSensor(pin)`**

This is the class for handling digital sensors and any other boolean input connected to digital pins.


**`onSequence(first, times, to_dos, long_fn)`**

Sets functions to be executed in a sequence of pin values changes respecting precise time constraints.


* first: is the value of the pin from which the method waits for the first change
* times: is a list of min and max times of persistence in a precise state before changing it to opposite one
* to_dos: is a list of functions to be executed at every step of the sequence
* long_fn: is a function to be executed if the first max time constraint is exceeded

Example:

```py
def hello():
    print("hello")
def world():
    print("world")
def longworld():
    print("longworld")

mySensor.onSequence(0,[[15,30],[15,30]],[hello,world],longworld)
```

Assuming to start from a 0 value on the pin, when the value changes to 1, a timer starts to check the
persistance in this state. When the value returns to 0, if the time passed in a HIGH state is:


* less than 15 milliseconds the sequence restarts
* more than 30 milliseconds *longworld* function is called and then the sequence restarts
* between 15 and 30 milliseconds the function *hello* is executed and the sequence goes on.
For the second step the same assumptions are valid: if the time constraints are respected *world* function is called, otherwise the sequence restarts ( long_fn is called only if the first max bound is not respected ). To be noticed that the second step analyze the persistance at **LOW** level in this case.


**`onRiseAndFall(min_time, max_time, to_do, long_fn = None)`**

Sets *to_do* as the function to be executed when the value of the pin changes from 0 to 1 ( onRise ) and again from 1 to 0 ( andFall ).
The value must stay HIGH at least *min_time* (make sure the transition is voluntary, not due to noise) and less than *max_time*.

There is the possibility to also set a *long_fn* which is executed is the *max_time* bound is overcome.


* min_time: the minimum duration of the signal to be considered as a real event
* max_time: the maximum duration of the signal that if passed will trigger a “long” event
* to_do: the function called if the signal state change is between min and max time
* long_fn: the function called if the signal state change is longer than max time


### onFallAndRise(min_time, max_time, to_do, long_fn = None)
Sets *to_do* as the function to be executed when the value of the pin changes from 1 to 0 ( onFall ) and again from 0 to 1 ( andRise ).
The value must stay LOW at least *min_time* (make sure the transition is voluntary, not due to noise) and less than *max_time*.

There is the possibility to also set a *long_fn* which is executed if the *max_time* bound is overcome.


* min_time: the minimum duration of the signal to be considered as a real event
* max_time: the maximum duration of the signal that if passed will trigger a “long” event
* to_do: the function called if the signal state change is between min and max time
* long_fn: the function called if the signal state change is longer than max time
