# Fortebit IoT Library

The Zerynth Fortebit IoT Library can be used to ease the connection to the [Fortebit IoT Cloud](https://fortebit.tech/cloud/).

It makes your device act as a Fortebit IoT Device that can be monitored and controlled on the Fortebit IoT Cloud dashboard.

The device always send and receive data in the JSON format.

## The Device class

**`class 
---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device(device_token, client, ctx=None)`**"

Create a Device instance representing a Fortebit IoT device.

The device is provisioned by the `device_token`, obtained from the Fortebit dashboard upon the creation of a new device. 
The `client` parameter is a class that provides the implementation of the low level details for the connection. 
It can be one of `MqttClient` in the `mqtt_client` module, or `HttpClient` in the `http_client` module.
The optional `ctx` parameter is an initialized secure socket context.


**`---
#### `#!py3 listen_rpc()`

!!!abstract "`#!py3 listen_rpc(callback)`**"

Listen to incoming RPC requests that get reported to the specified `callback` function, 
called as *callback(id, method, params)*:


* `id` is the request identifier (number)


* `method` is the method identifier of the RPC (Remote Procedure Call)


* `params` is a dictionary containing the RPC method arguments (or parameters)

Call `send_rpc_reply()` to provide the result of the RPC request.


**`---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect()`**"

Setup a connection to the Fortebit Cloud. Return *```True*``` if successful.


**`is_connected()`**---
#### `#!py3 is_connected()`

!!!abstract "`#!py3 is_connected()`"

Returns the status of the connection to the Fortebit Cloud (reconnections are automatic).


**`run()`**---
#### `#!py3 run()`

!!!abstract "`#!py3 run()`"

Starts the device by executing the underlying client loop.


**`---
#### `#!py3 publish_telemetry()`

!!!abstract "`#!py3 publish_telemetry(values, ts)`**"

Publish `values` (dictionary) to the device telemetry, with optional timestamp `ts` (epoch in milliseconds).

Return a boolean, *```False*``` if the message cannot be sent.

**`
---
#### `#!py3 publish_attributes()`

!!!abstract "`#!py3 publish_attributes(attributes)`**"

Publish `attributes` (dictionary) to the device *```client*``` attributes.

Return a boolean, *```False*``` if the message cannot be sent.


**`---
#### `#!py3 get_attributes()`

!!!abstract "`#!py3 get_attributes(client, shared, timeout)`**"

Obtain the specified `client` and/or `shared` attributes from the device.

Return a dictionary, *```None*``` if the data could not be received.


**`---
#### `#!py3 send_rpc_reply()`

!!!abstract "`#!py3 send_rpc_reply(id, result)`**"

Publish `result` (dictionary) as a reply to the RPC request with identifier `id`.

Return a boolean, *```False*``` if the message cannot be sent.

**`
---
#### `#!py3 do_rpc_request()`

!!!abstract "`#!py3 do_rpc_request(method, params, timeout)`**"

Perform an RPC request with name `method` and arguments `params`, waiting for 
a reply maximum `timeout` milliseconds (only with MqttClient).

Return the result of the RPC (dictionary), *```None*``` in case of errors.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3MTMyNTExNzcsLTE0MDEyMDMyXX0=
-->