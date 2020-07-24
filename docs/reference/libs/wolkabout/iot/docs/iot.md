# WolkAbout IoT Platform Library

WolkAbout Python Connector library for connecting Zerynth devices to [WolkAbout IoT Platform](https://wolkabout.com/). The Wolk class depends upon interfaces, making it possible to provide different implementations. The section Dependencies contains the documentation of the default implementations, followed by the Wolk section that contains everything necessary to connect and publish data to the WolkAbout IoT Platform.

## Dependencies

The following classes are implementations of interfaces on which the Wolk class depends.

### MQTT Connectivity Service

##### class ZerynthMQTTConnectivityService

```#!py3 class ZerynthMQTTConnectivityService(ConnectivityService.ConnectivityService)```

This class provides the connection to the WolkAbout IoT Platform by implementing the `ConnectivityService` interface.


* `device`: Contains device key, device password and actuator references
* `host`: Address of the WolkAbout IoT Platform instance
* `port`: Port of WolkAbout IoT Platform instance
* `qos`: Quality of Service for MQTT connection (0,1,2), defaults to 0

###### ZerynthMQTTConnectivityService.set_inbound_message_listener

```#!py3 set_inbound_message_listener(on_inbound_message)```

Sets the callback method to handle inbound messages.


* `on_inbound_message`:  The method that handles inbound messages

###### ZerynthMQTTConnectivityService.on_mqtt_message

```#!py3 on_mqtt_message(client, data)```

Method that serializes inbound messages and passes them to the inbound message listener.


* `client`:  The client that received the message
* `data`: The message received

###### ZerynthMQTTConnectivityService.connect

```#!py3 connect()```

This method establishes the connection to the WolkAbout IoT platform. If there are actuators it will subscribe to topics that will contain actuator commands and also starts a loop to handle inbound messages. Raises an exception if the connection failed.

###### ZerynthMQTTConnectivityService.disconnect

```#!py3 disconnect()```

Disconnects the device from the WolkAbout IoT Platform.

###### ZerynthMQTTConnectivityService.connected

```#!py3 connected()```

Returns the current status of the connection.

###### ZerynthMQTTConnectivityService.publish

```#!py3 publish(outbound_message)```

Publishes the `outbound_message` to the WolkAbout IoT Platform.

### Outbound Message Queue

##### class ZerynthOutboundMessageQueue

```#!py3 class ZerynthOutboundMessageQueue(OutboundMessageQueue.OutboundMessageQueue)```


This class provides the means of storing messages before they are sent to the WolkAbout IoT Platform.


* `maxsize`: Int - The maximum size of the queue, effectively limiting the number of messages to persist in memory.

###### ZerynthOutboundMessageQueue.put

```#!py3 put(message)```

Adds the `message` to `self.queue`.

###### ZerynthOutboundMessageQueue.get

```#!py3 get()```

Takes the first `message` from `self.queue`.

###### ZerynthOutboundMessageQueue.peek

```#!py3 peek()```

Returns the first `message` from `self.queue` without removing it from the queue.

### Outbound Message Factory

##### class ZerynthOutboundMessageFactory

```#!py3 class ZerynthOutboundMessageFactory(OutboundMessageFactory.OutboundMessageFactory)```

This class serializes sensor readings, alarms and actuator statuses so that they can be properly sent to the WolkAbout IoT Platform.


* `device_key` - The key used to serialize messages.

###### ZerynthOutboundMessageFactory.make_from_sensor_reading

```#!py3 make_from_sensor_reading(reading)```

Serializes the `reading` to be sent to the WolkAbout IoT Platform.


* `reading`: Sensor reading to be serialized.

###### ZerynthOutboundMessageFactory.make_from_alarm

```#!py3 make_from_alarm(alarm)```

Serializes the `alarm` to be sent to the WolkAbout IoT Platform.


* `alarm`: Alarm event to be serialized.

###### ZerynthOutboundMessageFactory.make_from_actuator_status

```#!py3 make_from_actuator_status(actuator)```

Serializes the `actuator` to be sent to the WolkAbout IoT .


* `actuator`: Actuator status to be serialized.

###### ZerynthOutboundMessageFactory.make_from_configuration

```#!py3 make_from_configuration(self, configuration)```

Serializes the device’s configuration to be sent to the platform.


* `configuration`: Configuration to be serialized.

### Inbound Message Factory

##### class ZerynthInboundMessageDeserializer

```#!py3 class ZerynthInboundMessageDeserializer(InboundMessageDeserializer.InboundMessageDeserializer)```

This class deserializes messages that the device receives from the WolkAbout IoT Platform from the topics it is subscribed to.

###### ZerynthInboundMessageDeserializer.deserialize_actuator_command

```#!py3 deserialize_actuator_command(message)```

Deserializes the `message` that was received from the WolkAbout IoT Platform.


* `message`: The message to be deserialized.

###### ZerynthInboundMessageDeserializer.deserialize_configuration_command

```#!py3 deserialize_configuration_command(message)```

Deserializes the `message` that was received from the WolkAbout IoT Platform.


* `message` The message to be deserialized.

## Wolk class

###### class Wolk

```#!py3 class Wolk()```

This class is a wrapper for the WolkCore class that passes the Zerynth compatible implementation of interfaces to the constructor


* `device`: Contains device key and password, and actuator references
* `host`: The address of the WolkAbout IoT Platform, defaults to the Demo instance
* `port`: The port to which to send messages, defaults to 1883
* `actuation_handler`: Implementation of the `ActuationHandler` interface
* `actuator_status_provider`: Implementation of the `ActuatorStatusProvider` interface
* `outbound_message_queue`: Implementation of the `OutboundMessageQueue` interface
* `configuration_handler`: Implementation of the `ConfigurationHandler` interface
* `configuration_provider`: Implementation of the `ConfigurationProvider` interface

###### Wolk.connect

```#!py3 connect()```

Connects the device to the WolkAbout IoT Platform by calling the provided connectivity_service’s `connect` method.

###### Wolk.disconnect

```#!py3 disconnect()```

Disconnects the device from the WolkAbout IoT Platform by calling the provided connectivity_service’s `disconnect` method.

###### Wolk.add_sensor_reading

```#!py3 add_sensor_reading(reference, value, timestamp=None)```

Publish a sensor reading to the platform.


* `reference`: String - The reference of the sensor
* `value`: Int, Float - The value of the sensor reading
* `timestamp`: (optional) Unix timestamp - if not provided, platform will assign one upon reception

###### Wolk.add_alarm

```#!py3 add_alarm(reference, active, timestamp=None)```

Publish an alarm to the platform


* `reference`: String - The reference of the alarm
* `active`: Bool - Current state of the alarm
* `timestamp`: (optional) Unix timestamp - if not provided, platform will assign one upon reception

###### Wolk.publish

```#!py3 publish()```

Publishes all currently stored messages and current actuator statuses to the platform.

###### Wolk.publish_actuator_status

```#!py3 publish_actuator_status(reference)```

Publish the current actuator status to the platform.


* `reference`: String - The reference of the actuator.

###### Wolk._on_inbound_message

```#!py3 _on_inbound_message(message)```

Callback method to handle inbound messages.

!!! note
	Pass this method to the implementation of `ConnectivityService` interface.


* `message`: The message received from the platform.

###### Wolk.publish_configuration

```#!py3 publish_configuration()```

Publishes the current device configuration to the platform.

### Device

##### class Device

```#!py3 class Device()```

The `Device` class contains all the required information for connecting to the WolkAbout IoT Platform.


* `key` - The device key obtained when creating the device on WolkAbout IoT platform
* `password` - The device password obtained when creating the device on WolkAbout IoT platform
* `actuator_references` - A list of actuator references defined in the device template on WolkAbout IoT Platform

### Actuation Handler

##### class .ActuationHandler

```#!py3 class ActuationHandler()```

This interface must be implemented in order to execute actuation commands issued from WolkAbout IoT Platform.

###### ActuationHandler.handle_actuation

```#!py3 handle_actuation(reference, value)```

This method will try to set the actuator, identified by `reference`, to the `value` specified by WolkAbout IoT Platform.

### Actuator Status Provider

##### class ActuatorStatusProvider

```#!py3 class ActuatorStatusProvider()```

This interface must be implemented in order to provide information about the current status of the actuator to the WolkAbout IoT Platform.

###### ActuatorStatusProvider.get_actuator_status

```#!py3 get_actuator_status(reference)```

This method will return the current actuator `state` and `value`, identified by `reference`, to the WolkAbout IoT Platform.

The possible states are:

```py
iot.ACTUATOR_STATE_READY
iot.ACTUATOR_STATE_BUSY
iot.ACTUATOR_STATE_ERROR
```

The method should return something like this:

```py
return (iot.ACTUATOR_STATE_READY, value)
```

### Configuration Handler

##### class ConfigurationHandler

```#!py3 class ConfigurationHandler()```

This interface must be implemented in order to handle configuration commands issued from WolkAbout IoT Platform.

###### ConfigurationHandler.handle_configuration

```#!py3 handle_configuration(configuration)```

This method should update device configuration with received configuration values.


* `configuration` - Dictionary that containes reference:value pairs.

### Configuration Provider

##### class ConfigurationProvider

```#!py3 class ConfigurationProvider()```

This interface must be implemented to provide information about the current configuration settings to the WolkAbout IoT Platform.

###### ConfigurationProvider.get_configuration

```#!py3 get_configuration()```

Reads current device configuration and returns it as a dictionary with device configuration reference as the key, and device configuration value as the value.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQ5NzY4Njg2XX0=
-->
