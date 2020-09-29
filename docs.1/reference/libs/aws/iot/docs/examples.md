# Examples

The following are a list of examples for lib.aws.iot.

## Controlled Publish Period


Connect your device to AWS IoT platform and start publishing at a default period, waiting for period updates requested as changes to things' shadow.



```main.py```

```python
# AWS IoT Controlled publish period 
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets and client certificates
from espressif.esp32net import esp32wifi as wifi_driver

# import aws iot module
from aws.iot import iot

# import helpers functions to easily load keys, certificates and thing configuration
import helpers

# THING KEY AND CERTIFICATE FILE MUST BE PLACED INSIDE PROJECT FOLDER 
new_resource('private.pem.key')
new_resource('certificate.pem.crt')
# SET THING CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('thing.conf.json')

# define a callback for shadow updates
def shadow_callback(requested):
    global publish_period
    print('requested publish period:', requested['publish_period'])
    publish_period = requested['publish_period']
    return {'publish_period': publish_period}

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

pkey, clicert = helpers.load_key_cert('private.pem.key', 'certificate.pem.crt')
thing_conf = helpers.load_thing_conf()
publish_period = 1000

# create aws iot thing instance, connect to mqtt broker, set shadow update callback and start mqtt reception loop
thing = iot.Thing(thing_conf['endpoint'], thing_conf['mqttid'], clicert, pkey, thingname=thing_conf['thingname'])
print('connecting to mqtt broker...')
thing.mqtt.connect()
thing.on_shadow_request(shadow_callback)
thing.mqtt.loop()

thing.update_shadow({'publish_period': publish_period})

while True:
    print('publish random sample...')
    thing.mqtt.publish("dev/sample", json.dumps({ 'asample': random(0,10) }))
    sleep(publish_period)


```
## HWCrypto Controlled Publish Period


Connect your device to AWS IoT platform and start publishing at a default period, waiting for period updates requested as changes to things' shadow.
The connection is performed using a hardware private key stored in a ateccx08a crypto element.

To register a hardware key to AWS IoT platform the following steps are needed:

    # derive a CSR from the hardware key
    ztc provisioning uplink-config-firmware esp32_device_alias
    ztc provisioning get-csr esp32_device_alias privatekey_slot 'C=IT,O=ZER,CN=MyDevice' -o hwkey0.csr

    # get a certificate from AWS IoT and activate it
    aws iot create-certificate-from-csr --certificate-signing-request file://hwkey0.csr --certificate-pem-outfile certificate.pem.crt --set-as-active
    aws iot attach-thing-principal --thing-name my-thing --principal certificate-arn
    aws iot attach-principal-policy --policy-name my-policy --principal certificate-arn





```main.py```

```python
# AWS IoT Controlled publish period 
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets and client certificates
from espressif.esp32net import esp32wifi as wifi_driver

# import aws iot module
from aws.iot import iot

# import microchip ateccx08a module for its hw crypto element interface
from microchip.ateccx08a import ateccx08a

# import helpers functions to easily load keys, certificates and thing configuration
import helpers

# THING CERTIFICATE FILE MUST BE PLACED INSIDE PROJECT FOLDER 
new_resource('certificate.pem.crt')
# SET THING CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('thing.conf.json')

# define a callback for shadow updates
def shadow_callback(requested):
    global publish_period
    print('requested publish period:', requested['publish_period'])
    publish_period = requested['publish_period']
    return {'publish_period': publish_period}

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
# place here your wifi configuration
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

# start hardware crypto interface
ateccx08a.hwcrypto_init(I2C0, 0)

clicert = helpers.load_cert('certificate.pem.crt')
thing_conf = helpers.load_thing_conf()
publish_period = 1000

# create aws iot thing instance, connect to mqtt broker, set shadow update callback and start mqtt reception loop
# N.B. private key is passed as an empty string to use an hardware stored one
thing = iot.Thing(thing_conf['endpoint'], thing_conf['mqttid'], clicert, '', thingname=thing_conf['thingname'])
print('connecting to mqtt broker...')
thing.mqtt.connect()
thing.on_shadow_request(shadow_callback)
thing.mqtt.loop()

thing.update_shadow({'publish_period': publish_period})

while True:
    print('publish random sample...')
    thing.mqtt.publish("dev/sample", json.dumps({ 'asample': random(0,10) }))
    sleep(publish_period)


```
## Sensor to Cloud in 15 Lines


Connect your device to AWS IoT and start sending data gathered from plugged sensor in 15 lines of Python code.



```main.py```

```python
from wireless import wifi
from espressif.esp32net import esp32wifi as wifi_driver
from bosch.bme280 import bme280
from aws.iot import iot, default_credentials
wifi_driver.auto_init()
wifi.link("SSID",wifi.WIFI_WPA2,"PSW")

endpoint, mqttid, clicert, pkey = default_credentials.load()
thing = iot.Thing(endpoint, mqttid, clicert, pkey)
thing.mqtt.connect()
thing.mqtt.loop()
sensor = bme280.BME280(I2C0)
while True:
    thing.mqtt.publish("sensors", {'temp':sensor.get_temp()})
    sleep(1000)

```
## FOTA AWS


Connect your device to AWS IoT platform and start updating the firmware seamlessly.




```main.py```

```python
# AWS FOTA 
# Created at 2017-10-03 08:49:48.182639

import streams
import json
from wireless import wifi

# choose a wifi chip supporting secure sockets and client certificates
from espressif.esp32net import esp32wifi as wifi_driver

# import aws iot module
from aws.iot import iot
from aws.iot import jobs
from aws.iot import fota as awsfota

# import helpers functions to easily load keys, certificates and thing configuration
import helpers


# THING KEY AND CERTIFICATE FILE MUST BE PLACED INSIDE PROJECT FOLDER 
new_resource('private.pem.key')
new_resource('certificate.pem.crt')
# SET THING CONFIGURATION INSIDE THE FOLLOWING JSON FILE
new_resource('thing.conf.json')

# Init serial port for debug
streams.serial()

# FIRMWARE VERSION: change this to verify correct FOTA
version = 0

try:
    wifi_driver.auto_init()
    print('connecting to wifi...')
    # place here your wifi configuration
    wifi.link("SSID",wifi.WIFI_WPA2,"password")
    
    # load Thing configuration
    pkey, clicert = helpers.load_key_cert('private.pem.key', 'certificate.pem.crt')
    thing_conf = helpers.load_thing_conf()
    publish_period = 1000
    
    # create aws iot thing instance and connect to mqtt broker
    thing = iot.Thing(thing_conf['endpoint'], thing_conf['mqttid'], clicert, pkey, thingname=thing_conf['thingname'])
    
    print('connecting to mqtt broker...')
    thing.mqtt.connect()
    thing.mqtt.loop()
    
    #show current version firmware
    print("Hello, I am firmware version:",version)
    
    #create an IoT Jobs object
    myjobs = jobs.Jobs(thing)
    # check if there are FOTA jobs waiting to be performed
    # This function executes a FOTA update if possible
    # or confirms an already executed FOTA update
    awsfota.handle_fota_jobs(myjobs,force=True)
    
    
    while True:
        r = random(0,10)
        print('publish random sample...',r)
        thing.mqtt.publish("dev/sample", json.dumps({ 'asample': r }))
        sleep(publish_period)
        # check for new incoming jobs
        # again, FOTA is executed if a correct FOTA job is queued
        awsfota.handle_fota_jobs(myjobs)
        
        
except Exception as e:
    print(e)
    #reset on error!
    awsfota.reset()



```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2MTAzODU2ODFdfQ==
-->