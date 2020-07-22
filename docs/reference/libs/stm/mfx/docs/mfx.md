# MFX Module

## MFX class

##### class MFX

```#!py3 class MFX()```

Creates an intance of the MFX class.

Example:

```py
from stm.mfx import MFX

...

port_expander = mfx.MFX()
port_expander.pinMode(10,INPUT_PULLUP)

state = port_expander.digitalRead(10)

port_expander.pinMode(0,OUTPUT)
port_expander.digitalWrite(0,HIGH)
```

###### MFX.pinMode

```#!py3 pinMode(pin, mode)```

Select a mode for a pin. Valid *pin* values are from `0` to `15` included. Available modes are:


* `INPUT`
* `INPUT_PULLUP`
* `INPUT_PULLDOWN`
* `OUTPUT`

###### MFX.digitalRead

```#!py3 digitalRead(pin)```

Returns the state of pin *pin*. The state can be `0` or `1`.

###### MFX.digitalWrite

```#!py3 digitalWrite(pin, val)```

Set pin *pin* to value *val*. Value can be `0` or `1`.

###### MFX.pinToggle

```#!py3 pinToggle(pin)```

Toggle the value of the pin ```pin```.
