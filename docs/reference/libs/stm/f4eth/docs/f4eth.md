# STM32F4 Native Ethernet Module

This module implements the Zerynth driver for the STM32 F4 family Ethernet.
This module supports SSL/TLS

To use it:

```py
import streams
from stm.f4eth import f4eth as eth

streams.serial()

print("...")

eth.auto_init()
eth.link()
print(eth.link_info())
```

**`init()`**

Initializes the Ethernet chip connected to the device.

The Ethernet chip is setup and can be managed using the Ethernet Module of the Zerynth Standard Library.
