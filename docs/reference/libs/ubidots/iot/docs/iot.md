# Ubidots Library

The Zerynth Ubidots Library can be used to ease the connection to the [Ubidots IoT platform](https://ubidots.com/).

It allows to make your device act as an Ubidots Device which can be created through Ubidots dashboard.

## The Device class


**`class Device(device_label, user_type, api_token)`**

Create a Device instance representing an Ubidots Device.

The Device object will contain an mqtt client instance pointing to Ubidots MQTT broker located at `things.ubidots.com` or `industrial.api.ubidots.com` depending on `user_type`, a string which can be `"educational"` or `"business"`.
The client is configured wit `device_label` as MQTT id and is able to connect securely through TLS and to authenticate setting `api_token` as client username.

The client is accessible through `mqtt` instance attribute and exposes all [Zerynth MQTT Client methods](https://docs.zerynth.com/latest/official/lib.zerynth.mqtt/docs/index.html#lib-zerynth-mqtt) so that it is possible, for example, to setup custom callback on MQTT commands (though the Device class already exposes high-level methods to setup Ubidots specific callbacks). The only difference concerns mqtt.connect method which does not require broker url and ssl context, taking them from Device configuration:

```py
my_device = iot.Device('my_label', 'business', 'my_api_token')
my_device.mqtt.connect()
...
my_device.mqtt.loop()
```


**`publish(data, variable=None)`**

Publish `data` dictionary to device or device variable `variable`.
Data dictionary should follow [valid Ubidots data format](https://ubidots.com/docs/api/mqtt.html#publish).


**on_variable_update(device, variable, callback, json=True)`**

Set a callback to respond to `variable` updates from device `device`.

`callback` will be called passing a dictionary or a float value, containing variable updates, respectively for a `True` or `False` `json` parameter value:

```py
def noise_callback(data):
    noise_level = data['value']
    noise_location = data['context']
    print(noise_level, noise_location)

device.on_variable_update('noise-listener', 'noise-level', noise_callback)
```
