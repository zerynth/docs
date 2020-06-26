# Lightweight MQTT Library

This module contains an implementation of an MQTT client based on the [paho-project](https://eclipse.org/paho/) [embedded c client](https://github.com/eclipse/paho.mqtt.embedded-c).
It aims to be less memory consuming than the pure Python one.

The Client allows to connect to a broker (both via insecure and TLS channels) and start publishing messages/subscribing to topics with a simple interface.

Python callbacks can be easily set to handle incoming messages.

Reconnection can be manually handled by the user by means of several callbacks and methods (`reconnect()`, `connected()`, `loop_failure`)

## Client class


**`class Client(client_id, clean_session=True, cycle_timeout=500, command_timeout=60000)`**


* **Arguments:**

    
* **client_id** – unique ID of the MQTT Client (multiple clients connecting to the same broken with the same ID are not allowed), can be an empty string with `clean_session` set to true.
* **clean_session** – when `True` requests the broker to assign a clean state to connecting client without remembering previous subscriptions or other configurations.
* **cycle_timeout** – maximum time to wait for received messages on every loop cycle (in milliseconds)
* **command_timeout** – maximum time to wait for protocol commands to be acknowledged (in milliseconds)


Instantiates the MQTT Client.


**`connect(host, keepalive, port=1883, ssl_ctx=None, breconnect_cb=None, aconnect_cb=None, loop_failure=None, start_loop=True)`**


**Arguments:**

    
* **host** – hostname or IP address of the remote broker.
* **port** – network port of the server host to connect to, defaults to 1883.
* **keepalive** – maximum period in seconds between communications with the broker. If no other messages are being exchanged, this controls the rate at which the client will send ping messages to the broker.
* **ssl_ctx** – optional ssl context (Zerynth SSL module) for secure mqtt channels.
* **breconnect_cb** – optional callback with actions to be performed when `reconnect()` is called. The callback function will be called passing mqtt client instance.
* **aconnect_cb** – optional callback with actions to be performed after the client successfully connects. The callback function will be called passing mqtt client instance.
* **loop_failure** – optional callback with actions to be performed on failures happening during the MQTT read cycle. The user should try to implement client reconnection logic here. By default, or if `loop_failure` callback returns `mqtt.BREAK_LOOP`, the read loop is terminated on failures. `loop_failure` callback must return `mqtt.RECOVERED` to keep the MQTT read cycle alive.
* **start_loop** – if `True` starts the MQTT read cycle after connection.

Connects to a remote broker and start the MQTT reception thread.




**`get_return_code()`**

Get the return code of the last connection attempt.


**`reconnect()`**

Tries to connect again with previously set connection parameters.

If `breconnect_cb` was passed to `connect()`, `breconnect_cb` is executed first.

Return the return code of the connection.


**`connected()`**

Returns `True` if client is connected, `False` otherwise.


**`loop()`**

Starts MQTT background loop to handle incoming packets.

Already called by `connect()` if `start_loop` is `True`.


**`set_username_pw(username, password='')`**

**Arguments:**

    
* **username** – connection username.
* **password** – connection password.


Sets connection username and password.


**`publish(topic, payload='', qos=0, retain=False)`**


**Arguments:**

    
* **topic** – topic the message should be published on.
* **payload** – actual message to send. If not given a zero length message will be used.
* **qos** – is the quality of service level to use.
* **retain** – if set to true, the message will be set as the “last known good”/retained message for the topic.


Publishes a message on a topic.

This causes a message to be sent to the broker and subsequently from the broker to any clients subscribing to matching topics.


**`subscribe(topic, function, qos=0)`****


**Arguments:**

    
* **topic** – topic to subscribe to.
* **function** – callback to be executed when a message published on chosen topic is received.
* **qos** – quality of service for the subscription.


Subscribes to a topic and set a callback for processing messages published on it.

The callback function is called passing three parameters: the MQTT client object, the payload of received message and the actual topic:

```py
def my_callback(mqtt_client, payload, topic):
    # do something with client, payload and topic
    ...
```


**`unsubscribe(topic)`**

Unsubscribes the client from one topic.


**Arguments: topic** – is the string representing the subscribed topic to unsubscribe from.



**`disconnect(timeout=None)`**

Sends a disconnect message, optionally waiting for the loop to exit.


**Arguments: timeout** – is the maximum time to wait (in milliseconds).
