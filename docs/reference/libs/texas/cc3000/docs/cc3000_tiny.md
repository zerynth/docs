# CC3000 Tiny

This module implements the cc3000 wifi driver with stripped down functionalities for low resource devices. The following funtionalities are missing:


* wifi network scanning


* ping


* smart_config

Refer to `cc3000` for usage info


---
#### `#!py3 auto_init()`

!!!abstract "`#!py3 auto_init()`"

Tries to automatically init the CC3000 driver by looking at the device type.
The automatic configuration is possible for all the Arduino compatible devices
and for the Particle Core.

Otherwise an exception is raised


---
#### `#!py3 init()`

!!!abstract "`#!py3 init(spi, nss, wen, irq)`"

Tries to init the CC3000 driver. ```spi``` is the name of the spi driver the CC3000 is connected to.
```nss``` is the pin used as Chip Select (CS). ```wen``` is the pin used as Wireless Enable. ```irq``` is the pin used by
the CC3000 to generate an interrupt.
