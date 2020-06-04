# Examples

The following are a list of examples for lib.zerynth.mqtt

## MQTT at mosquitto.org


This simple example shows how to connect to an mqtt broker using Zerynth mqtt module
and how to start publishing data on a channel and receiving data 
from other sources publishing on different ones.


```main.py```

```python
################################################################################
# MQTT at mosquitto.org
#
# Created: 2015-10-15 21:37:25.886276
#
################################################################################

import streams
from mqtt import mqtt
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the device hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment one of the following lines depending on used board 
# (e.g. Particle Photon, esp8266 based board, esp32 based board)

# from broadcom.bcm43362 import bcm43362 as wifi_driver
# from espressif.esp32net import esp32wifi as wifi_driver
# from espressif.esp8266wifi import esp8266wifi as wifi_driver

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected device
wifi_driver.auto_init()


streams.serial()


# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# define MQTT callbacks
def is_sample(data):
    if ('message' in data):
        return (data['message'].qos == 1 and data['message'].topic == "desktop/samples")
    return False

def print_sample(client,data):
    message = data['message']
    print("sample received: ", message.payload)

def print_other(client,data):
    message = data['message']
    print("topic: ", message.topic)
    print("payload received: ", message.payload)

def send_sample(obj):
    print("publishing: ", obj)
    client.publish("temp/random", str(obj))

def publish_to_self():
    client.publish("desktop/samples","hello! "+str(random(0,10)))


try:
    # set the mqtt id to "zerynth-mqtt"
    client = mqtt.Client("zerynth-mqtt",True)
    # and try to connect to "test.mosquitto.org"
    for retry in range(10):
        try:
            client.connect("test.mosquitto.org", 60)
            break
        except Exception as e:
            print("connecting...")
    print("connected.")
    # subscribe to channels
    client.subscribe([["desktop/samples",1]])
    client.subscribe([["desktop/others",2]])
    # configure callbacks for "PUBLISH" message
    client.on(mqtt.PUBLISH,print_sample,is_sample)
    # start the mqtt loop
    client.loop(print_other)
    # Every 3 seconds, send a random number to "temp/random"
    # you can check temp/random changing here: http://test.mosquitto.org/gauge/

    while True:
        sleep(3000)
        x = random(0,50)
        send_sample(x)
        # when x ends with 0, publish a message to desktop/samples
        # it is echoed back
        if x%10==0:
            publish_to_self()
except Exception as e:
    print(e)

```
