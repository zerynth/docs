# Examples

The following are a list of examples for lib.googlecloud.iot.

## Controlled Publish Period


Connect your device to Google Cloud IoT Core and start publishing at a default period, waiting for period updates requested as changes to device config.



```main.py```

```python
# Google Cloud IoT Controlled publish period
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets
from espressif.esp32net import esp32wifi as wifi_driver

import requests
# import google cloud iot module
from googlecloud.iot import iot

# import helpers functions to easily load keys and device configuration
import helpers

# DEVICE KEY FILE MUST BE PLACED INSIDE PROJECT FOLDER
new_resource('private.hex.key')
# set device configuration inside this json file
new_resource('device.conf.json')

# define a callback for config updates
def config_callback(config):
    global publish_period
    print('requested publish period:', config['publish_period'])
    publish_period = config['publish_period']
    return {'publish_period': publish_period}

streams.serial()
wifi_driver.auto_init()

# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

pkey = helpers.load_key('private.hex.key')
device_conf = helpers.load_device_conf()
publish_period = 5000

# choose an appropriate way to get a valid timestamp (may be available through hardware RTC)
def get_timestamp():
    user_agent = {"user-agent": "curl/7.56.0"}
    return json.loads(requests.get("http://now.zerynth.com/", headers=user_agent).content)['now']['epoch']

# create a google cloud device instance, connect to mqtt broker, set config callback and start mqtt reception loop
device = iot.Device(device_conf['project_id'], device_conf['cloud_region'], device_conf['registry_id'], device_conf['device_id'], pkey, get_timestamp)
device.mqtt.connect()

device.on_config(config_callback)
device.mqtt.loop()

while True:
    print('publish random sample...')
    device.publish_event(json.dumps({ 'asample': random(0,10) }))
    sleep(publish_period)


```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4MzYyNTI0MjRdfQ==
-->