# Examples

The following are a list of examples for lib.zerynth.zdm.

## Simple ZDM


In this example you can see how to create a ZDM device and connect it to the Zerynth Device Manager and send periodically data. It simulates a weather sensor that sends temperature and pressure values to the ZDM periodically.

You can use this example to test ZDM Webhooks and Ubidots integration.

To check if the ZDM is correctly receiving data sent by your device, use the data ZDM command.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################

from bsp.drivers import wifi
import streams
from zdm import zdm


def pub_temp_hum():
    # this function publish into the tag weather two values: the temperature and the humidity
    tag = 'weather'
    temp = random(19, 38)
    hum = random(50, 70)
    payload = {'temp': temp, 'hum': hum}
    device.publish(payload, tag)
    print('Published: ', payload)


streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")

    # Create a ZDM Device
    device = zdm.Device()
    # connect the device to the ZDM
    device.connect()

    while True:
        pub_temp_hum()
        sleep(5000)

except Exception as e:
    print("main", e)

```
## ZDM Jobs


A basic example showing ZDM Jobs and how to handle them. Write your own jobs, then add them in the jobs dictionary with a custom key.

Once your device is connected to the ZDM, you can send it job commands using the key you defined and your device will execute functions remotely.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################

import streams
from bsp.drivers import wifi
from zdm import zdm


# This job generates and returns a random number
def job_random(device, arg):
    print("Executing Job random ...")
    return {
        'rnd': random(0, 100),
    }


# This job adds two numbers (num1, num2) and return the result.
def job_adder(device, arg):
    print("Executing Job adder ...")
    if "num1" in arg and "num2" in arg:
        res = arg['num1'] + arg["num2"]
        return {"res": res}
    else:
        return {"err": "Bad arguments. Arguments 'num1' and 'num2' must be provided."}


# define the list of jobs exposed by the device.
# A job is a function that receives two parameters (the device instance itself, and the arguments in a dictionary)
# and returns the result as a dictionary.
my_jobs = {
    'jobRandom': job_random,
    'jobAdder': job_adder,
}

streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")

    # create a ZDM Device instance and pass to it the the jobs dictionary
    device = zdm.Device(jobs_dict=my_jobs)

    # connect your device to ZDM enabling the device to receive incoming messages
    device.connect()

    while True:
        print("Waiting for jobs...")
        sleep(5000)

except Exception as e:
    print("main", e)
```
## FOTA Updates


Connect your device to ZDM and start updating the firmware seamlessly. In this example you can see how to create a ZDM device and connect it to the Zerynth Device Manager.

In this example, a FOTA callback function is defined, which is called during the FOTA update steps. The FOTA callback allows you to accept or refuse a FOTA from your devices using the return value. If the callback returns True the device will accept the FOTA update requests, if the callback return False
the device will refuse it.

Try to edit the function e do your tests using ZDM FOTA commands.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################

from bsp.drivers import wifi
import streams
from zdm import zdm


def fota_callback(fw_version):
    # This function is called in order to let the user define if the fota process can be accepted.
    # The parameter is the new firmware version that is going to be installed.
    # If it returns True the FOTA is accepted.
    # If it returns False the FOTA is refused.
    print("Fota callback called with firmware version: ", fw_version)
    return True


streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")


    # Create a ZDM Device instance and define the fota callback. The default fota callback function returns always True.
    device = zdm.Device(fota_callback=fota_callback)
    device.connect()

    while True:
        sleep(1000)

except Exception as e:
    print("main", e)
```
## ZDM_Conditions


The conditions is an event that has a duration (with an open or closed status). It differs from the status maintained in the device, because with the conditions you can have the history. 


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################


# The example show how to use the conditions for monitoring the charge of a battery.
# If the battery level goes under a certain threshold a new condition is opened, and closed when the given threshold is again reached.
# The example uses four different conditions on the same tag for controlling four different battery charge levels.
# 60% - 80% : info
# 40% - 60% : warning
# 20% - 40% : critical
# 0% -  20% : fatal
# Initially, the battery is 100%.
# Then, every second the level of the battery is decreased, and whenever the battery is running low a certain recharge level,
# the corresponding condition is opened (E.g., when the battery reaches 80% the INFO condition is opened).
# When the battery runs below 10%, the battery is set on recharge state.
# In recharge mode, the battery level id increased, and whenever the level reach a certain recharge level, the previous condition is closed.
# (e.g., when the battery is recharged and the level is 40% the CRITICAL condition is closed).

import streams
from bsp.drivers import wifi
from zdm import zdm

streams.serial()

# this function is executed when the current open conditions (that are not closed) are received by the ZDM
# In this example, all the open conditions are closed.
def my_open_conditions(device, conditions):
    print("Received open conditions:", len(conditions))
    for c in conditions:
        print("CLOSING ", c)
        c.close()


try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")

    # Condition tag where the conditions are opened and closed
    condition_tag = "battery"

    # create a ZDM Device instance
    device = zdm.Device(condition_tags=[condition_tag], on_open_conditions=my_open_conditions)

    device.connect()

    # Create four conditions fot the same tag.
    infoLevel = device.new_condition(condition_tag)
    warningLevel = device.new_condition(condition_tag)
    criticalLevel = device.new_condition(condition_tag)
    fatalLevel = device.new_condition(condition_tag)

    # device request the open conditions
    device.request_open_conditions()

    # store store the initial battery level (100%)
    battery_lvl_curr = 100
    # store the previous  battery level
    battery_lvl_prv = 100

    # indicate if the battery is in the recharge state (True) or not (False)
    recharge = False
    done = False

    while not done:
        print("Battery level:", battery_lvl_curr)
        if battery_lvl_curr > 80:
            if recharge and infoLevel.is_open():
                print("[INFO] close condition")
                infoLevel.close(payload={"status": "INFO", "lvl": battery_lvl_curr})
                done = True

        elif 60 < battery_lvl_curr <= 80:
            if not recharge and not infoLevel.is_open():
                print("[INFO] open condition")
                infoLevel.open(payload={"status": "INFO", "lvl": battery_lvl_curr})
            else:
                if warningLevel.is_open():
                    print("[WARNING] close condition")
                    warningLevel.close(payload={"status": "WARNING", "lvl": battery_lvl_curr})

        elif 40 < battery_lvl_curr <= 60:
            if not recharge and not warningLevel.is_open():
                print("[WARNING] open condition")
                warningLevel.open(payload={"status": "WARNING", "lvl": battery_lvl_curr})
            else:
                if criticalLevel.is_open():
                    print("[CRITICAL] close condition")
                    criticalLevel.close(payload={"status": "CRITICAL", "lvl": battery_lvl_curr})

        elif 20 < battery_lvl_curr <= 40:
            if not recharge and not criticalLevel.is_open():
                print("[CRITICAL] open condition")
                criticalLevel.open(payload={"status": "CRITICAL", "lvl": battery_lvl_curr})
            else:
                if fatalLevel.is_open():
                    print("[FATAL] close condition")
                    fatalLevel.close(payload={"status": "FATAL", "lvl": battery_lvl_curr})

        elif 10 < battery_lvl_curr <= 20:
            if not recharge and not fatalLevel.is_open():
                print("[FATAL] open condition")
                fatalLevel.open(payload={"status": "FATAL", "lvl": battery_lvl_curr})

        elif 0 < battery_lvl_curr <= 10:
            print("Recharging battery...")
            recharge = True

        battery_lvl_prv = battery_lvl_curr
        if recharge:
            battery_lvl_curr = battery_lvl_curr + 5
        else:
            battery_lvl_curr = battery_lvl_curr - 5

        sleep(2000)

except Exception as e:
    print("main", e)
```
## ZDM_Advanced


This is an advanced example aimed at showing all the ZDM functionalities integrated in an embedded firmware. The example simulates the use of the ZDM in an industrial IOT scenario where industrial machines are monitored via sensors interfaced with zerynth powered boards

In this example we simulate the acquisition of 3 variables from 2 industrial machines (a CNC and an industrial pump). The setup also includes two relays used to control a Red and a Green light indicators placed near the machine. The lights are used to notify the operator on remote alarms sent directly by the ZDM as jobs.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Author: E.Neri, D.Mazzei
###############################################################################


import streams
from bsp.drivers import wifi
from zdm import zdm
import monitor


# *** Write here your wifi ssid and password
WIFI_SSID = '***Wifi-ssid***'
WIFI_PASSWORD = '***Wifi-password***'

monitor = monitor.machinesMonitor()

# cnc and pump period indicates the interval in seconds between two data publish for each machine
cncPeriod = 10
pumpPeriod = 10


# this bool variables [default=false] are set remotely using jobs below
# when True, device sends also instantaneous values for the associated machine
instantCnc = False
instantPump = False

# acceptFOTA [default True] indicates if the device Fota si enabled or not
acceptFOTA = True

# jobs
def enable_instant_cnc():
    global instantCnc
    instantCnc = True
    return "instant cnc enabled"
def disable_instant_cnc():
    global instantCnc
    instantCnc = False
    return "instant cnc disabled"

def enable_instant_pump():
    global instantPump
    instantPump = True
    return "instant pump enabled"
def disable_instant_pump():
    global instantPump
    instantPump = False
    return "instant pump disabled"

# to set cnc period use the command set_cnc_period --arg period 12 device_id
def set_cnc_period(obj, args):
    if not('period' in args['args']) or args['args']['period'] is None:
        return "use zmd set_cnc_period --arg period [int] [device_id]"
    global cncPeriod
    monitor.resetCncVariables()
    monitor.resetCncCounter()
    cncPeriod = args['args']['period']
    print("CNC period set remotely. New value:", cncPeriod)
    return "CNC period set"

# to set pump period use the command set_pump_period --arg period 12 device_id
def set_pump_period(obj, args):
    if not('period' in args['args']) or args['args']['period'] is None:
        return "use zmd set_pump_period --arg period [int] [device_id]"
    global pumpPeriod
    monitor.resetPumpVariables()
    monitor.resetPumpCounter()
    pumpPeriod = args['args']['period']
    print("Pump period set remotely. New value:", pumpPeriod)
    return "Pump period set"

# turn on green lamp
def green_lamp_on():
    print("###### GREEN LAMP IS ON ######")
    return "green lamp ON"

# turn off green lamp
def green_lamp_off():
    print("###### GREEN LAMP IS OFF ######")
    return "green lamp OFF"

# turn on red lamp
def red_lamp_on():
    print("###### RED LAMP IS ON ######")
    return "red lamp ON"

#turn off red lamp
def red_lamp_off():
    print("###### RED LAMP IS OFF ######")
    return "red lamp OFF"

# to set cnc temp threshold use the command zdm cnc_temp_threshold --arg threshold [int] [device_id]
def cnc_temp_threshold(obj, args):
    if not('threshold' in args['args']) or args['args']['threshold'] is None:
        return "use zdm cnc_temp_threshold --arg threshold [int] [device_id]"
    monitor.setCncTempThreshold(args['args']['threshold'])
    print("CNC temp threshold set")
    return "CNC temp threshold set"

# to set cnc amp threshold use the command zdm cnc_amp_threshold --arg threshold [int] [device_id]
def cnc_amp_threshold(obj, args):
    if not('threshold' in args['args']) or args['args']['threshold'] is None:
        return "use zdm cnc_amp_threshold --arg threshold [int] [device_id]"
    monitor.setCncAmpThreshold(args['args']['threshold'])
    print("CNC amp threshold set")
    return "CNC amp threshold set"

# to set pump temp threshold use the command zdm pump_temp_threshold --arg threshold [int] [device_id]
def pump_temp_threshold(obj, args):
    if not('threshold' in args['args']) or args['args']['threshold'] is None:
        return "use zdm pump_temp_threshold --arg threshold [int] [device_id]"
    monitor.setPumpTempThreshold(args['args']['threshold'])
    print("Pump temp threshold set")
    return "Pump temp threshold set"

# to set cnc amp threshold use the command zdm cnc_amp_threshold --arg threshold [int] [device_id]
def pump_amp_threshold(obj, args):
    if not('threshold' in args['args']) or args['args']['threshold'] is None:
        return "use zdm pump_amp_threshold --arg threshold [int] [device_id]"
    monitor.setPumpAmpThreshold(args['args']['threshold'])
    print("Pump amp threshold set")
    return "Pump amp threshold set"

# toggleAcceptFota is a job used to change the acceptFOTA variable
def toggleAcceptFota():
    global acceptFOTA
    if acceptFOTA == True:
        acceptFOTA = False
        return "acceptFOTA: false"
    else:
        acceptFOTA = True
        return "acceptFOTA: true"

# you can call your jobs using ZDM using names enable_instant_cnc,
# disable_instant_cnc, enable_instant_pump, disable_instant_pump
jobs = {
    'enable_instant_cnc': enable_instant_cnc,
    'disable_instant_cnc': disable_instant_cnc,
    'enable_instant_pump': enable_instant_pump,
    'disable_instant_pump': disable_instant_pump,
    'set_cnc_period': set_cnc_period,
    'set_pump_period': set_pump_period,
    'green_lamp_on': green_lamp_on,
    'green_lamp_off': green_lamp_off,
    'red_lamp_on': red_lamp_on,
    'red_lamp_off': red_lamp_off,
    'cnc_temp_threshold': cnc_temp_threshold,
    'cnc_amp_threshold': cnc_amp_threshold,
    'pump_temp_threshold': pump_temp_threshold,
    'pump_amp_threshold': pump_amp_threshold,
    'toggle_accept_fota': toggleAcceptFota
}

# collectCNCData - returns a dict with three random values [temp, vibration, ampere]
def collectCNCData(cncAmpereCond, cncTempCond):
    temp = random(10, 100)
    vibration = random(-3, 3)
    ampere = random(0, 15)

    data = {
        'temp': temp,
        'vibration': vibration,
        'ampere': ampere
    }

    if temp >= monitor.cncTempThres:
        if not cncTempCond.is_open():
            value = {"name":"CNC temp threshold", "message": "cnc temp treshold reached"}
            cncTempCond.open(value)
            print("CNC Temp threshold reached! Event sent")
    else:
        if cncTempCond.is_open():
            cncTempCond.close(payload={"name":"CNC temp threshold", "message": "cnc temp "})
            print("CNC Temp threshold reached! close condition")

    if ampere >= monitor.cncAmpThres:
        if not cncAmpereCond.is_open():
            cncAmpereCond.open(payload={"name":"CNC Amp threshold", "message": "cnc amp treshold reached"})
            print("CNC Amp threshold reached! Open Condition")
    else:
        if cncAmpereCond.is_open():
            cncAmpereCond.close()
            print("CNC Amp threshold reached! Close condition")

    return data

# collectPumpData - returns a dict with three random values [temp, press, ampere]
def collectPumpData(pumpAmpereCondition, pumpTempCond):
    temp = random(10, 100)
    press = random(0, 20)
    ampere = random(0, 15)

    data = {
        'temp': temp,
        'press': press,
        'ampere': ampere
    }

    if temp >= monitor.pumpTempThres:
        if not pumpTempCond.is_open():
            value = {"name":"Pump temp threshold", "message": "pump temp treshold reached" }
            pumpTempCond.open(value)
            print("Pump Temp threshold reached! Open Condition")
    else:
        if pumpTempCond.is_open():
            pumpTempCond.close()
            print("Pump Temp threshold reached! Close Condition")


    if ampere >= monitor.pumpAmpThres:
        if not pumpAmpereCondition.is_open():
            value = {"name":"Pump amp threshold", "message": "Pump amp treshold reached" }
            pumpAmpereCondition.open(value)
            print("Pump Amp threshold reached! Open Condition")
    else:
        if pumpAmpereCondition.is_open():
            pumpAmpereCondition.close()
            print("Pump Amp threshold reached! Close Condition")


    return data

# publishCncData publishes to the ZDM cnc payload generated by the machines monitor
def publishCncData():
    cncPayload = monitor.getCncPayload()

    device.publish(cncPayload, monitor.cncTag)

    print("CNC data published:")
    print(cncPayload)


def publishPumpData():
    pumpPayload = monitor.getPumpPayload()

    device.publish(pumpPayload, monitor.pumpTag)

    print("Pump data published:")
    print(pumpPayload)


# publishInstantCnc publishes to the ZDM instantenous CNC values
def publishInstantCnc(cnc):
    cncPayload = {
        'instCncTemp': cnc['temp'],
        'instCncVibration': cnc['vibration'],
        'instCncAmpere': cnc['ampere']
    }
    device.publish(cncPayload, monitor.cncTag)
    print("Instant CNC values published:", cncPayload)

# publishInstantPump publishes to the ZDM instantenous pump values
def publishInstantPump(pump):
    pumpPayload = {
        'instPumpTemp': pump['temp'],
        'instPumpPress': pump['press'],
        'instPumpAmpere': pump['ampere']
    }
    device.publish(pumpPayload, monitor.pumpTag)
    print("Instant pump values published:", pumpPayload)

def fotaCallback():
    global acceptFOTA
    if acceptFOTA == True:
        return True
    else:
        return False

streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link(WIFI_SSID, interface.WIFI_WPA2, WIFI_PASSWORD)
    print("Connect wifi done")

    # Tags used for the conditions
    cnc_ampere_tag = "cnc_amp"
    cnc_temp_tag = "cnc_temp"
    pump_ampere_tag = "pump_amp"
    pump_temp_tag = "pump_temp"

    # create a ZDM Device instance with id and the custom jobs
    device = zdm.Device(condition_tags=[cnc_ampere_tag, cnc_temp_tag, pump_ampere_tag, pump_temp_tag], jobs_dict=jobs, fota_callback=fotaCallback)
    device.connect()

    # Create four conditions
    cncAmpereCond = device.new_condition(cnc_ampere_tag)
    cncTempCond = device.new_condition(cnc_temp_tag)
    pumpAmpereCondition = device.new_condition(pump_ampere_tag)
    pumpTempCond = device.new_condition(pump_temp_tag)

    while True:
        sleep(1000)

        # read cnc values
        cnc = collectCNCData(cncAmpereCond, cncTempCond)
        # read pump values
        pump = collectPumpData(pumpAmpereCondition, pumpTempCond)
        # increment cnc counter
        monitor.incCncCounter()
        # increment pump counter
        monitor.incPumpCounter()
        # update min max and avg values
        monitor.updateStatisticalData(cnc, pump)

        # get cnc and pump counter values. if it's equal to the period, device will send data
        cncCnt = monitor.getCncCounter()
        pumpCnt = monitor.getPumpCounter()

        # after CncPeriod iterations, device will send to the ZDM two payloads with min, max and avg values
        # using the corresponding tag for each machine
        if cncCnt == cncPeriod:
            publishCncData()
            # call reset variables and counter after the data has been published to avoid zero divisions
            monitor.resetCncVariables()
            monitor.resetCncCounter()
        if pumpCnt == pumpPeriod:
            publishPumpData()
            # call reset variables and counter after the data has been published to avoid zero divisions
            monitor.resetPumpVariables()
            monitor.resetPumpCounter()

        # if instantCnc is True (set remotely with job), the device sends instantaneout CNC values
        if instantCnc == True:
            publishInstantCnc(cnc)
        # if instantPump is True (set remotely with job), the device sends instantaneout Pump values
        if instantPump == True:
            publishInstantPump(pump)

except Exception as e:
    print("main", e)
```

## ZDM_Timestamp


This is an example to recieve the timestamp from ZDM.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################

import streams
from bsp.drivers import wifi
from zdm import zdm


# this function is called when the timestamp is received from the ZDM
def on_timestamp(device, timestamp):
    print("Rcv time:", timestamp)


streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")

    # create a ZDM Device instance and pass the callback function to execute when the timestamp is received
    device = zdm.Device(on_timestamp=on_timestamp)
    device.connect()

    while True:
        # request the timestamp
        device.request_timestamp()
        sleep(2000)


except Exception as e:
    print("main", e)
```



## ZDM_Credentials


Basic template example of connecting the device to ZDM.


```main.py```

```python
################################################################################
# Zerynth Device Manager
#
# Created by Zerynth Team 2020 CC
# Authors: E.Neri, D.Neri
###############################################################################


import streams
from bsp.drivers import wifi
from zdm import zdm

#In order to connect the device to the ZDM, follow the steps:
#   1) Open the ZDM GUI
#   2) Navigate into your workspace and select the device
#   3) Click into the "Security" button and select the appropriate device security
#   4) Click "ok" and then "Download credentials".
#   5) The GUI generates the credential configuration file (zdevice.json) that contains the security parameter.
#   6) Save the zdevice.json file into the main folder of your project.
#   7) Uplink and have fun with Zerynth:)

streams.serial()

try:
    wifi.init()
    print("Connecting to wifi...")
    interface = wifi.interface()
    interface.link("***Wifi-ssid***", interface.WIFI_WPA2, "***Wifi-password****")
    print("Connect wifi done")

    # Create a ZDM Device instance.
    # The ZDM library automatically parses the credential configuration file (zdevice.json)
    # and configures the device with the right credential mode.
    device = zdm.Device()

    # connect your device to ZDM.
    device.connect()

    while True:
        sleep(2000)
        

except Exception as e:
    print("main", e)
```
