# ESP8266 Wifi Module

This module implements the Zerynth driver for the Espressif ESP8266 Wi-Fi chip ([Resources and Documentation](https://espressif.com/en/products/hardware/esp8266ex/resources)).

**```NOTE:**```: To avail the Wi-Fi functionalities, the end user had to follow this steps:


* inizialize the Espressif ESP8266 chip using the `init()` of this driver


* exploit the Wi-Fi features using the Wi-Fi Module of the Zerynth Standard Library


**`---
#### `#!py3 init()`

!!!abstract "`#!py3 init()`**"

initializes the Wi-Fi chip connected to the device.

Once ended this operation without errors, the Wi-Fi chip is ready to work and it can be handled using the Wi-Fi Module of the Zerynth Standard Library.

**`get_rssi()`**
---
#### `#!py3 get_rssi()`

!!!abstract "`#!py3 get_rssi()`"

Returns the current RSSI in dBm.
<!--stackedit_data:
eyJoaXN0b3J5IjpbODcwOTExNjg5LC0xNjE0NDMyMTM0XX0=
-->