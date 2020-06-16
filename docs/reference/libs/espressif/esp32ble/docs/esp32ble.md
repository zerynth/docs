# ESP32 BLE

This module implements the ESP32 ble driver for peripheral roles.
The driver is based on ESP32 IDF 3.2 and can work on Virtual Machines compiled with support for ESP32 BLE.

To use the module expand on the following example:

```py
from espressif.esp32ble import esp32ble as bledrv
from wireless import ble

bledrv.init()

ble.gap("Zerynth")
ble.start()

while True:
    sleep(1000)
    # do things here
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNjcxNjM3OTY1XX0=
-->