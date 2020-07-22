# Zerynth ADM Library

The Zerynth ADM library can be used yo ease the connection to the [Zerynth ADM sandbox](https://docs.zerynth.com/latest/official/core.zerynth.docs/zadm/docs/index.html#zadm). It takes care of connecting to the ADM and listening for incoming messages. Moreover it seamlessly enables RPC calls and mobile integration. For Virtual Machines supporting FOTA updates, the Zerynth ADM also performs the FOTA process automatically when requested.

## Zerynth ADM Step by Step

Using the ADM library is very simple:


* obtain device credentials (UID and TOKEN): can be copied and pasted directly from Zerynth Studio (ADM panel) or the Zerynth Toolchain
* optionally define a dictionary of remotely callable functions
* create an instance of the Device class with the desired configuration
* start the device instance
* send and receive messages from connected templates and apps

Check the provided examples for more details.

## The Device class

##### class Device

```#!py3 class Device(uid, token, ip=None, address="things.zerynth.com", heartbeat=60, rpc=None, log=False, fota_callback=None, low_res=False)```

Creates a Device instance with uid `uid` and token `token`. All other parameters are optional and have default values.


* `ip` is the ip address of the ADM. This argument is used when the network driver does not support hostname resolution
* `address` is the hostname of the ADM instance. It is used by default and resolved to an ip address when the network driver supports the functionality
* `heartbeat` is the number of seconds between heartbeat messages. If the ADM detects that a connected device is not sending heartbeat messages two times in a row, it automatically terminates the connection. Heartbeat messages are automatically sent by the Device class. The ADM may not accept the specified heartbeat time and force the device to use another, based on network traffic and other parameters.
* `rpc` is a dictionary with keys representing function names and values representing actual Python functions. When a RPC call is made to the ADM, the message is relayed to the connected device. The Device class, scans the `rpc` dictionary and if a key matching the requested call is found, the corresponding function is executed (in the Device class thread). The result (or the exception message) is then sent back to the ADM that relays it to the caller.
* `log`, if true prints logging messages to the device serial console
* `fota_callback`, is a function accepting one ore more arguments that will be called at different steps of the FOTA process. The argument will be set to:

    * `0`, when the FOTA process is started
    * `1`, when the FOTA process needs to update the FOTA record
    * `2`, when the FOTA process needs to reseet the device at the end of the FOTA process

    the `fota_callback` can return a boolean value. If the return value is True, the FOTA process continues, otherwise it is stopped.
* `low_res`, if true makes the FOTA process a bit less performant but more lightweight (needed for low-resource devices)

###### Device.start

```#!py3 start()```

Starts the connection process and creates background threads to handle incoming and outgoing messages. It returns immediately.

###### Device.send

```#!py3 send(msg)```

Send a raw message to the ADM. `msg` is a dictionary that will be serialized to JSON and sent.

###### Device.send_event

```#!py3 send_event(payload)```

Send an event message containing the payload `payload` to the ADM. Payload is given as a dictionary and then serialized to JSON.

###### Device.send_notification

```#!py3 send_notification(title, text)```

Send a push notification to connected apps and templates. The notification must have a `title` and a `text`.
