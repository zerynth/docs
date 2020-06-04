# Examples

The following are a list of examples for lib.xinabox.su02

## Read Input State


This example reads the input state of a switch connected to the terminals on SU02. Screw one end of the switch in a terminal and the other end in the remaining terminal. Flip the switch on and off to see the input change. No external power is required.



```main.py```

```python
###############################################
#   This is an example for the SU02 digital
#   input.
#
#   The state is read and displayed over the
#   serial console.
###############################################

import streams
from xinabox.su02 import su02

streams.serial()

# SU02 instance
SU02 = su02.SU02(I2C0)

# configure SU02
SU02.init()

while True:
    state = SU02.getState()		# read the state at the input
    print(state)
    sleep(1000)
```
