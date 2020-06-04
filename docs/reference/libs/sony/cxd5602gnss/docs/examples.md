# Examples

The following are a list of examples for lib.sony.cxd5602gnss

## GNSS Data example


Initializes the Sony CXD5602 GNSS and retrieves GNSS data.



```main.py```

```python
################################################################################
# GNSS Data
#
# Created by Zerynth Team 2019 CC
# Author: L. Rizzello
###############################################################################

import gc
import streams
from sony.cxd5602gnss import gnss

# dictionary to convert from satellite type to string
sattype2string = {
    gnss.SAT_GPS: "GPS",
    gnss.SAT_GLONASS: "GLONASS",
    gnss.SAT_SBAS: "SBAS",
    gnss.SAT_QZ_L1CA: "QZ_L1CA",
    gnss.SAT_IMES: "IMES",
    gnss.SAT_QZ_L1S: "QZ_L1S",
    gnss.SAT_BEIDOU: "BEIDOU",
    gnss.SAT_GALILEO: "GALILEO"
}

streams.serial()

print("> GNSS init")
gnss.init()
while True:
    gnss.wait()
    # filter data to keep only position, datetime and satellites' info
    data = gnss.read(read_filter=(gnss.FILTER_RECEIVER_POSITION | gnss.FILTER_RECEIVER_DATETIME | gnss.FILTER_SATS_DATA))

    if data.receiver.position.pos_dataexist:
        print("> POSITION:")

        print(">> latitude:", data.receiver.position.latitude)
        print(">> longitude:", data.receiver.position.longitude)
        print(">> altitude:", data.receiver.position.altitude)
    else:
        print("> POSITION not available")

    print("> DATETIME:")

    print(">> date.year:", data.receiver.datetime.date.year)
    print(">> date.month:", data.receiver.datetime.date.month)
    print(">> date.day:", data.receiver.datetime.date.day)

    print(">> time.hour:", data.receiver.datetime.time.hour)
    print(">> time.minute:", data.receiver.datetime.time.minute)
    print(">> time.sec:", data.receiver.datetime.time.sec)
    print(">> time.usec:", data.receiver.datetime.time.usec)

    if data.sats:
        # at least one satellite available
        print("> SATS:")

        for sat_i, sat in enumerate(data.sats):
            print(">> sat[%i].type:" % sat_i, sattype2string[sat.type])
            print(">> sat[%i].siglevel:" % sat_i, sat.siglevel)


```
