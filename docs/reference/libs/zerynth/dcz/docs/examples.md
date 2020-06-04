# Examples

The following are a list of examples for lib.zerynth.dcz

## DCZ


An example illustrating the usage of device configuration zones



```main.py```

```python
################################################################################
# Device Configuration Zones
#
# Created by Zerynth Team 2015 CC
# Authors: D. Mazzei, G. Baldi,
###############################################################################

import streams
import json
# import the DCZ module
from dcz import dcz

streams.serial()

try:

    # this example can run on an ESP32 device without modification
    # otherwise change the addresses both in mapping and in dcz.yml

    # there will be 2 DCZs at the following addresses
    mapping =  [0x310000,0x311000]
    # let's create a DCZ instance that knows how to serialize and deserialize json
    dc = dcz.DCZ(mapping, serializers={"json":json})
    # before using it, DCZ instance must be init'ed
    dc.init()
    # if it is the first time the device runs, let's call finalize to encrypt resources if needed
    dc.finalize()

    # ok, print out the status
    dc.dump(entries=True)

    # get the list of resource names
    resources = dc.resources()

    # load them all and print their values
    for name in resources:
        print("Resource",name)
        resource = dc.load_resource(name,check=True)  # the result is a Python object!
        binary_resource = dc.load_resource(name,check=True,deserialize=False)
        binary_resource_encrypted = dc.load_resource(name,check=True,deserialize=False,decrypt=False)
        print("Deserialized:",resource)
        print("Binary:      ","".join([hex(x,"") for x in binary_resource]))
        print("Encrypted:   ","".join([hex(x,"") for x in binary_resource_encrypted]))

    # get the next version
    next_version = dc.next_version()
    # now update a resource
    print("=======================")
    print("Updating DCZ to version",next_version)
    print("=======================")

    if "test" not in resource:
      resource["test"]=0
    resource["test"]=resource["test"]+1

    print("Saving ",name)
    dc.save_resource(name,resource,format="json",version=next_version)

    print("Yes! Reset the device and see the DCZ get updated again and again...")
    while(True):
        sleep(1000)

except Exception as e:
    print(e)

```
## DCZ for AWS


Simple automatic provisioning of AWS things managed with a DCZ.
For the esample to work, a properly configured AWS Account must be present:

* IAM credentials of a user with access to IoT Core
* an IoT Policy to enable device connection and publishing


```
# example device policy
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:Connect",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iot:Publish",
      "Resource": "arn:aws:iot:<your-aws-region>:<your-aws-account-number>:topic/dev/sample"
    }
  ]
}

```



```main.py```

```python
################################################################################
# Device Configuration Zones
#
# Created by Zerynth Team 2019 CC
# Authors: D. Mazzei, G. Baldi,
###############################################################################

import streams
import json
# import the DCZ module
from dcz import dcz
# import aws iot module
from aws.iot import iot
# wifi driver
from wireless import wifi
from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

try:

    # this example can run on an ESP32 device without modification
    # otherwise change the addresses both in mapping and in dcz.yml
    # !!AWS Credentials must also be specified in the dcz.yml for the example to work!!

    # there will be 2 DCZs at the following addresses
    mapping =  [0x310000,0x311000]
    # let's create a DCZ instance that knows how to serialize and deserialize json
    dc = dcz.DCZ(mapping, serializers={"json":json})
    # before using it, DCZ instance must be init'ed
    dc.init()
    # if it is the first time the device runs, let's call finalize to encrypt resources if needed
    dc.finalize()

    # ok, print out the status
    dc.dump(entries=True)


    # define a callback for shadow updates
    def shadow_callback(requested):
        global publish_period
        print('requested publish period:', requested['publish_period'])
        publish_period = requested['publish_period']
        return {'publish_period': publish_period}



    wifi_driver.auto_init()

    # let's retrieve credentials as an encrypted resource
    # this file should be updated when the device user input the wifi credentials
    # by using dc.save_resource()
    # For the sake of this example, just edit the files/wificred.json with your credentials
    wificred = dc.load_resource("wificred")

    print('connecting to wifi...',wificred["ssid"])
    wifi.link(wificred["ssid"],wifi.WIFI_WPA2,wificred["password"])

    # load resourcef from the DCZ
    pkey = dc.load_resource("prvkey")
    clicert =  dc.load_resource("clicert")
    cacert =  dc.load_resource("cacert")
    thing_conf = dc.load_resource("devinfo")
    endpoint = dc.load_resource("endpoint")
    publish_period = 1000

    # create aws iot thing instance, connect to mqtt broker, set shadow update callback and start mqtt reception loop
    thing = iot.Thing(
        endpoint['endpoint'],
        thing_conf['thing_name'],
        clicert,
        pkey,
        thingname=thing_conf['thing_name'],
        cacert=cacert)

    # free some memory by setting resources to None
    pkey = None
    clicert = None
    cacert = None

    print('connecting to mqtt broker')
    print("endpoint:",endpoint["endpoint"])
    print("thing:",thing_conf["thing_name"])
    thing.mqtt.connect()
    thing.on_shadow_request(shadow_callback)
    thing.mqtt.loop()

    thing.update_shadow({'publish_period': publish_period})

    while True:
        print('publish random sample...')
        thing.mqtt.publish("dev/sample", json.dumps({ 'asample': random(0,10) }))
        sleep(publish_period)


except Exception as e:
    print(e)

```
