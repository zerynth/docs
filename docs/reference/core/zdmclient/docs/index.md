# Zerynth Device Manager Client

Zerynth Device Manager can be used for orchestrating both MCU (micro-controller) and CPU (micro-processor) based devices. 

If you want to connect a MCU device like a RapsberryPI, a SBC (Single Board Computer) a PC and any Python application general, the ZDM Client Python Library is what you need.

The Zerynth ZDM Client is a Python implementation of a client of the ZDM. It can be used to emulate a Zerynth device and connect it to the ZDM.


## class Credentials

```#!py3 class Credentials()```

Creates a Credentials instance that loads the provisioning information from the appropriate location. Provisioning information is saved in the zdevice.json file contained in the Zerynth project folder. Based on its content, the Credentials class is capable of loading or creating all the necessary pieces of information:

* ```device_id``` the unique identifier of the device in the ZDM
* ```credential_type``` the type of credentials to use (i.e. cloud token, device token, certificates, etc...)
* ```device_secret```, secret key. If empty, the secure element is used as key storage
* ```endpoint```, the mqtt broker address
* ```ca```, the ZDM root certificate

## class Config

```#!py3 class Config(keepalive=60, cycle_timeout=500, command_timeout=60000, clean_session=True, qos_publish=0, qos_subscribe=1)```

Creates a Config instance that set parameters for the connection to the MQTT broker. In particular, the following parameters are available:

* ```keepalive``` the MQTT keep alive timeout, in seconds
* ```cycle_timeout``` how long to block on the socket waiting for broker input, in milliseconds
* ```command_timeout```, how long to wait for a connect/disconnect command to finish, in milliseconds
* ```clean_session```, use MQTT clean session flag
* ```qos_publish```, the quality of service when publishing to the MQTT broker
* ```qos_subscribe```, the quality of service when subscribing to the MQTT broker

## class ZDMClient 

```#!py3 class ZDMClient(cred=None, cfg=None, jobs_dict={}, condition_tags=[], on_timestamp=None, on_open_conditions=None, verbose=False)```

Creates a ZDM client instance.

* ```cred``` is the object that contains the credentials of the device. If None the configurations are read from zdevice.json file.
* ```cfg``` is the object that contains the mqtt configurations. If None set the default configurations.
* ```jobs_dict``` is the dictionary that defines the device’s available jobs (default None).
* ```condition_tags``` is the list of condition tags that the device can open and close (default []).
* ```verbose``` boolean flag for verbose output (default False).
* ```on_timestamp``` callback called when the ZDM responds to the timestamp request. on_timestamp(client, timestamp)
* ```on_open_conditions``` callback called when the ZDM responds to the open conditions request. on_open_conditions(client, conditions)

### ZDMClient.id

```#!py3 id(pw)```

Return the device id.

### ZDMClient.connect

```#!py3 connect()```

Connect your device to the ZDM.

### ZDMClient.publish

```#!py3 publish(payload, tag)```

Publish a message to the ZDM.

* ```payload``` is a dictionary containing the payload.
* ```tag``` is the tag associated to the published payload.

### ZDMClient.publish

```#!py3 request_timestamp()```

Request the timestamp to the ZDM. When the timestamp is received, the callback ```on_timestamp``` is called.

### ZDMClient.publish

```#!py3 request_open_conditions()```

Request all the open conditions of the device not yet closed. When the open conditions are received, the callback on_open_conditions is called.

### ZDMClient.publish

```#!py3 new_condition(condition_tag)```

Create and return a new condition.

* ```condition_tag``` the tag as string of the new condition.

## class Condition

```#!py3 class Condition(client, tag)```

Creates a Condition on a tag.

* ```client``` is the object ZDMClient object used to open and close the condition.
* ```tag``` is the tag associated with the condition.

### Condition.open

```#!py3 open(payload, finish)```

Open a condition.

* ```payload``` is a dictionary containing custom data to associated with the open operation.
* ```start``` is a time (RFC3339) used to set the opening time. If None is automatically set with the current time.

### Condition.close

```#!py3 close(payload, finish)```

Close a condition.

* ```payload``` is a dictionary containing custom data to associated with the close operation.
* ```finish``` is a time (RFC3339) used to set the closing time. If None is automatically set with the current time.

### Condition.reset

```#!py3 reset()```

Reset the condition by generating a new id.

### Condition.is_open

```#!py3 is_open()```

Return True if the condition is open. False otherwise.
