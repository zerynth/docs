# Getting started

The Zerynth Device Manager (ZDM) Library contains many different commands that allows you to connect your devices
to the ZDM. You can use ZDM lib to send data from your devices and to let them receive your remote commands (jobs).

To learn how to be able to use it and call ZDM methods, see the [ZDM getting started doc](https://www.zerynth.com/blog/docs/the-tools/zdm/getting-started/).

# The Device class


---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device(device_id, jobs_dict=None, endpoint, port, fota_callback=None)`"

Creates a Device instance with uid `device_id`. All other parameters are optional and have default values.


* `endpoint` is the endpoint of the zdm.


* `port` is the port of the zdm.


* `jobs_dict` is the dictionary that defines the device’s available jobs


* `fota_callback`, is a function accepting one ore more arguments that will be called at different steps of the FOTA process.

the `fota_callback` can return a boolean value. If the return value is True, the FOTA process continues, otherwise it is stopped.


---
#### `#!py3 set_password()`

!!!abstract "`#!py3 set_password(password)`"

Set the device password to `password`. You can generate a password using the ZDM, creating a key for your device


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect()`"

Connect your device to the ZDM. You must set device’s password first. It also enable your device to receive incoming messages.


---
#### `#!py3 publish()`

!!!abstract "`#!py3 publish(data, tag=None)`"

Publish a message to the ZDM.


* `data` is the message payload, represented by a dictionary


* `tag`, is a label for the device’s data into your workspace. More than one device can publish message to the same tag


---
#### `#!py3 send_event()`

!!!abstract "`#!py3 send_event(value)`"

Send an event from device to the ZDM. Events should be used to notify the occurrence of certain conditions, for example reaching a threshold.


* `value` is the message payload, represented by a dictionary

`value` is a custom dictionary that can contains custom field but, if you want to give a name to your events
(default name is ‘event’) you should add ‘name’ field.

For example: value={‘name’: ‘my_event’, ‘message’: ‘custom event message’}
