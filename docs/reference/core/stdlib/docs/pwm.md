# Pulse Width Modulation

This module loads the Pulse Width Modulation (pwm) driver of the embedded device.

When imported, automatically sets the system pwm driver to the default one.


**`init(drvname)`**

Loads the pwm driver identified by ```drvname```

Returns the previous driver without disabling it.


**`write(pin, period, pulse, time_unit=MILLIS, npulses=0)`**

Activate PWM (Pulse Width Modulation) on pin ```pin``` (must be one of the PWMx pins, expressed as Dx.PWM). The state of ```pin``` is periodically switched between `LOW` and `HIGH` according to parameters:


* ```period``` is the duration of a pwm square wave


* ```pulse``` is the time the pwm square wave stays in the `HIGH` state


* ```time_unit``` is the unit of time ```period``` and ```pulse``` are expressed in

A PWM wave can be depicted as a train of elements made like this:

```
HIGH  _________________          _________________
     |                 |        |                 |
     |                 |        |                 |
_____|                 |________|                 |____ LOW

     <-----PULSE------>
     <-----PERIOD-------------->
```

Here are some examples:

```py
#Remember to import the pwm module
import pwm

# A 1000 milliseconds wave that stays HIGH for 100 milliseconds and LOW for 900
pwm.write(D5.PWM,1000,100)

# A 500 microseconds wave that stays HIGH for 10 microseconds and LOW for 490
pwm.write(D5.PWM,500,10,MICROS)

# Disable pwm
pwm.write(D5.PWM,0,0)
```

Some boards have restrictions on how pwm pins can be used, refer to the single board documentation for details.

The parameter ```npulses``` is used to specify a limited train of pulses. When ```npulses``` is zero or less, PWM is activated on
the pin and the function returns. When ```npulses``` is more than zero, pwm.write becomes blocking and returns only after a number of pulses
equal to ```npulses``` has been generated on the pin; PWM is disabled on return. For very small pulses in the range of a few ten microseconds,
the actual number of pulses produced may be greater than ```npulses``` by one or two units.

An example:

```py
#Remember to import the pwm module
import pwm

# A 1000 milliseconds wave that stays HIGH for 100 milliseconds and LOW for 900
# pwm.write returns after 5 pulses (i.e. after 4100 milliseconds)
pwm.write(D5.PWM,1000,100,npulses=5)
```

Available time units are: NANOS, MICROS, MILLIS, SECONDS. The precision, or even the correcteness, of a pwm period/pulse configuration
when expressed in nanoseconds may greatly vary between microcontrollers. Indeed it depends on the clock of the peripheral implementing
the pwm signal. For example, an MCU running at 100 MHz can, in teory, generate a pwm signal as precise as 10 ns.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMDk0MzYxNTgsMjE0MTU2ODgwMl19
-->