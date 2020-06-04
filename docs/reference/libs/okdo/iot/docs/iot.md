# OKdo IoT Library

The Zerynth OKdo IoT Library can be used to ease the connection to the [OKdo IoT Cloud](https://www.okdo.com/us/do-iot/).

It makes your device act as an OKdo IoT Device which can be created and provisioned on the OKdo IoT Cloud dashboard.

The device always send and receive data in the JSON format.

Check out the examples for a jump start.

## The Device class


---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device(device_id, device_token, client)`"

Create a Device instance representing an OKdo device.

The device is provisioned by the `device_id` and `device_token`, obtained from the OKdo dashboard upon the creation of a new device.
the `client` parameter is a class that provides the implementation of the low level details for the connection. It can be one of `MqttClient` in the `mqtt_client` module, or `HttpClient` in the `http_client` module.


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect()`"

Setup a connection to the OKdo Cloud. It can raise an exception in case of error.


---
#### `#!py3 run()`

!!!abstract "`#!py3 run()`"

Starts the device by executing the underlying client. It can start a new thread depending on the type of client (Mqtt vs Http)


---
#### `#!py3 publish_asset()`

!!!abstract "`#!py3 publish_asset(asset_name, value)`"

Modify a device asset state. After a successful execution, the new state of the device asset `asset_name` will be set to `value`.

Return the message sent to the OKdo Cloud, or `None` if the message cannot be sent.


---
#### `#!py3 publish_state()`

!!!abstract "`#!py3 publish_state(state)`"

Modify a device state. After a successful execution, the new state of the device will be set to the values contained in `state`. `state` is
a dict where each key is the name of an asset and each value the desired state.

Return the message sent to the OKdo Cloud, or `None` if the message cannot be sent.


---
#### `#!py3 watch_command()`

!!!abstract "`#!py3 watch_command(asset_name, callback)`"

Start listening for asset command on the device asset identified by `asset_name`. When a new asset command arrives, the function `callback` is executed receiving as arguments the asset name, the new value and the previous value (or None if it is the first update).
Incoming values are checked against the last received timestamp in order to avoid triggering the callback for
Modify a device state. After a successful execution, the new state of the device will be set to the values contained in `state`. `state` is
a dict where each key is the name of an asset and each value the desired state.

Return the message sent to the OKdo Cloud, or `None` if the message cannot be sent.
