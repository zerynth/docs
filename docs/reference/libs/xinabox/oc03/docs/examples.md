# Examples

The following are a list of examples for lib.xinabox.oc03.

## Toggle relay on OC03


This is a basic example to toggle the relay on OC03 and return the relay state.



```main.py```

```python
##############################################
#   This is an example for the OC03 module
#
#   The relay is toggled at 500 ms and the
# 	state printed to the console.
##############################################
# imports
import streams
from xinabox.oc03 import oc03

streams.serial()

# instantiate OC03 class
OC03 = oc03.OC03(I2C0)

# start OC03
OC03.init()

# sleep time
DELAY = 500

# infinite loop
while True:

    # close relay
    OC03.writePin(True)
    print(OC03.getStatus())  # return state of relay to console
    sleep(DELAY)

    # open relay
    OC03.writePin(False)
    print(OC03.getStatus())  # return state of relay to console
    sleep(DELAY)

```
## Control OC03 xChip low voltage relay remotely


This is an advanced example utilizing BME280, OC03 (PCA9554A) and the WolkAbout IoT Platform.

BME280 data consisting of ambient temperature, humidity and pressure is sent to the WolkAbout Platform.
OC03 relay output can be controlled from within the dashboad. 
Upload the `CW02-SW01-OC01-deviceTemplate.json` to WolkAbout IoT Platfrom.



```main.py```

```python
#######################################################
# This example sends BME280 data to the WolkAbout cloud.
# OC03 relay output can also be controlled from within the
# WolkAbout dashboard.
#
# Upload the device template to the WolkAbout platform.
########################################################

# imports
import i2c
import streams
from wolkabout.iot import iot
from wireless import wifi
from bosch.bme280 import bme280
from espressif.esp32net import esp32wifi as wifi_driver
from xinabox.oc03 import oc03

# wifi details
wifi_ssid = "username"
wifi_pass = "password"
wifi_secu = wifi.WIFI_WPA2

# rgb pins
RED = D25
GREEN = D26
BLUE = D27

# enable console
streams.serial()

# wolkabout project details
device_key = "device_key"
device_password = "device_password"
actuator_references = ["R"]

# rgb pins set as output
pinMode(RED, OUTPUT)
pinMode(GREEN, OUTPUT)
pinMode(BLUE, OUTPUT)

# xChip instances
SW01 = bme280.BME280(I2C0, 0x76, 100000)
OC03 = oc03.OC03(I2C0)

# configure OC03
OC03.init()

# init the wifi driver
wifi_driver.auto_init()


# method that establishes a wifi connection
def wifi_connect():
    for retry in range(10):
        try:
            print("Establishing Link...")
            wifi.link(wifi_ssid, wifi_secu, wifi_pass)
            print("Link Established")
            digitalWrite(GREEN, HIGH)
            break
        except Exception as e:
            print("ooops, something wrong while linking :(", e)
            digitalWrite(GREEN, LOW)
            digitalWrite(RED, HIGH)
            sleep(1000)
            digitalWrite(RED, LOW)
            sleep(1000)


# connect to wifi
wifi_connect()

# establish a connection between device and wolkabout iot platform
try:
    device = iot.Device(device_key, device_password, actuator_references)
except Exception as e:
    print("Something went wrong while creating the device: ", e)


# PProvide implementation of a way to read and modify actuator state
class ActuatorStatusProviderImpl(iot.ActuatorStatusProvider):
    def get_actuator_status(reference):

        if reference == actuator_references[0]:
            value = OC03.getStatus()
            print(value)
            if value == 1:
                return iot.ACTUATOR_STATE_READY, True
            else:
                return iot.ACTUATOR_STATE_READY, False


class ActuationHandlerImpl(iot.ActuationHandler):
    def handle_actuation(reference, value):
        print("Setting actuator " + reference + " to value: " + str(value))

        if reference == actuator_references[0]:
            if value is False:
                OC03.writePin(False)
            else:
                if value is True:
                    OC03.writePin(True)


try:
    wolk = iot.Wolk(
        device,
        actuation_handler=ActuationHandlerImpl,
        actuator_status_provider=ActuatorStatusProviderImpl,
    )
except Exception as e:
    print("Something went wrong while creating the Wolk instance: ", e)

# Establish a connection to the WolkAbout IoT Platform
try:
    print("Connecting to WolkAbout IoT Platform")
    wolk.connect()
    print("Done")
except Exception as e:
    print("Something went wrong while connecting: ", e)

publish_period = 5000

wolk.publish_actuator_status("R")

try:
    while True:
        if not wifi.is_linked():
            wifi_connect()

        sleep(publish_period)

        print("Publishing sensor readings")
        temperature = SW01.get_temp()
        humidity = SW01.get_hum()
        pressure = SW01.get_press()
        print("T", temperature, "H", humidity, "P", pressure)
        wolk.add_sensor_reading("T", temperature)
        wolk.add_sensor_reading("H", humidity)
        wolk.add_sensor_reading("P", pressure)

        wolk.publish()
except Exception as e:
    print("Something went wrong: ", e)

```
