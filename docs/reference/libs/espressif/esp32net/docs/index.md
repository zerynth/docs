# Espressif ESP32 Wifi

This module implements the wifi driver for ESP32. It includes support for softAP mode, SSL/TLS and packet sniffing.

To use the module expand on the following example:

```
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


* ESP32 Ethernet Module


* ESP32 Wifi Module
