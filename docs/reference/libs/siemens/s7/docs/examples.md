# Examples

The following are a list of examples for lib.siemens.s7

## DB write and read


Connect to an S7 server and start writing and reading from selected DB areas.



```main.py```

```python
# DB write and read
# Created at 2018-01-26 08:57:41.878149

import streams
from espressif.esp32net import esp32wifi as wifi_driver
from wireless import wifi

from siemens.s7 import s7

streams.serial()
wifi_driver.auto_init()

s7.init()

print('link')
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

print('connect to s7 server')
# N.B. ip is converted using underlying driver inet_aton, for esp32 needs third address part to contain three digits!
# e.g. 192.168.1.1 is not considered valid, while 192.168.001.1 is accepted
req, neg = s7.client.connect('192.168.106.172')
print('connected! PDU req/neg: %i/%i' % (req, neg))

buff = s7.client.readarea(s7.S7AreaDB, 1, 0, 10)
print('-'.join([str(xx) for xx in buff]))

try:
    s7.client.writearea(s7.S7AreaDB, 1, 0, bytes([1,2,3,4,5,6,7,8]))
except Exception as e:
    print(e)

buff = s7.client.readarea(s7.S7AreaDB, 1, 0, 10)
print('-'.join([str(xx) for xx in buff]))

items = ((s7.S7AreaDB, 1, 16, bytes([1,2,3,4,5,6,7,8])), (s7.S7AreaDB, 2, 16, bytes([1,2,3,4,5,6,7,8])))
s7.client.writemultivars(items)

items = ((s7.S7AreaDB, 1, 16, 10), (s7.S7AreaDB, 2, 16, 10))

bufs = s7.client.readmultivars(items)
print(len(bufs))

if len(bufs) > 1:
    for buf in bufs:
        print(len(buf))
        print('-'.join([str(xx) for xx in buf]))

```
