# Examples

The following are a list of examples for lib.stm.spwf01sa

## Find and Set Baud


This example scans the serial port linked to the SPWF01SA chip finding the internal baud rate and sets the new one.


```main.py```

```python
################################################################################
# Find and Set Baud Example
#
# Created: 2018-02-08 16:44:15.135468
# Author: M. Cipriani
################################################################################

import streams
from stm.spwf01sa import spwf01sa as wifi_driver

streams.serial()
print("scanning serial bauds")

# This setup is referred to spwf01sa mounted on Wi-Fi 4 Click in slot A of a Flip n Click device 

#DEFINES
ser = SERIAL1    # serial of the spwf01sa
rst = D16        # reset pin of the spwf01sa
tobaud = 9600    # baud rate to be set
end = False

def waiting():
    while True:
        if not end:
            print(".")
        sleep(1000)

thread(waiting)

try:
    baud = wifi_driver.get_baud(ser, rst)
    print("found baud", baud)
    
    if baud != tobaud:
        wifi_driver.set_baud(ser, rst, baud, tobaud)
        print("baud set to", tobaud)
    else:
        print("baud already set to", baud)
    end = True
except Exception as e:
    print(e)

```
## Connect


This example inits and links to a network using the stm-spwf01sa library.



```main.py```

```python
import streams

from wireless import wifi
from stm.spwf01sa import spwf01sa as wifi_driver

streams.serial()

SSID = "<SSID>"
PASSWORD = "<PASSWORD>"

try:
   # Wifi 4 Click on slot B (specify which serial port will be used and which RST pin
    wifi_driver.init(SERIAL1,D16, baud=9600)
except Exception as e:
    print(e)for i in range(0,5):
    try:
        # connect to the wifi network (Set your SSID and password below)
        wifi.link(SSID , wifi.WIFI_WPA2, PASSWORD)
        print("Connect")
        break
    except Exception as e:
        print("Can't link",e)
else:
    print("Impossible to link!")
    while True:
        sleep(1000)

```
