# Examples

## Hello 4ZeroBox

```python
Hello 4ZeroBox
==============

The simplest example to be tried for starting with embedded development  

tags: [First Steps, Serial]
groups:[First Steps]
```

```python
###############################################################################
# Hello 4ZeroBox
#
# Created: 2020-09-10 15:45:48.789211
#
################################################################################

# import the streams module, it is needed to send data around
import streams
import sfw

# Set Watchdog timeout
sfw.watchdog(0, 60000)

# open the default serial port, the output will be visible in the serial console
streams.serial()  

# loop forever
while True:
    print("Hello Zerynth 4ZeroBox!")   # print automatically knows where to print!
    sleep(1000)
    # Reset Watchdog timer
    sfw.kick()
```


## Sensor Reading

```python
Sensor Reading
==============

This example shows how to initialize and configurate adc channels of the 4ZeroBox (Analog 4-20mA and 0-10V, Resistive, and current channels).
```

```python
################################################################################
# 4ZeroBox Sensor Reading
#
# Created: 2020-09-10 15:45:48.789211
#
################################################################################

import streams
import mcu
import json
import threading as th
import sfw
from fourzerobox import fourzerobox

# Lock for sync
core_sample_lock = th.Lock()
ready = True
# Set Watchdog timeout
sfw.watchdog(0, 60000)
# Init sys
streams.serial()
print('init')

# Reference table for no linear NTC sensor
ref_table = [329.5,247.7,188.5,144.1,111.3,86.43,67.77,53.41,42.47,33.90,27.28,22.05,17.96,14.69,12.09,10.00,8.313,
              6.940,5.827,4.911,4.160,3.536,3.020,2.588,2.228,1.924,1.668,1.451,1.266,1.108,0.9731,0.8572,0.7576]

# FourZero Var
fzbox = None
try:
    # Create FourZerobox Instance
    fzbox = fourzerobox.FourZeroBox(i2c_clk=100000)
except Exception as e:
    print(e)
    mcu.reset()

# Thread function for read sensor data and send them to the cloud
def read_event_handler():
    global ready

    while True:
        try:
            # Sync
            ready = True
            core_sample_lock.acquire()
            ready = False
            print("======== reading")
            # Read from 4-20mA channel1, resistive channel1, power channel1
            analog_val = fzbox.read_420(1)
            temperature = fzbox.read_resistive(1)
            power = fzbox.read_power(1)
            print(" - analog:", analog_val)
            print(" - temp:", temperature)
            print(" - power:", power)
            print("======== done")
            # reverse green blink each cycle
            fzbox.reverse_pulse('G',100)
        except Exception as e:
            print("Generic Error:", e)
            fzbox.error_cloud()
            mcu.reset()

print("core init...")
core_sample_lock.acquire()
    
try:
    print("adc config...")
    # Config FourZeroBox ADC channels 
    fzbox.config_adc_010_420(1, 3, 0)
    fzbox.config_adc_resistive(1, 2, 0)
    fzbox.config_adc_current(1, 2, 7)
    # Config FourZeroBox ADC conversion parameters
    fzbox.set_conversion_010_420(1, 0, 100, 0, 0, 100)
    fzbox.set_conversion_resistive(1, -50, ref_table, 5, 0, None)
    fzbox.set_conversion_current(1, 100, 5, 2000, 220, 0)
    print("adc config done")
except Exception as e:
    print(e)
    mcu.reset()

try:
    print("Start read_event_handler thread")
    thread(read_event_handler)
    print('start main')
    # Main Loop
    while True:
        sleep(10000)
        # Sync between main thread and pub_event_handler thread 
        if ready:
            core_sample_lock.release()
            # Reset Watchdog timer
            sfw.kick()
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()
```

## Modbus Serial Interface

```python
Modbus Serial Interface
=======================

This example shows how to initialize and establish a serial modbus communication
```
```python
###############################################################################
# Modbus Serial Interface
#
# Created: 2020-09-10 15:45:48.789211
#
################################################################################

from modbus import modbus
import streams
import gpio
from fourzerobox import fourzerobox
import sfw

streams.serial()

# Set Watchdog timeout
sfw.watchdog(0, 60000)

# RS485 class with read, write, close as requested by Zerynth Modbus Library
class RS485_4zbox():
    def __init__(self, baud):
       gpio.mode(fourzerobox.RS485EN, OUTPUT)
       gpio.low(fourzerobox.RS485EN)
       self.port = streams.serial(drvname=SERIAL1, baud=baud, set_default=False)
    
    def read(self):
        bc = self.port.available()
        return self.port.read(bc)

    def write(self, packet):
        gpio.high(fourzerobox.RS485EN)
        self.port.write(packet)
        gpio.low(fourzerobox.RS485EN)

    def close(self):
        self.port.close()

def Write_One_Register(master, address, values=None, num=None):
    if (values == None and num == None):
        raise ValueError
    if (values != None):
        num = 0
        for i in range(len(values)):
            num += values[i] << i
    if (num > 0xffff):
        raise ValueError
    result = master.write_register(address, num)
    if (result == 1):
        print("Register", address, "successfully written")
    else:
        print("Register ", address, " writing failed")
    return result

def Read_One_Register(master, address):
    num = master.read_holding(address, 1)[0]
    out = []
    for i in range(10):
        out.append(num>>i & 1)
    return out
    
try:
    fzbox = fourzerobox.FourZeroBox(i2c_clk=100000)
    print("fzbox init")
    rs485 = RS485_4zbox(9600)
    print("rs485 created")
    
    # change the identifier (slave address) if needed
    master_in =  modbus.ModbusSerial(identifier=1, serial_device=rs485)
    
    # write list of bits on register with address 2 (chage it if needed)
    result = Write_One_Register(master_in, 2, values=[1, 0, 1, 0, 0, 0, 0, 0, 0, 0]) # max number of values is 16 elements  -> register 16 bit
    print("writing register 2 ... ")
    # read register 2 and check the result
    result = Read_One_Register(master_in, 2)
    print("Get input register 2: ", result)
    
    # write single num value on register with address 3 (chage it if needed)
    result = Write_One_Register(master_in, 3, num=3)
    # read register 3 and check the result
    result = Read_One_Register(master_in, 3)
    print("Get input register 3: ", result)
    
    sfw.kick()
except Exception as e:
    print("Exception ", e)
    master_in.close()
```

## 4ZeroBox meets ZDM

```python
4ZeroBox meets ZDM
==================

Basic example to connect 4ZeroBox to the Zerynth Device Manager sending data to the cloud service
```
```python
###############################################################################
# 4ZeroBox meets ZDM
#
# Created: 2020-09-10 15:45:48.789211
#
###############################################################################

from bsp.drivers import wifi
import streams
from zdm import zdm
import threading as th
import sfw
import mcu
from fourzerobox import fourzerobox

# Lock for sync
core_sample_lock = th.Lock()
ready = True

# Set Watchdog timeout
sfw.watchdog(0, 60000)

# Init sys
streams.serial()
print('init')

# Reference table for no linear NTC sensor
ref_table = [329.5,247.7,188.5,144.1,111.3,86.43,67.77,53.41,42.47,33.90,27.28,22.05,17.96,14.69,12.09,10.00,8.313,
              6.940,5.827,4.911,4.160,3.536,3.020,2.588,2.228,1.924,1.668,1.451,1.266,1.108,0.9731,0.8572,0.7576]

# FourZero Var
fzbox = None

try:
    # Create FourZerobox Instance
    fzbox = fourzerobox.FourZeroBox(i2c_clk=100000)
except Exception as e:
    print(e)
    mcu.reset()

def pub_event_handler():
    global ready
    while True:
        try:
            # Sync
            ready = True
            core_sample_lock.acquire()
            ready = False
            print("======== reading")
            # Read from 4-20mA channel1, resistive channel1
            analog_val = fzbox.read_420(1)
            temperature = fzbox.read_resistive(1)
            print(" - temp:", temperature)
            print(" - analog:", analog_val)
            # Organize data in json dict
            to_send = {}
            to_send['temp'] = temperature
            to_send['analog'] = analog_val
            print("======== done")
            # Publish data to ZDM cloud service
            device.publish(to_send, "data")
            sleep(100)
            rssi = fzbox.get_rssi()
            # yellow blink if low signal, green blink otherwise
            if rssi < -70:
                fzbox.reverse_pulse('Y',100)
            else:
                fzbox.reverse_pulse('G',100)
        except Exception as e:
            print('Publish exception: ', e)
            fzbox.error_cloud()
            mcu.reset()
try:
    # connection to wifi network
    fzbox.net_init()
    print("Connecting to wifi ...")
    fzbox.net_connect("SSID","PWD")
    print("... done")
    print("Connecting to ZDM ...")
    device = zdm.Device()
    # connect the device to the ZDM
    device.connect()
    print("... done")
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()

core_sample_lock.acquire()
try:
    print("adc config...")
    # Config FourZeroBox ADC channels 
    fzbox.config_adc_010_420(1, 3, 0)
    fzbox.config_adc_resistive(1, 2, 0)
    # Config FourZeroBox ADC conversion parameters
    fzbox.set_conversion_010_420(1, 0, 100, 0, 0, 100)
    fzbox.set_conversion_resistive(1, -50, ref_table, 5, 0, None)
    print("adc config done")
except Exception as e:
    print(e)
    mcu.reset()

try:
    print("core init done")
    # Start read_event_handler thread
    thread(pub_event_handler)
    print('start main')
    # Main Loop
    while True:
        sleep(10000)
        # Sync between main thread and pub_event_handler thread 
        if ready:
            core_sample_lock.release()
            # Reset Watchdog timer
            sfw.kick()
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()
```

## 4ZeroBox meets ZDM with GSM

```python
4ZeroBox meets ZDM with GSM
===========================

Basic example to connect 4ZeroBox to the Zerynth Device Manager, with GSM connectivity, sending data to the cloud service
```
```python
###############################################################################
# 4ZeroBox meets ZDM with GSM
#
# Created: 2020-09-10 15:45:48.789211
#
###############################################################################

from bsp.drivers import gsm
import streams
from zdm import zdm
import threading as th
import sfw
import mcu
from fourzerobox import fourzerobox

# Lock for sync
core_sample_lock = th.Lock()
ready = True

# Set Watchdog timeout
sfw.watchdog(0, 60000)

# Init sys
streams.serial()
print('init')

# Reference table for no linear NTC sensor
ref_table = [329.5,247.7,188.5,144.1,111.3,86.43,67.77,53.41,42.47,33.90,27.28,22.05,17.96,14.69,12.09,10.00,8.313,
              6.940,5.827,4.911,4.160,3.536,3.020,2.588,2.228,1.924,1.668,1.451,1.266,1.108,0.9731,0.8572,0.7576]

# FourZero Var
fzbox = None

try:
    # Create FourZerobox Instance
    fzbox = fourzerobox.FourZeroBox(i2c_clk=100000)
except Exception as e:
    print(e)
    mcu.reset()

def pub_event_handler():
    global ready
    while True:
        try:
            # Sync
            ready = True
            core_sample_lock.acquire()
            ready = False
            print("======== reading")
            # Read from 4-20mA channel1, resistive channel1
            analog_val = fzbox.read_420(1)
            temperature = fzbox.read_resistive(1)
            print(" - temp:", temperature)
            print(" - analog:", analog_val)
            # Organize data in json dict
            to_send = {}
            to_send['temp'] = temperature
            to_send['analog'] = analog_val
            print("======== done")
            # Publish data to ZDM cloud service
            device.publish(to_send, "data")
            sleep(100)
            rssi = fzbox.get_rssi()
            if rssi < -70:
                fzbox.reverse_pulse('Y',100)
            else:
                fzbox.reverse_pulse('G',100)
        except Exception as e:
            print('Publish exception: ', e)
            fzbox.error_cloud()
            mcu.reset()
try:
    fzbox.net_init()
    print("attaching ...")
    fzbox.net_connect("apn")
    print("... done")
    print("Connecting to ZDM ...")
    device = zdm.Device()
    # connect the device to the ZDM
    device.connect()
    print("... done")
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)

core_sample_lock.acquire()
try:
    print("adc config...")
    # Config FourZeroBox ADC channels 
    fzbox.config_adc_010_420(1, 3, 0)
    fzbox.config_adc_resistive(1, 2, 0)
    # Config FourZeroBox ADC conversion parameters
    fzbox.set_conversion_010_420(1, 0, 100, 0, 0, 100)
    fzbox.set_conversion_resistive(1, -50, ref_table, 5, 0, None)
    print("adc config done")
except Exception as e:
    print(e)
    mcu.reset()

try:
    print("core init done")
    # Start read_event_handler thread
    thread(pub_event_handler)
    print('start main')
    # Main Loop
    while True:
        sleep(10000)
        # Sync between main thread and pub_event_handler thread 
        if ready:
            core_sample_lock.release()
            # Reset Watchdog timer
            sfw.kick()
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()
```

## Firmware Over The Air Update

```python
Firmware Over The Air Update
============================

Connect your 4ZeroBox to ZDM and start updating the firmware seamlessly.

In this example, a FOTA callback function is defined, which is called during the FOTA update steps.
The FOTA callback allows you to accept or refuse a FOTA from your devices using the return value.
If the callback returns True the device will accept the FOTA update requests, if the callback return False
the device will refuse it.

Try to edit the function e do your tests using ZDM FOTA commands.
```
```python
###############################################################################
# Firmware Over The Air Update
#
# Created: 2020-09-10 15:45:48.789211
#
###############################################################################

from bsp.drivers import wifi
import streams
from zdm import zdm
import threading as th
import sfw
import mcu
from fourzerobox import fourzerobox

# Lock for sync
core_sample_lock = th.Lock()
ready = True
# Set Watchdog timeout
sfw.watchdog(0, 60000)
# Init sys
streams.serial()
print('init')

# firmware version to change and check after the FOTA procedure
fw_version = "v01"
# Reference table for no linear NTC sensor
ref_table = [329.5,247.7,188.5,144.1,111.3,86.43,67.77,53.41,42.47,33.90,27.28,22.05,17.96,14.69,12.09,10.00,8.313,
              6.940,5.827,4.911,4.160,3.536,3.020,2.588,2.228,1.924,1.668,1.451,1.266,1.108,0.9731,0.8572,0.7576]

# FourZero Var
fzbox = None

try:
    # Create FourZerobox Instance
    fzbox = fourzerobox.FourZeroBox(i2c_clk=100000)
except Exception as e:
    print(e)
    mcu.reset()

def pub_event_handler():
    global ready
    while True:
        try:
            # Sync
            ready = True
            core_sample_lock.acquire()
            ready = False
            print("======== reading")
            # Read from 4-20mA channel1, resistive channel1, power channel1
            analog_val = fzbox.read_420(1)
            temperature = fzbox.read_resistive(1)
            print(" - temp:", temperature)
            print(" - analog:", analog_val)
            # Organize data in json dict
            to_send = {}
            to_send['temp'] = temperature
            to_send['analog'] = analog_val
            print("======== done")
            # Publish data to 4ZeroManager cloud service
            device.publish(to_send, "data")
            sleep(100)
            rssi = fzbox.get_rssi()
            if rssi < -70:
                fzbox.reverse_pulse('Y',100)
            else:
                fzbox.reverse_pulse('G',100)            
        except Exception as e:
            print('Publish exception: ', e)
            fzbox.error_cloud()
            mcu.reset()

# remote color blink
def jblink(device, arg):
    if "led" in arg:
        if  arg["led"] in ['R','G','B','M','Y','C','W']:
            fzbox.reverse_pulse(arg["led"],100)
            return {"res": "OK"}
        else:
            return {"error": "bad args"}

# remote async read sensor
def jread(device, arg):
    if "var" in arg:
        if arg["var"] == "analog":
            val = fzbox.read_420(1)
        elif arg["var"] == "temp":
            val = fzbox.read_resistive(1)
        else:
            val = "error"
        return {arg["var"]: val}

# custom jobs
my_jobs = {
    'blink': jblink,
    'read_async': jread,
}

try:
    fzbox.net_init()
    print("Connecting to wifi ...")
    fzbox.net_connect("SSID","PWD")
    print("... done")
    print("Connecting to ZDM ...")
    device = zdm.Device()
    # connect the device to the ZDM
    device.connect()
    print("... done")
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()

core_sample_lock.acquire()
try:
    print("adc config...")
    # Config FourZeroBox ADC channels 
    fzbox.config_adc_010_420(1, 3, 0)
    fzbox.config_adc_resistive(1, 2, 0)
    # Config FourZeroBox ADC conversion parameters
    fzbox.set_conversion_010_420(1, 0, 100, 0, 0, 100)
    fzbox.set_conversion_resistive(1, -50, ref_table, 5, 0, None)
    print("adc config done")
except Exception as e:
    print(e)
    mcu.reset()

try:
    print("core init done")
    # Start read_event_handler thread
    thread(pub_event_handler)
    print('start main')
    # Main Loop
    while True:
        print("Hello! firmware running version", fw_version)
        sleep(10000)
        # Sync between main thread and pub_event_handler thread 
        if ready:
            core_sample_lock.release()
            # Reset Watchdog timer
            sfw.kick()
except Exception as e:
    print (e)
    fzbox.pulse('R', 10000)
    mcu.reset()
    ```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQxNDMyNjI2LC0xMjk5NDIxNDcyLDE1Nj
E2MzQ2MDYsNzMwOTk4MTE2XX0=
-->