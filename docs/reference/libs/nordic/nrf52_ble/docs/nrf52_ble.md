# NRF52 BLE


This module implements the NRF52 ble driver for peripheral roles. It can be used for every kind of board based on [NRF52832](https://www.nordicsemi.com/eng/Products/Bluetooth-low-energy/nRF52832) and [`NRF52840 <>`_](https://docs.zerynth.com/latest/official/lib.nordic.nrf52_ble/docs/official_lib.nordic.nrf52_ble_nrf52_ble.html#id1) ; it has been tested on [RedBear boards](https://www.kickstarter.com/projects/redbearinc/bluetooth-5-ready-ble-module-nano-2-and-blend-2) and Nordic development kits (PCA10040 and PCA10056).

The driver is based on NRF52 SDK and can function on Virtual Machines compiled with support for Nordic SoftDevices (S132 and S140).

To use the module expand on the following example:

```py
from nordic.nrf52_ble import nrf52_ble as bledrv
from wireless import ble

bledrv.init()

ble.gap("Zerynth")
ble.start()

while True:
    sleep(1000)
    # do things here
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk2Mjk3NTA3MF19
-->