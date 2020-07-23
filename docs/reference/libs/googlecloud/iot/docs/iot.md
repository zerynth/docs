# Google Cloud IoT Core Library

The Zerynth Google Cloud IoT Core Library can be used to ease the connection to [Google Cloud IoT Core](https://cloud.google.com/iot-core/).

It allows to make your device act as a Google Cloud IoT Core Device which can be registered through Google Cloud tools or Google Cloud web dashboard.

## The Device class 

##### class Device

```#!py3 class Device(project_id,cloud_region,registry_id,device_id,pkey, timestamp_fn,token_lifetime=60).```

Create a Device instance representing a Google Cloud IoT Core Device.

The Device object will contain an mqtt client instance pointing to Google Cloud IoT Core MQTT broker located at `mqtt.googleapis.com`.
The client is configured with an MQTT id composed following Google Cloud IoT Core MQTT id standards

```python
projects/$project_id/locations/$cloud_region/registries/$registry_id/devices/$device_id
```

and is able to connect securely through TLS and authenticate through a JWT with a `token_lifetime` minutes lifespan.
Valid tokens generation process needs current timestamp which will be obtained calling passed `timestamp_fn`.
`timestamp_fn` has to be a Python function returning an integer timestamp.

A valid private key `pkey` is also needed.
`pkey` must be an ECDSA private key in hex format.
If a private key has been generated following [Google Cloud IoT guidelines](https://cloud.google.com/iot/docs/how-tos/credentials/keys?hl=it#generating_an_es256_key)
and is consequently stored as a pem file, the needed hex string can be extracted from the OCTET STRING field associated value obtained from

```python
openssl asn1parse -in my_private.pem
```

command (since pem is a base64 encoded, plus header, [DER](https://tools.ietf.org/html/rfc5915)).

The client is accessible through `mqtt` instance attribute and exposes all Zerynth MQTT Client methods so that it is possible, for example, to setup
custom callbacks on MQTT commands.
The only difference concerns `mqtt.connect` method which does not require broker url and ssl context, taking them from Device configuration:

```python
def timestamp_fn():
    valid_timestamp = 1509001724
    return valid_timestamp

pkey = "73801C733697C81604A4A4F7BF36FB84227DA506194A26A864A55B6DE8FF98E0"
my_device = iot.Device('my-project', 'my-cloud-region', 'my-registry-id', 'my-device-id', pkey, timestamp_fn)
my_device.mqtt.connect()
...
my_device.mqtt.loop()
```

###### Device.publish_event

```#!py3 publish_event(event)```

Publish a new event `event`.`event` must be a dictionary and will be sent as json string.

###### Device.publish_state

```#!py3 publish_state(state)```

Publish a new state `state`.`state` must be a dictionary and will be sent as json string.

###### Device.on_config

```#!py3 on_config(config_cbk)```

Set a callback to be called on config updates.

`config_cbk` callback will be called passing a dictionary containing requested config as the only parameter:

```python
def config_cbk(config):
    print('requested publish period:', config['publish_period'])
    return {'publish_period': config['publish_period']}

my_device.on_config(config_cbk)
```

If the callback returns a dictionary, it will be immediately sent as updated device state.

###### Device.on_command

```#!py3 on_command(command_cbk)```

Set a callback to be called on command.

`command_cbk` callback will be called passing the command payload and subfolder:

```python
def command_cbk(command, subfolder):
    print('requested command payload:', command)
    print('requested command subfolder:', subfolder)

my_device.on_command(command_cbk)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyNTU2MjE1NjVdfQ==
-->
