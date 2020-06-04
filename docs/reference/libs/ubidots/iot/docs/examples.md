# Examples

The following are a list of examples for lib.ubidots.iot

## Controlled Publish Period


Connect your device to Ubidots IoT platform and start publishing at a default period, waiting for period updates requested as changes to period variable.



```main.py```

```python
# Ubidots Controlled publish period 
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets
from espressif.esp32net import esp32wifi as wifi_driver

# import ubidots iot module
from ubidots.iot import iot

# import helpers functions to easily device configuration
import helpers

# SET DEVICE CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('device.conf.json')

# define a callback for period updates
def period_callback(value):
    global publish_period
    print('requested publish period:', int(value))
    publish_period = int(value)

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

device_conf = helpers.load_device_conf()
publish_period = 3000

# create ubidots iot device instance, connect to mqtt broker, set variable update callback and start mqtt reception loop
device = iot.Device(device_conf['device_label'], device_conf['user_type'], device_conf['api_token'])
print('connecting to mqtt broker...')
device.mqtt.connect()

device.on_variable_update(device_conf['device_label'], 'publish_period', period_callback, json=False)
device.mqtt.loop()

while True:
    print('publish random sample...')
    device.publish({ 'value': random(0,10) }, variable='temperature')
    sleep(publish_period)


```
