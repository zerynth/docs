# Eseye AnyNet AWS Library

The Zerynth Eseye AnyNet AWS Library allows to easily connect to [AWS IoT platform](https://aws.amazon.com/iot-platform/) thanks to Eseye AnyNet AWS AT modem.


**`init(serdrv,serbaud=9600)`**


**Arguments:**

    

 - **serdrv** – serial communication driver (e.g., `SERIAL0`, `SERIAL1`, …)
 - **serbaud** – serial communication baudrate

Initialize serial communication with the Eseye AWS AT modem.


**`state(string_format=True)`**


**Arguments:**

 - **string_format** – `True` or `False` to select string or integer output format respectively

Retrieve modem state, returned as an integer in the range `0`, :samp:8 or a string in the list:

```python
[
    'Idle',
    'Waiting Keys',
    'Connecting to Network',
    'Establishing SSL',
    'SSL Connected',
    'Connecting MQTT',
    'Ready: MQTT Connected',
    'Ready: Subscribed',
    'Error'
]
```

**`qccid()`**

Retrieve the ICCD of AnyNet Secure SIM.


**`version()`**

Retrieve the version of the Eseye AWS AT modem firmware.


reset()

Force a reload of parameters from the SIM card, forcing the modem to reset.


**`pubopen(topic,sock_index)`**


**Arguments:**

    

 - **topic** – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen topic)
 - **sock_index** – an integer representing a valid modem socket index `(0,1)`

Open a publish *channel* to topic `topic` through socket index `sock_index`. Eseye AWS AT modem needs a publish *channel* to be open before starting publishing on a selected topic. A publish *channel* is open on top of an available socket represented by a socket index. Only one *channel* can be open on a single socket index, when trying to open a *channel* on an already used socket a `SocketUsageError` exception is raised.


**`pubopen_index(topic)`**


**Arguments:**

    

 - **topic** – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen
   topic)

Check if a publish *channel* for topic `topic` is already open on any of the available modem sockets, returning `None` if none is found, socket index otherwise.


**`publish(topic,payload,sock_index=0,qos=1,mode=2)`**


**Arguments:**

    

 - **topic** – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen topic)
 - **payload** – a string, bytes or bytearray object to be sent
 - **sock_index** – an integer representing a valid modem socket index `(0,1)`
 - **qos** – an integer representing the qos level to send the mqtt message with `(1,2,3)`
 - **mode** – an integer representing a valid publish mode `(0,1,2)`

Publish a message on a chosen topic in one of the following modes:

1. publish the message without opening a publish *channel*, which must be already open when calling this function,
2. open (`pubopen()`) a publish *channel* and publish the message without checking if a publish *channel* is already open on that topic,
3. open (`pubopen()`) a publish *channel* and publish the message checking if a *channel* is already open on chosen topic, if so the socket index on which the *channel* is already open overwrites passed one.


**`pubclose(sock_index)`**


**Arguments:**

    

 - **sock_index** – an integer representing a valid modem socket index `(0,1)`

Close a publish *channel* open on socket `sock_index`.


**`subopen(topic,sock_index)`**

**Arguments:**

    

 - **topic** – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen topic)
 - **sock_index** – an integer representing a valid modem socket index `(0,1)`

Open a subscription *channel* for topic `topic` through socket index `sock_index`.
A subscription ```channel``` is open on top of an available socket represented by a socket index.
Only one ```channel``` can be open on a single socket index, when trying to open a ```channel``` on an already used socket a `SocketUsageError` exception is raised.

Refer to `subscribe()` function to associate a callback function to chosen subscription.


---
#### `#!py3 subopen_index()`

!!!abstract "`#!py3 subopen_index(topic)`"


* ```Arguments```

    
    * ```topic``` – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen topic)


Check if a subscription ```channel``` for topic `topic` is already open on any of the available modem sockets, returning `None` if none is found, socket index otherwise.


---
#### `#!py3 subclose()`

!!!abstract "`#!py3 subclose(sock_index)`"


* ```Arguments```

    
    * ```sock_index``` – an integer representing a valid modem socket index `(0,1)`


Close a subscription open on socket `sock_index`


---
#### `#!py3 subscribe()`

!!!abstract "`#!py3 subscribe(topic, callback, sock_index=0, mode=1)`"


* ```Arguments```

    
    * ```topic``` – a string representing a valid mqtt topic (note that the modem firmware automatically appends AWS IoT Thing name to chosen topic)


    * ```callback``` – a function to be called when a message arrives on chosen topic


    * ```sock_index``` – an integer representing a valid modem socket index `(0,1)`


    * ```mode``` – an integer representing a valid subscription mode `(0,1)`


Subscribe to topic `topic` calling `callback` function whenever a new message arrives on chosen topic.
Example callback function:

```
def my_callback(sock_index, topic, data):
    print('> callback from', topic)
    print('> on socket ', sock_index)
    print('> with content:', data)
```

As reported, a callback function must accept three arguments.

Depending on selected mode, the following actions are executed calling the `subscribe()` function:


1. open (`subopen()`) a subscription ```channel```, setting a callback, without checking if a ```channel``` is already open on chosen topic


2. open (`subopen()`) a subscription ```channel```, setting a callback, checking if a ```channel``` is already open on chosen topic, if so the socket index on which the ```channel``` is already open overwrites passed one
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMTY2NzIzNjEsNzUzODA1NTczLC04MD
IzMTM3MjMsLTQ3NzgyMzYzMV19
-->