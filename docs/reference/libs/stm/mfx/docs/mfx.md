# MFX Module

## MFX class


---
#### `#!py3 MFX()`

!!!abstract "`#!py3 MFX()`"

Creates an intance of the MFX class.

Example:

```
from stm.mfx import MFX

...

port_expander = mfx.MFX()
port_expander.pinMode(10,INPUT_PULLUP)

state = port_expander.digitalRead(10)

port_expander.pinMode(0,OUTPUT)
port_expander.digitalWrite(0,HIGH)
```


---
#### `#!py3 pinMode()`

!!!abstract "`#!py3 pinMode(pin, mode)`"

Select a mode for a pin.
Valid ```pin``` values are from `0` to `15` included.
Available modes are:


* `INPUT`


* `INPUT_PULLUP`


* `INPUT_PULLDOWN`


* `OUTPUT`


---
#### `#!py3 digitalRead()`

!!!abstract "`#!py3 digitalRead(pin)`"

Returns the state of pin ```pin```. The state can be `0` or `1`.


---
#### `#!py3 digitalWrite()`

!!!abstract "`#!py3 digitalWrite(pin, val)`"

Set pin ```pin``` to value ```val```. Value can be `0` or `1`.


---
#### `#!py3 pinToggle()`

!!!abstract "`#!py3 pinToggle(pin)`"

Toggle the value of the pin ```pin```.
