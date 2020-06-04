# Servo Library

This module contains class definitions for servo motors.

The Servo class provides methods for handling generic servo motors connected to PWM enabled pins. It also provides easily accessible attributes for the control of motor positions with pulse width or angle inputs.

Every Servo instance implements the following methods:


* attach: connects the servo motor and sets the default position


* detach: sets the PWM pulse width of the instanced servo to 0 thus disconnecting the motor


* moveToDegree: sets the servo position to the desired angle passed as float


* moveToPulseWidth: sets the servo position to the desired raw value expressed as pulse width (int) microseconds


* getCurrentPulseWidth: returns the current servo position in pulse width (int) microseconds


* getCurrentDegree: returns the current position in degrees

## Servo class


---
#### `#!py3 Servo()`

!!!abstract "`#!py3 Servo(pin, min_width=500, max_width=2500, default_width=1500, period=20000)`"

Creates a Servo instance:


* ```pin```: it is the pin where the servo motor signal wire is connected. The pin requires PWM functionality and its name has to be passed using the DX.PWM notation


* ```min_width```: it is the min value of the control PWM pulse width (microseconds). It has to be tuned according to servo capabilities. Defaults is set to 500.


* ```max_width```: it is the max value of the control PWM pulse width (microseconds). It has to be tuned according to servo capabilities. Defaults is set to 2500.


* ```default_width```: it is the position where the servo motor is moved when attached. It is expressed in microseconds and the default is set to 1500 corresponding to 90 degrees if the min-max range is set as default.


* ```period```: it is the period of the PWM used for controlling the servo expressed in microseconds. Default is 20000 microseconds that is the most used standard.

After initialization the servo motor object is created and the controlling PWM set to 0 leaving the servo digitally disconnected


---
#### `#!py3 attach()`

!!!abstract "`#!py3 attach()`"

Writes ```default_width``` to the servo associated PWM, enabling the motor and moving it to the default position.


---
#### `#!py3 detach()`

!!!abstract "`#!py3 detach()`"

Writes 0 to the servo associated PWM disabling the motor.


---
#### `#!py3 moveToDegree()`

!!!abstract "`#!py3 moveToDegree(degree)`"

Moves the servo motor to the desired position expressed in degrees (float).


---
#### `#!py3 moveToPulseWidth()`

!!!abstract "`#!py3 moveToPulseWidth(width)`"

Moves the servo motor to the desired position expressed as pulse width (int) microseconds. The input has to be in min_width:max_width range.


---
#### `#!py3 getCurrentPulseWidth()`

!!!abstract "`#!py3 getCurrentPulseWidth()`"

Returns the servo motor position as pulse width (microseconds).


---
#### `#!py3 getCurrentDegree()`

!!!abstract "`#!py3 getCurrentDegree()`"

Returns the servo motor position as degrees.
