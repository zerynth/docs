# SPWF01SA Module

This Zerynth module supports one tcp socket at a time (multiple sockets in future updates) in client and server mode ([datasheet](http://www.st.com/content/ccc/resource/technical/document/datasheet/ba/8c/b2/64/02/bc/4e/05/DM00102124.pdf/files/DM00102124.pdf/jcr:content/translations/en.DM00102124.pdf)).

No select support is provided.
For WIFI security, only WPA2 is currently supported.

Usage example:

```py
import streams
from wireless import wifi
from stm.spwf01sa import spwf01sa

streams.serial()

# connect to a wifi network
try:
    spwf01sa.init(SERIAL1,D16) # specify which serial port will be used and which RST pin

    print("Establishing Link...")
    wifi.link("Network SSID",wifi.WIFI_WPA2,"Password")
    print("Ok!")
except Exception as e:
    print(e)
```
