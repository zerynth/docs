# ZDM Client Python Library

Zerynth Device Manager can be used for orchestrating both MCU (micro-controller) and CPU (micro-processor) based devices.
If you want to connect a MCU device like a RaspberryPI, a SBC (Single Board Computer) a PC and any Python application general,
the **ZDM Client Python Library** is what you need.


## Installation
The latest stable version of the ZDM-Client Python Library is available on [PyPI](https://pypi.org/project/zdm-client-py/)

!!! Note
    The ZDM-Client Python library requires Python>=3

In order to install the ZDM-Client Python Library, type the following command:

``` sh
pip install zdm-client-py
```

If you want, you can also download the repository publicly available on GitHub.

```sh
git clone https://github.com/zerynth/zdm-client-py.git
```

navigate to the download repo directory and create a virtual env using the command

```sh
virtualenv venv
```

And install the python package locally.

```sh 
pip install .
```

## Usage
The ZDM-Client Python library can be used  as follows:

``` python
import zdm

device_id = '***Device-id***'
password = '***Device-password**'


# Create a ZDM client
device = zdm.ZDMClient(device_id=device_id)
device.set_password(password)
# Connect the device to the ZDM
device.connect()

while True:
    # Publish data
    device.publish({"hello":"world", "test")
    time.sleep(2)
```




## The  ZDMClient class
``` zdm.ZDMClient(device_id, endpoint=ENDPOINT, jobs=None, condition_tags=[], verbose=False, on_timestamp=None, on_open_conditions=None)```

Creates a ZDM client instance with device id `device_id`. All other parameters are optional and have default values.


* `device_id` is the id of the device.
* `endpoint` is the url of the ZDM broker (default mqtt.zdm.zerynth.com).
* `jobs` is the dictionary that defines the device’s available jobs (default None).
* `condition_tags` is the list of condition tags that the device can open and close (default []).
* `verbose` boolean flag for verbose output (default False).
* `on_timestamp` called when the ZDM responds to the timestamp request.  Callback syntax on_timestamp(client, timestamp)
* `on_open_conditions` called when the ZDM responds to the open conditions request. Callback syntax  on_open_conditions(client, conditions)


### `id()`
Return the device id.


### connect()
Connect the device to the ZDM.
You must set device’s password first.


### set_password(pw)
Set the device password to `pw`. You can generate a password using the ZDM.


### publish(data, tag)
Publish teh data to the ZDM.


* `data`, is a dictionary tha contains the message to be published
* `tag`, is a string representing the tag where the data is published.

### request_timestamp()
Send a request to the ZDM to obtain the timestamp.


### request_open_conditions()
Send a request to the ZDM to obtain the current open conditions.


### new_condition()
Create and return a new condition.

 * `condition_tag`, the tag of the new condition.


## The Condition class
```class Conditions(client. tag)```
Creates a new Condition assocaited to a tag.

* `client` is the reference to a ZDMClient object
* `tag` is the tag of the condition

### `open(payload=None, start=None)`
Open the condition.

* `payload`, a dictionary for associating additional data to the opened condition (default None).
* `start`, a date time (rfc3339) used to  set the start time, If None the current timestamp is used (default None).


###  `close(payload=None, start=None)`
Close the condition.


* `payload`, a dictionary for associating additional data to the closed condition. Default None.
* `finish`, a date time (rfc3339) used to  set the finish time of the condition. If None the current timestamp is used. Default None.


### `reset()`
Reset the condition by generatung a new id and resetting the start and end time.


### `is_open()`
Return True if the condition is open. False otherwise.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3NjQ0ODk0MTBdfQ==
-->