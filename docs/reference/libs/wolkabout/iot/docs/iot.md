# WolkAbout IoT Platform Library

WolkAbout Python Connector library for connecting Zerynth devices to [WolkAbout IoT Platform](https://wolkabout.com/).
The Wolk class depends upon interfaces, making it possible to provide different implementations.
The section Dependencies contains the documentation of the default implementations, followed by the Wolk section that
contains everything necessary to connect and publish data to the WolkAbout IoT Platform.

## Dependencies

The following classes are implementations of interfaces on which the Wolk class depends

### MQTT Connectivity Service


---
#### `#!py3 ZerynthMQTTConnectivityService()`

!!!abstract "`#!py3 ZerynthMQTTConnectivityService(ConnectivityService.ConnectivityService)`"

This class provides the connection to the WolkAbout IoT Platform by implementing the `ConnectivityService` interface


* `device`: Contains device key, device password and actuator references


* `host`: Address of the WolkAbout IoT Platform instance


* `port`: Port of WolkAbout IoT Platform instance


* `qos`: Quality of Service for MQTT connection (0,1,2), defaults to 0


---
#### `#!py3 set_inbound_message_listener()`

!!!abstract "`#!py3 set_inbound_message_listener(on_inbound_message)`"

Sets the callback method to handle inbound messages


* `on_inbound_message`:  The method that handles inbound messages


---
#### `#!py3 on_mqtt_message()`

!!!abstract "`#!py3 on_mqtt_message(client, data)`"

Method that serializes inbound messages and passes them to the inbound message listener


* `client`:  The client that received the message


* `data`: The message received


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect()`"

This method establishes the connection to the WolkAbout IoT platform.
If there are actuators it will subscribe to topics that will contain actuator commands and also starts a loop to handle inbound messages.
Raises an exception if the connection failed.


---
#### `#!py3 disconnect()`

!!!abstract "`#!py3 disconnect()`"

Disconnects the device from the WolkAbout IoT Platform


---
#### `#!py3 connected()`

!!!abstract "`#!py3 connected()`"

Returns the current status of the connection


---
#### `#!py3 publish()`

!!!abstract "`#!py3 publish(outbound_message)`"

Publishes the `outbound_message` to the WolkAbout IoT Platform

### Outbound Message Queue


---
#### `#!py3 ZerynthOutboundMessageQueue()`

!!!abstract "`#!py3 ZerynthOutboundMessageQueue(OutboundMessageQueue.OutboundMessageQueue)`"

This class provides the means of storing messages before they are sent to the WolkAbout IoT Platform.


* `maxsize`: Int - The maximum size of the queue, effectively limiting the number of messages to persist in memory


---
#### `#!py3 put()`

!!!abstract "`#!py3 put(message)`"

Adds the `message` to `self.queue`


---
#### `#!py3 get()`

!!!abstract "`#!py3 get()`"

Takes the first `message` from `self.queue`


---
#### `#!py3 peek()`

!!!abstract "`#!py3 peek()`"

Returns the first `message` from `self.queue` without removing it from the queue

### Outbound Message Factory


---
#### `#!py3 ZerynthOutboundMessageFactory()`

!!!abstract "`#!py3 ZerynthOutboundMessageFactory(OutboundMessageFactory.OutboundMessageFactory)`"

This class serializes sensor readings, alarms and actuator statuses so that they can be properly sent to the WolkAbout IoT Platform


* `device_key` - The key used to serialize messages


---
#### `#!py3 make_from_sensor_reading()`

!!!abstract "`#!py3 make_from_sensor_reading(reading)`"

Serializes the `reading` to be sent to the WolkAbout IoT Platform


* `reading`: Sensor reading to be serialized


---
#### `#!py3 make_from_alarm()`

!!!abstract "`#!py3 make_from_alarm(alarm)`"

Serializes the `alarm` to be sent to the WolkAbout IoT Platform


* `alarm`: Alarm event to be serialized


---
#### `#!py3 make_from_actuator_status()`

!!!abstract "`#!py3 make_from_actuator_status(actuator)`"

Serializes the `actuator` to be sent to the WolkAbout IoT Platform


* `actuator`: Actuator status to be serialized


---
#### `#!py3 make_from_configuration()`

!!!abstract "`#!py3 make_from_configuration(self, configuration)`"

Serializes the device’s configuration to be sent to the platform


* `configuration`: Configuration to be serialized

### Inbound Message Factory


---
#### `#!py3 ZerynthInboundMessageDeserializer()`

!!!abstract "`#!py3 ZerynthInboundMessageDeserializer(InboundMessageDeserializer.InboundMessageDeserializer)`"

This class deserializes messages that the device receives from the WolkAbout IoT Platform from the topics it is subscribed to.


---
#### `#!py3 deserialize_actuator_command()`

!!!abstract "`#!py3 deserialize_actuator_command(message)`"

Deserializes the `message` that was received from the WolkAbout IoT Platform


* `message`: The message to be deserialized


---
#### `#!py3 deserialize_configuration_command()`

!!!abstract "`#!py3 deserialize_configuration_command(message)`"

Deserializes the `message` that was received from the WolkAbout IoT Platform


* `message` The message to be deserialized

## Wolk class


---
#### `#!py3 Wolk()`

!!!abstract "`#!py3 Wolk()`"

This class is a wrapper for the WolkCore class that passes the Zerynth compatible implementation of interfaces to the constructor


* `device`: Contains device key and password, and actuator references


* `host`: The address of the WolkAbout IoT Platform, defaults to the Demo instance


* `port`: The port to which to send messages, defaults to 1883


* `actuation_handler`: Implementation of the `ActuationHandler` interface


* `actuator_status_provider`: Implementation of the `ActuatorStatusProvider` interface


* `outbound_message_queue`: Implementation of the `OutboundMessageQueue` interface


* `configuration_handler`: Implementation of the `ConfigurationHandler` interface


* `configuration_provider`: Implementation of the `ConfigurationProvider` interface


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect()`"

Connects the device to the WolkAbout IoT Platform by calling the provided connectivity_service’s `connect` method


---
#### `#!py3 disconnect()`

!!!abstract "`#!py3 disconnect()`"

Disconnects the device from the WolkAbout IoT Platform by calling the provided connectivity_service’s `disconnect` method


---
#### `#!py3 add_sensor_reading()`

!!!abstract "`#!py3 add_sensor_reading(reference, value, timestamp=None)`"

Publish a sensor reading to the platform


* `reference`: String - The reference of the sensor


* `value`: Int, Float - The value of the sensor reading


* `timestamp`: (optional) Unix timestamp - if not provided, platform will assign one upon reception


---
#### `#!py3 add_alarm()`

!!!abstract "`#!py3 add_alarm(reference, active, timestamp=None)`"

Publish an alarm to the platform


* `reference`: String - The reference of the alarm


* `active`: Bool - Current state of the alarm


* `timestamp`: (optional) Unix timestamp - if not provided, platform will assign one upon reception


---
#### `#!py3 publish()`

!!!abstract "`#!py3 publish()`"

Publishes all currently stored messages and current actuator statuses to the platform


---
#### `#!py3 publish_actuator_status()`

!!!abstract "`#!py3 publish_actuator_status(reference)`"

Publish the current actuator status to the platform


* `reference`: String - The reference of the actuator


---
#### `#!py3 _on_inbound_message()`

!!!abstract "`#!py3 _on_inbound_message(message)`"

Callback method to handle inbound messages

```NOTE```: Pass this method to the implementation of `ConnectivityService` interface


* `message`: The message received from the platform


---
#### `#!py3 publish_configuration()`

!!!abstract "`#!py3 publish_configuration()`"

Publishes the current device configuration to the platform

### Device


---
#### `#!py3 Device()`

!!!abstract "`#!py3 Device()`"

The `Device` class contains all the required information for connecting to the WolkAbout IoT Platform.


* `key` - The device key obtained when creating the device on WolkAbout IoT platform


* `password` - The device password obtained when creating the device on WolkAbout IoT platform


* `actuator_references` - A list of actuator references defined in the device template on WolkAbout IoT Platform

### Actuation Handler


---
#### `#!py3 ActuationHandler()`

!!!abstract "`#!py3 ActuationHandler()`"

This interface must be implemented in order to execute actuation commands issued from WolkAbout IoT Platform.


---
#### `#!py3 handle_actuation()`

!!!abstract "`#!py3 handle_actuation(reference, value)`"

This method will try to set the actuator, identified by `reference`, to the `value` specified by WolkAbout IoT Platform

### Actuator Status Provider


---
#### `#!py3 ActuatorStatusProvider()`

!!!abstract "`#!py3 ActuatorStatusProvider()`"

This interface must be implemented in order to provide information about the current status of the actuator to the WolkAbout IoT Platform


---
#### `#!py3 get_actuator_status()`

!!!abstract "`#!py3 get_actuator_status(reference)`"

This method will return the current actuator `state` and `value`, identified by `reference`, to the WolkAbout IoT Platform.
The possible states are:

```
iot.ACTUATOR_STATE_READY
iot.ACTUATOR_STATE_BUSY
iot.ACTUATOR_STATE_ERROR
```

The method should return something like this:

```
return (iot.ACTUATOR_STATE_READY, value)
```

### Configuration Handler


---
#### `#!py3 ConfigurationHandler()`

!!!abstract "`#!py3 ConfigurationHandler()`"

This interface must be implemented in order to handle configuration commands issued from WolkAbout IoT Platform


---
#### `#!py3 handle_configuration()`

!!!abstract "`#!py3 handle_configuration(configuration)`"

This method should update device configuration with received configuration values.


* `configuration` - Dictionary that containes reference:value pairs

### Configuration Provider


---
#### `#!py3 ConfigurationProvider()`

!!!abstract "`#!py3 ConfigurationProvider()`"

This interface must be implemented to provide information about the current configuration settings to the WolkAbout IoT Platform


---
#### `#!py3 get_configuration()`

!!!abstract "`#!py3 get_configuration()`"

Reads current device configuration and returns it as a dictionary with device configuration reference as the key, and device configuration value as the value.
