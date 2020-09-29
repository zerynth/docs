# Examples

The following are a list of examples for lib.microchip.rn2483.

## EUI


Get EUI from RN2483 for registration to LoRaWAN server.



```main.py```

```python
import streams
from microchip.rn2483 import rn2483

streams.serial()

# get deveui specifying serial connection used for device-to-module communication
# and module reset pin
print("DEVEUI: ", rn2483.get_hweui(SERIAL1, D16))

```
## LoRa Ping


Basic example of LoRa usage with RN2483.



```main.py```

```python
import streams
from microchip.rn2483 import rn2483

streams.serial()

rst = D16
# insert otaa credentials!!
appeui = "" 
appkey = ""
print("joining...")

if not rn2483.init(SERIAL1, appeui, appkey, rst):
    print("denied :(")
    raise Exception

print("sending first message, res:")
print(rn2483.tx_uncnf('TTN'))

while True:
    print("ping, res:")
    print(rn2483.tx_uncnf("."))
    sleep(5000)
```
## Custom EUI


Join a LoRaWAN network using the over-the-air activation with a custom EUI.



```main.py```

```python
import streams
from microchip.rn2483 import rn2483

streams.serial()

print("init rn2483 module")
rn2483.init(SERIAL2, None, None, D4, join_lora=False)

# insert otaa credentials!!
appeui = ''
appkey = ''
deveui = ''

print("config rn2483 module")
rn2483.config(appeui, appkey, deveui)

print("join LoRaWAN network:")
i = 1
while True:
    try:
        print("attempt",i,"...")
        if rn2483.join():
            print("...succeded!")
            break
        else:
            print("...failed :(")
    except Exception as e:
        print(e)
    i += 1
    sleep(5000)

while True:
    try:
        print("sending ping, res:")
        print(rn2483.tx_uncnf("."))
    except rn2483Exception as e:
        print(e)
    sleep(5000) 

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIxMzc3NTc1N119
-->