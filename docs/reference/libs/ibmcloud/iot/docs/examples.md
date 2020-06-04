# Examples

The following are a list of examples for lib.ibmcloud.iot

## Controlled Publish Period


Connect your device to IBM Watson IoT platform and start publishing at a default period, waiting for period updates requested through update period command.



```main.py```

```python
# IBM Cloud Watson IoT Controlled publish period 
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets
from espressif.esp32net import esp32wifi as wifi_driver

# import ibmcloud iot module
from ibmcloud.iot import iot

# import helpers functions to easily load device configuration
import helpers

# SET DEVICE CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('device.conf.json')

# define a callback for period updates
def period_callback(cmd):
    global publish_period
    print('requested publish period:', cmd['publish_period'])
    publish_period = cmd['publish_period']

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

device_conf = helpers.load_device_conf()
publish_period = 3000

# create an ibmcloud iot device instance, connect to mqtt broker, set a command callback and start mqtt reception loop
device = iot.Device(device_conf['device_id'], device_conf['device_type'], device_conf['organization'], device_conf['auth_token'])
print('connecting to mqtt broker...')
device.mqtt.connect()

device.on_cmd('update_period', period_callback)
device.mqtt.loop()

while True:
    print('publish random sample...')
    device.publish('env', { 'temp': random(0,10) })
    sleep(publish_period)

```
