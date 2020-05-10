## 4ZeroManager library

This library is used for interfacing a device with the 4ZeroPlatform.

### Default available RPCs

There are some RPC available by default that can be called without any further configuration after this library is imported.

| RPC name   | Description                                            |
|------------|--------------------------------------------------------|
| reset_mcu  | Trigger a full reset of the microcontroller.           |
| rpc_list   | RPC outputs and results.                               |
| check_jobs | Internal use only. This is triggered by a FOTA update. |

### MQTT

MQTT is a protocol made with IoT devices in mind. It’s simple and with a low impact on required bandwidth and computational power. Every message is published to a certain _topic_.

MQTT is being used by the 4ZeroPlatform for sending RPC to the device and eventually get the result of it, but also for sending any kind of sensor reading. The topics that are currently used are:
| Topic   | Description                                  |
|---------|----------------------------------------------|
| adm_in  | Trigger a full reset of the microcontroller. |
| adm_out | RPC outputs and results.                     |
| sink    | Readings and data sent by the device.        |


Readings and data sent by the device.

From the [4ZeroManager](https://www.zerynth.com/blog/docs/4zeroplatform/getting-started/#4zeromanager) you can find a list of available MQTT urls for your device, already configured in the standard format `:@host:port`.

### FourZeroManager class

A class called `FourZeroManager` is exported for managing a connection to the 4ZeroPlatform.

Tipically it should be used like this:

```python
    from fourzerobox import FourZeroBox
    from fourzeromanager import FourZeroManager
    
    my_box = FourZeroBox()
    manager = FourZeroManager(my_box)
    manager.config()
    manager.connect()
```

### Available methods

**Constructor**

```python
__init__(fzbox, endpoint=None, project=None, thingname=None, rpc=None)

```

Init the class providing a `FourZeroBox` instance.

The `rpc` optional parameter is a dictionary containing names and methods to be called, e.g.:

```python
def do_something():
  return True

rpc = {
  "my_custom_rpc": do_something,
}

```

Optionally, some configuration variables such as the project and the device name, and the MQTT endpoint URL can be manually specified, otherwise they are read from the device flash memory.

**Parameters:**

-   **fzbox** – Instance of [FourZeroBox](https://www.zerynth.com/blog/docs/4zeroplatform/4zerobox/#fourzerobox-class).
-   **endpoint** – AWS endpoint, provided by the 4ZeroPlatform. (D=None)
-   **project** – Name of the project, must match the one in 4ZeroPlatform. (D=None)
-   **thingname** – Name of the device, must match the one in 4ZeroPlatform. (D=None)
-   **rpc** – Dict containing RPC names as keys and the functions to be called as values. (D=None)

**config()**

This method should be called after the class initialization, it registers a hander to be called for every MQTT message, and sends to the cloud the informations needed for a future FOTA update.

**connect()**

Wait for a connection to the MQTT server, then subscribe to the device channel.

This method should be called after config() .

**publish(topic=None, data=None)**

Publish to the device MQTT topic some data.

This method should be used when defining its own RPC methods, for sending results and data via internet.

**Parameters:**

-   **topic** – Optional, the destination topic. (D=None)
-   **data** – Data to be sent. (D=None)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0MzkxMzUzMDUsLTgwMTQ1OTAxMSwtMT
I2MzMyMDE3NiwtMTgzODQ4OTkyMiwxNTQwMjkwOTk2XX0=
-->