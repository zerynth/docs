# Espressif ESP32 Wifi

This module implements the wifi driver for ESP32. It includes support for softAP mode, SSL/TLS and packet sniffing.

To use the module expand on the following example:

```python
from espressif.esp32wifi import esp32wifi as wifi_driver
from wireless import wifi

wifi_driver.auto_init()
for retry in range(10):
    try:
        wifi.link("Network-SSID", wifi.WIFI_WPA2, "password")
        break
    except Exception as e:
        print(e)

if not wifi.is_linked():
    raise IOError
```

Here below, the Zerynth driver for the Espressif ESP32 and some examples to better understand how to use it.

Contents:

 -   [ESP32 Ethernet Module](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/docs/official_lib.espressif.esp32net_esp32eth.html)
 -   [ESP32 Wifi Module](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/docs/official_lib.espressif.esp32net_esp32wifi.html)
 -   [Examples](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/examples/examples.html)
     -   [Wifi](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/examples/examples.html#wifi)
     -   [SoftAP](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/examples/examples.html#softap)
     -   [Sniffer](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/examples/examples.html#sniffer)
     -   [Advanced Sniffer](https://docs.zerynth.com/latest/official/lib.espressif.esp32net/examples/examples.html#advanced-sniffer)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NjMzMjI4MzhdfQ==
-->
