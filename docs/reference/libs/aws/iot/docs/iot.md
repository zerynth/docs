# Amazon Web Services IoT Library

The Zerynth AWS IoT Library can be used to ease the connection to the [AWS IoT platform](https://aws.amazon.com/iot-platform/).

It allows to make your device act as an AWS IoT Thing which can be registered through AWS tools or directly from the Zerynth Toolchain.

Check this video for a live demo:

  <div style="margin-top:10px;">
<iframe width="100%" height="480" src="https://www.youtube.com/embed/IZzZF3DGWkY?ecver=1" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
    </div>## The Thing class


---
#### `#!py3 Thing()`

!!!abstract "`#!py3 Thing(endpoint, mqtt_id, clicert, pkey, thingname=None, cacert=None)`"

Create a Thing instance representing an AWS IoT Thing.

The Thing object will contain an mqtt client instance pointing to AWS IoT MQTT broker located at `endpoint` endpoint.
The client is configured with `mqtt_id` as MQTT id and is able to connect securely through AWS authorized `pkey` private key and `clicert` certificate (an optional `cacert` CA Certificate can also be passed).

Refer to Zerynth SSL Context creation for admitted `pkey` values.

The client is accessible through `mqtt` instance attribute and exposes all Zerynth MQTT Client methods so that it is possible, for example, to setup
custom callback on MQTT commands.
The only difference concerns mqtt.connect method which does not require broker url and ssl context, taking them from Thing configuration:

```
my_thing = iot.Thing('my_ep_id.iot.my_region.amazonaws.com', 'my_thing_id', clicert, pkey)
my_thing.mqtt.connect()
...
my_thing.mqtt.loop()
```

A `thingname` different from chosen MQTT id can be specified, otherwise `mqtt_id` will be assumed also as Thing name.


---
#### `#!py3 update_shadow()`

!!!abstract "`#!py3 update_shadow(state)`"

Update thing shadow with reported `state` state.

`state` must be a dictionary containing only custom state keys and values:

```
my_thing.update_shadow({'publish_period': 1000})
```


---
#### `#!py3 on_shadow_request()`

!!!abstract "`#!py3 on_shadow_request(shadow_cbk)`"

Set a callback to be called on shadow update requests.

`shadow_cbk` callback will be called with a dictionary containing requested state as the only parameter:

```
def shadow_callback(requested):
    print('requested publish period:', requested['publish_period'])

my_thing.on_shadow_request(shadow_callback)
```

If a dictionary is returned, it is automatically published as reported state.
