# MQTT Library

This module contains an implementation of the MQTT protocol (client-side) based on the work of Roger Light <[roger@atchoo.org](mailto:roger@atchoo.org)> from the [paho-project](https://eclipse.org/paho/).

When publishing and subscribing, a client is able to specify a quality of service (QoS) level for messages which activates procedures to assure a message to be actually delivered or
received, available levels are:


* 0 - at most once
* 1 - at least once
* 2 - exactly once

!!! note
	Resource clearly explaining the QoS feature: [mqtt-quality-of-service-levels](http://www.hivemq.com/blog/mqtt-essentials-part-6-mqtt-quality-of-service-levels).

Back to the implementation Zerynth mqtt.Client class provides methods to:


* connect to a broker
* publish
* subscribe
* unsubscribe
* disconnect from the broker

and a system of **callbacks** to handle incoming packets.

## MQTTMessage class

##### class MQTTMessage

```#!py3 class MQTTMessage()```

This is a class that describes an incoming message. It is passed to callbacks as *message* field in the *data* dictionary.

Members:


* topic : String. topic that the message was published on.
* payload : String. the message payload.
* qos : Integer. The message Quality of Service 0, 1 or 2.
* retain : Boolean. If true, the message is a retained message and not fresh.
* mid : Integer. The message id.

## Client class

##### class Client

```#!py3 class Client()```

This is the main module class. After connecting to a broker it is suggested to subscribe to some channels and configure callbacks. Then, a non-blocking loop function, starts a separate thread to handle incoming packets.

Example:

```py
my_client = mqtt.Client("myId",True)
for retry in range(10):
    try:
        my_client.connect("test.mosquitto.org", 60)
        break
    except Exception as e:
        print("connecting...")
my_client.subscribe([["cool/channel",1]])
my_client.on(mqtt.PUBLISH, print_cool_stuff, is_cool)
my_client.loop()

# do something else...
```

Details about the callback system under `on()` method.

###### Client.__init__

```#!py3 __init__(client_id, clean_session=True)```

* *client_id* is the unique client id string used when connecting to the broker.
* *clean_session* is a boolean that determines the client type. If True, the broker will remove all information about this client when it disconnects. If False, the client is a persistent client and subscription information and queued messages will be retained when the client disconnects. Note that a client will never discard its own outgoing messages if accidentally disconnected: calling reconnect() will cause the messages to be resent.


###### Client.on

```#!py3 on(command, function, condition=None, priority=0)```

Set a callback in response to an MQTT received command.


* *command* is a constant referring to which MQTT command call the callback on, can be one of:

```py
mqtt.PUBLISH
mqtt.PUBACK
mqtt.PUBREC
mqtt.PUBREL
mqtt.PUBCOMP
mqtt.SUBACK
mqtt.UNSUBACK
mqtt.PINGREQ
mqtt.PINGRESP
```


* *function* is the function to execute if *condition* is respected. It takes both the client itself and a *data* dictionary as parameters. The *data* dictionary may contain the following fields:
    * *message*: MQTTMessage present only on PUBLISH packets for messages with qos equal to 0 or 1, or on PUBREL packets for messages with qos equal to 2
* *condition* is a function taking the same *data* dictionary as parameter and returning True or False if the packet respects a certain condition.
*condition* parameter is optional because a generic callback can be set without specifying a condition, only in response to a command. A callback of this type is called a ‘low priority’ callback meaning that it is called only if all the more specific callbacks (the ones with condition) get a False condition response.

Example:

```py
def is_cool(data):
    if ('message' in data):
        return (data['message'].topic == "cool")
    # N.B. not checking if 'message' is in data could lead to Exception
    # on PUBLISH packets for messages with qos equal to 2
    return False

def print_cool_stuff(client, data):
    print("cool: ", data['message'].payload)

def print_generic_stuff(client, data):
    if ('message' in data):
        print("not cool: ", data['message'].payload)

my_client.on(mqtt.PUBLISH, print_cool_stuff, is_cool)
my_client.on(mqtt.PUBLISH, print_generic_stuff)
```

In the above example for every PUBLISH packet it is checked if the topic
is ```cool```, only if this condition fails, ```print_generic_stuff``` gets executed.

###### Client.set_will

```#!py3 set_will(topic, payload, qos, retain)```

Set client will.

###### Client.set_username_pw

```#!py3 set_username_pw(username, password = None)```

Set connection username and password.

###### Client.connect

```#!py3 connect(host, keepalive, port=1883, ssl_ctx=None, breconnect_cb=None, aconnect_cb=None, sock_keepalive=None)```

Connects to a remote broker.


* *host* is the hostname or IP address of the remote broker.
* *port* is the network port of the server host to connect to. Defaults to 1883.
* *keepalive* is the maximum period in seconds between communications with the
broker. If no other messages are being exchanged, this controls the
rate at which the client will send ping messages to the broker.
* *ssl_ctx* is an optional ssl context (Zerynth SSL module) for secure mqtt channels.
* *breconnect_cb* is an optional callback with actions to be performed before the client tries to reconnect when connection is lost. The callback function will be called passing mqtt client instance.
* *aconnect_cb* is an optional callback with actions to be performed after the client successfully connects. The callback function will be called passing mqtt client instance.
* *sock_keepalive* is a list of int values (3 elements) representing in order count (pure number), idle (in seconds) and interval (in seconds) of the keepalive socket option (default None - disabled).

###### Client.reconnect

```#!py3 reconnect()```

Reconnects the client if accidentally disconnected.

###### Client.subscribe

```#!py3 subscribe(topics```

Subscribes to one or more topics.


* *topis* a list structured this way:

```py
[[topic1,qos1],[topic2,qos2],...]
```

where topic1,topic2,… are strings and qos1,qos2,… are integers for the maximum quality of service for each topic

###### Client.unsubscribe

```#!py3 unsubscribe(topics)```

Unsubscribes the client from one or more topics.


* **topics** is list of strings that are subscribed topics to unsubscribe from.

###### Client.publish

```#!py3 publish(topic, payload=None, qos=0, retain=False)```

Publishes a message on a topic.

This causes a message to be sent to the broker and subsequently from the broker to any clients subscribing to matching topics.


* *topic* is the topic that the message should be published on.
* *payload* is the actual message to send. If not given, or set to None a
zero length message will be used.
* *qos* is the quality of service level to use.
* *retain*: if set to true, the message will be set as the “last known
good”/retained message for the topic.

It returns the mid generated for the message to give the possibility to set a callback precisely for that message.

###### Client.reconnect

```#!py3 reconnect()```

Sends a disconnect message.

###### Client.loop

```#!py3 loop(on_message = None)```

Non blocking loop method that starts a thread to handle incoming packets.


* *on_message* is an optional argument to set a generic callback on messages with qos equal to 0, 1 or 2
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc2NjE1MTEwMl19
-->
