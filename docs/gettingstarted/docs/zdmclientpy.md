# How to connect Raspberry Pi and PC applications to the ZDM

Date: 07/2020

## ZDM Client Python Library

Zerynth Device Manager can be used for orchestrating both MCU (microcontroller) and CPU (microprocessor) based devices. 
If you want to connect an MCU device like a Raspberry PI, an SBC (Single Board Computer), a PC, 
or any Python application in general, the ZDM Client Python Library is what you need.

## How to install

The latest stable version of the [ZDM-Client Python Library](https://pypi.org/project/zdm-client-py/) is available on PyPI. 

The installation assumes that you have installed the latest Python version with pip.

In order to install the ZDM-Client Python Library, type the following command or add the **zdm-client-py**
into the *requirements.txt* file.

````shell
pip install zdm-client-py
````

!!!Note
    If you have an old version of the ZDM-Client Python Library, type this command to update to the version 1.0.0

##Usage

Once you have installed the ZDM-Client Python library
You can use it to connect your CPU based device to the ZDM and stream your data.

Login to the ZDM in order to obtain the device security configurations [(more details here)](zdmesp32.md).

Create a new project directory and paste the **zdevice.json** file inside, then create a Python file **zdm_basic.py** and paste this
simple code to start publishing random data to the ZDM.

````python
import zdm
import random
import time

def pub_temp_hum():
    # this function publish into the tag weather two random values: the temperature and the humidity
    tag = 'weather'
    temp = random.randint(19, 38)
    hum = random.randint(50, 70)
    payload = {'temp': temp, 'hum': hum}
    device.publish(payload, tag)
    print('Published: ', payload)


# connect to the ZDM using credentials in zdevice.json file
device = zdm.ZDMClient()
device.connect()

# infinite loop
while True:
    pub_temp_hum()
    time.sleep(5)
````

Type the command

````shell
python zdm_basic.py
````

to execute the python code, it will connect to the ZDM and start publishing data.

##Data visualization
1.  Go back to the **ZDM Web Interface**, open the device page clicking on the name in the devices table.
    Data sent by the device are visible here!
    
    [ ![](img/dataconsole.png) ](img/dataconsole.png)
    
    **Last hour activity** gives an idea of the device recent activity, the table below shows the published data.

