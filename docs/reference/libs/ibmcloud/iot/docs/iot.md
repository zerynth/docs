# IBM Cloud Watson IoT Library

The Zerynth IBM Cloud Watson IoT Library can be used to ease the connection to the [IBM Watson IoT Platform](https://internetofthings.ibmcloud.com/).

It allows to make your device act as an IBM Watson IoT Device which can be created through IBM Watson IoT dashboard.

## The Device class


---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device(device_id, device_type, organization, auth_token)`"

Create a Device instance representing an IBM Watson IoT Device.

The Device object will contain an mqtt client instance pointing to IBM Watson IoT MQTT broker located at `organization.messaging.internetofthings.ibmcloud.com`.
The client is configured with `d:organization:device_type:device_id` as MQTT id and is able to connect securely through TLS and to authenticate setting `auth_token` as client password.

The client is accessible through `mqtt` instance attribute and exposes all Zerynth MQTT Client methods so that it is possible, for example, to setup
custom callback on MQTT commands (though the Device class already exposes high-level methods to setup IBM Watson IoT specific callbacks).
The only difference concerns mqtt.connect method which does not require broker url and ssl context, taking them from Device configuration:

```
my_device = iot.Device('my_device_id', 'my_device_type', 'my_organization', 'auth_token')
my_device.mqtt.connect()
...
my_device.mqtt.loop()
```


---
#### `#!py3 publish()`

!!!abstract "`#!py3 publish(event_id, event, format_string='json')`"

Publish `event_id` event with `event` content.

`event` content has to be a dictionary when `'json'` is chosen as `format_string`, a string otherwise.


---
#### `#!py3 on_cmd()`

!!!abstract "`#!py3 on_cmd(command_id, command_cbk, format_string='json')`"

Set a callback to respond to `command_id` command.

`command_cbk` callback will be called passing a dictionary containing command payload when `'json'` is chosen as `format_string`, a string otherwise

```
def turn_led(cmd_content):
    if cmd_content['dir'] == 'on':
        led_on()
    else:
        led_off()

my_device.on_cmd('turn_led', turn_led)
```
