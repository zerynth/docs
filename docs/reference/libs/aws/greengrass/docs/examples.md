# Examples

The following are a list of examples for lib.aws.greengrass.

## Discover and Publish


Discover Group AWS Greengrass Core, connect and start publishing.


```main.py```

```python
# AWS Greengrass Discover and Publish
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets and client certificates
from espressif.esp32net import esp32wifi as wifi_driver

# import aws iot module
from aws.iot import iot

# import aws greengrass module
from aws.greengrass import greengrass as gg

# import helpers functions to easily load keys, certificates and thing configuration
import helpers

# THING KEY AND CERTIFICATE FILE MUST BE PLACED INSIDE PROJECT FOLDER 
new_resource('private.pem.key')
new_resource('certificate.pem.crt')
# SET THING CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('thing.conf.json')

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

pkey, clicert = helpers.load_key_cert('private.pem.key', 'certificate.pem.crt')
thing_conf = helpers.load_thing_conf()
publish_period = 1000

# discover Greengrass core info
info = gg.discover(thing_conf['endpoint'], thing_conf['thingname'], clicert, pkey)

# N.B. for this example to work it is required that single element connectivity and CA lists are retrieved by discover!
gg_endpoint = info.connectivity()[0]
print('discovered:', gg_endpoint)

# create aws iot thing instance and connect to discovered mqtt broker specifying retrieved CA certificate
thing = iot.Thing(gg_endpoint, thing_conf['mqttid'], clicert, pkey, thingname=thing_conf['thingname'], cacert=info.CA())
print('connecting to mqtt broker...')
thing.mqtt.connect()
thing.mqtt.loop()

while True:
    print('publish random sample...')
    thing.mqtt.publish("dev/sample", json.dumps({ 'asample': random(0,10) }))
    sleep(publish_period)

```
