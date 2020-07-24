# Examples

The following are a list of examples for lib.zerynth.lwmqtt.

## LWMQTT at mosquitto.org


This simple example shows how to connect to an mqtt broker using Zerynth lwmqtt module and start publishing and receiving messages.



```main.py```

```python
import streams
import json

from microchip.winc1500 import winc1500 as wifi_driver
# from espressif.esp32net import esp32wifi as wifi_driver

from wireless import wifi
from lwmqtt import mqtt

def hello_samples(client, payload):
    print('> received: ', payload)

def connection_subscribe(client):
    # subscribe after connection to that even after re-connection subscription are renewed
    client.subscribe("zerynth/samples", hello_samples)

def loop_failure(client):
    # called when packet handle loop fails
    # the user can implement reconnection logic (e.g. exponential backoff) here
    while True:
        try:
            print("> reconnecting...")
            client.reconnect()
            break
        except Exception as e:
            print(e)
        sleep(1000)
    return mqtt.RECOVERED

streams.serial()

wifi_driver.auto_init(ext=1)

print('> wifi link')
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")
print('> linked')

client = mqtt.Client("zerynth-mqtt")
# connect to "test.mosquitto.org"
for retry in range(10):
    try:
        print("connect")
        client.connect("test.mosquitto.org", 60, aconnect_cb=connection_subscribe, loop_failure=loop_failure)
        break
    except Exception as e:
        print("connecting...")
else:
    print("> connection failed!")
    raise IOError
print("> connected.")
# subscribe to channels
client.subscribe("zerynth/samples", hello_samples)

while True:
    if client.connected():
        print("> publish.")
        client.publish("zerynth/samples", json.dumps({'rand': random(0,10)}))
    sleep(1000)

```
