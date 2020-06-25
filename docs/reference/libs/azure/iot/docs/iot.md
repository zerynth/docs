# Microsoft Azure Iot Hub Library

The Zerynth Microsoft Azure Iot Hub Library can be used to ease the connection to [Microsoft Azure Iot Hub](https://azure.microsoft.com/en-us/services/iot-hub/).

It allows to make your device act as a Microsoft Azure Iot Hub Device which can be registered through Azure command line tools or Azure web dashboard.

## The Device class


**`class---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device(hub_id, device_id, api_version, key, timestamp_fn, token_lifetime=60)`**"

Create a Device instance representing a Microsoft Azure Iot Hub Device.

The Device object will contain an mqtt client instance pointing to Microsoft Azure Iot Hub MQTT broker located at `hub_id.azure-devices.net`.
The client is configured with `device_id` as MQTT id and is able to connect securely through TLS and authenticate through a [SAS](https://docs.microsoft.com/en-us/azure/storage/common/storage-dotnet-shared-access-signature-part-1) token with a `token_lifetime` minutes lifespan.

Valid tokens generation process needs current timestamp which will be obtained calling passed `timestamp_fn`.
`timestamp_fn` has to be a Python function returning an integer timestamp.
A valid base64-encoded primary or secondary key `key` is also needed.

The `api_version` string is mandatory to enable some responses from Azure MQTT broker on specific topics.

The client is accessible through `mqtt` instance attribute and exposes all Zerynth MQTT Client methods so that it is possible, for example, to setup
custom callbacks on MQTT commands (though the Device class already exposes high-level methods to setup Azure specific callbacks).
The only difference concerns `mqtt.connect` method which does not require broker url and ssl context, taking them from Device configuration:

```py
def timestamp_fn():
    valid_timestamp = 1509001724
    return valid_timestamp

key = "ZhmdoNjyBccLrTnku0JxxVTTg8e94kleWTz9M+FJ9dk="
my_device = iot.Device('my-hub-id', 'my-device-id', '2017-06-30', key, timestamp_fn)
my_device.mqtt.connect()
...
my_device.mqtt.loop()
```


**`---
#### `#!py3 on_bound()`

!!!abstract "`#!py3 on_bound(bound_cbk)`**"

Set a callback to be called on cloud to device messages.

`bound_cbk` callback will be called passing a string containing sent message and a dictionary containing sent properties:

```py
def bound_callback(msg, properties):
    print('c2d msg:', msg)
    print('with properties:', properties)

my_device.on_bound(bound_callback)
```


**`---
#### `#!py3 on_method()`

!!!abstract "`#!py3 on_method(method_name, method_cbk)`**"

Set a callback to respond to a direct method call.

`method_cbk` callback will be called in response to `method_name` method, passing a dictionary containing method payload (should be a valid JSON):

```py
def send_something(method_payload):
    if method_payload['type'] == 'random':
        return (0, {'something': random(0,10)})
    deterministic = 5
    return (0, {'something': deterministic})

my_device.on_method('get', send_something)
```

`method_cbk` callback must return a tuple containing response status and a dictionary or None as response payload.


**`---
#### `#!py3 on_twin_update()`

!!!abstract "`#!py3 on_twin_update(twin_cbk)`**"

Set a callback to respond to cloud twin updates.

`twin_cbk` callback will be called when a twin update is notified by the cloud, passing a dictionary containing desired twin and an integer representing current twin version:

```py
def twin_callback(twin, version):
    print('new twin version:', version)
    print(twin)

my_device.on_twin_update(twin_callback)
```

It is possible for `twin_cbk` to return a dictionary which will be immediately sent as reported twin.


**`---
#### `#!py3 report_twin()`

!!!abstract "`#!py3 report_twin(reported, wait_confirm=True, timeout=1000)`**"

Report `reported` twin.

`reported` twin must be a dictionary and will be sent as JSON string.
It is possible to not wait for cloud confirmation setting `wait_confirm` to false or to set a custom `timeout` (`-1` to wait forever) for the confirmation process which could lead to `TimeoutException`.

An integer status code is returned after cloud confirmation.


**`---
#### `#!py3 get_twin()`

!!!abstract "`#!py3 get_twin(timeout=1000)`**"

Get current twin containing desired and reported fields.
It is possible set a custom `timeout` (`-1` to wait forever) for the process which could lead to `TimeoutException`.

An integer status code is returned after cloud response along with received `twin` JSON-parsed dictionary.


**`---
#### `#!py3 publish_event()`

!!!abstract "`#!py3 publish_event(event, properties)`**"

Publish a new event `event` with custom `properties`.
`event` must be a dictionary and will be sent as json string.
`properties` must be a dictionary and will be sent as an url-encoded property bag.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI3NzE3OTM0OF19
-->