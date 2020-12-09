# Connect a Raspberry Pi or PC application to the Zerynth Device Manager

## ZDM Client Python Library

[Zerynth Device Manager](/latest/deploy/) can be used for orchestrating both MCU (microcontroller) and CPU (microprocessor) based devices. If you want to connect an MCU device like a Raspberry PI, an SBC (Single Board Computer) a PC, or any Python application in general, the ZDM Client Python Library is what you need.

### Installation

The latest stable version of the ZDM-Client Python Library is available on [PyPI](https://pypi.org/project/zdm-client-py/).

The installation assumes that you have installed the latest Python version with pip.

In order to install the ZDM-Client Python Library, type the following command or add the zdm-client-py into the requirements.txt file:

```pip install zdm-client-py```

If you want, you can also download the repository publicly available on GitHub:

```git clone https://github.com/zerynth/zdm-client-py.git```

Navigate to the download repo directory and create a virtual env using the command:

```virtualenv venv```

Install the python package locally:

```pip instal```

### Usage

Once you have installed the ZDM-client Python lib you can use it for connecting your CPU based device to the ZDM and stream your data.

**Login** to the ZDM in order to obtain the **device id** and the **password of a device** (see the [ZDM getting started guide](https://docs.zerynth.com/latest/gettingstarted/) for more info). 

Create a new file zdm_basic.py and copy the following script and replace the obtained device id and password in the placeholders.

```py
"""
zdm_basic.py

Show the basic example of a ZdmClient that sends a stream of messages to the ZDM.
Each message is published into a random tag with a random temperature value.

"""
import random
import time
import zdm

device_id = 'device_id'
password = 'password'


def pub_random():
    # this function is called periodically to publish to ZDM random int value labeled with tags values
    print('------ publish random ------')
    tags = ['tag1', 'tag2', 'tag3']

    for t in tags:
        value = random.randint(0, 20)
        payload = {
            'value': value
        }
        # publish payload to ZDM
        device.publish_data(t, payload)
        print('published on tag:', t, ':', payload)

    print('pub_random done')


def pub_temp_pressure():
    # this function publish another payload with two random int values
    print('---- publish temp_pressure ----')
    tag = 'tag4'
    temp = random.randint(19, 23)
    pressure = random.randint(50, 60)
    payload = {'temp': temp, 'pressure': pressure}
    device.publish_data(tag, payload)
    print('published on tag: ', tag, ':', payload)


device = zdm.ZDMClient(device_id=device_id)
device.set_password(password)
device.connect()

while True:
    time.sleep(2)
    pub_random()
    pub_temp_pressure()
```
Type the command:

```python zdm_basic.py```

Your first ZDM device will start sending random temperatures to three different tags (“tag1″, “tag2”, “tag3”) to the ZDM.

### Jobs

In addition, the  ZDM-client Python lib permits also to define a set of jobs on the client that can be invoked by the ZDM.

The jobs are passed to the ZDMClient as a dictionary, where the key is the name of the job and the value is the corresponding function to execute.

The example below illustrates a simple example of a client exposing one job named set_temp.

Upon the device receiving the Job, it executes the corresponding function and returns a result of a JSON object.

Copy the following script into a new file hello_jobs.py.

```py

# hello_jobs.py
import json
import time

from zdm import ZDMClient

device_id = '*** PUT YOU DEVICE ID HERE ***'
password = '*** PUT YOUR PASSWORD HERE ***'


def set_temp(zdmclient, args):
   # zdmclient: is the object of the ZdmClient.
   # args     : is a json with the arguments  of the function.
   print("Executing job set_temp. Received args: {}".format(args))
   # DO SOMETHING
   # return: a json with the result of the job.
   return json.dumps({"msg": "Temperature set correctly."})


# A dictionary of jobs where the key is the name of the job and value if the callback to execute.
my_jobs = {
   "set_temp": set_temp,
}

device = ZDMClient(device_id=device_id, jobs=my_jobs)
device.set_password(password)
device.connect()

while True:
   time.sleep(3)
```
Type the command:

```python hello_jobs.py```

Now, you can schedule the job in two different ways: by using the ZDM UI or the ZDM CLI.

### ZDM UI 

Steps needed to execute the job “set_led” on the device by using the ZDM UI:

- Login to the ZDM (https://zdm.zerynth.com/login).
- Click on the workspace where the device is associated.
- On the section “My Devices”, click the checkbox of the device.
- Click on the button “Jobs”, and on the popup select the job Name “set_temp”  in the Job Name dropdown menu.
- Add to the  “Arguments”  section any arguments of the function in json format (if any). For this example, you can leave the field empty.
- Click on “Launch Job” button.

### ZDM CLI

Steps needed to execute the job “set_led”  on the device by using the ZDM CLI.

Make sure you have configured the [ZDM CLI](/latest/deploy/Deploy%20and%20Manage/).

In order to schedule the job, type the following command (where the DEVICE_ID must be substituted with the actual id of the device):

```zdm job schedule set_temp <DEVICE_ID>```

### Expected result:

If the job has been correctly scheduled to the zdm client py, the following message will appear in the console:

```py
Executing job set_temp. Received args: {}

[INFO | zdmclient.py:185] > [DEVICE-ID] job set_temp executed with result res:{"msg": "Temperature set correctly."}
```
​
That’s all! Edit the script file and build your own ZDM powered IOT project!


