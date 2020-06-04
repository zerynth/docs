# Examples

The following are a list of examples for lib.texas.pca9536

## Toggle outputs on OC01


This is a basic example to toggle the outputs on the OC01 xChip.



```main.py```

```python
##############################################
#   This is example for the pca9536 library
#
#   Each output is toggled at 500ms
##############################################

# imports
from texas.pca9536 import pca9536 as OC01

# sleep time
DELAY = 500

# create an instance of PCA9536 class
OC01 = OC01.PCA9536(I2C0)

# OC01 pins
OUT0 = OC01.OUT0
OUT1 = OC01.OUT1
OUT2 = OC01.OUT2
OUT3 = OC01.OUT3

# initialize OC01
OC01.init()

# infinite loop
while True:
    # Switch OUT0 On
    OC01.writePin(OUT0, True)
    sleep(DELAY)

    # Switch OUT1 On
    OC01.writePin(OUT1, True)
    sleep(DELAY)

    # Switch OUT2 On
    OC01.writePin(OUT2, True)
    sleep(DELAY)

    # Switch OUT3 On
    OC01.writePin(OUT3, True)
    sleep(DELAY)

    # Switch OUT0 off
    OC01.writePin(OUT0, False)
    sleep(DELAY)

    # Switch OUT1 off
    OC01.writePin(OUT1, False)
    sleep(DELAY)

    # Switch OUT2 off
    OC01.writePin(OUT2, False)
    sleep(DELAY)

    # Switch OUT3 off
    OC01.writePin(OUT3, False)
    sleep(DELAY)

```
## Control OC01 xChip (PCA9536) remotely


This is an advanced example utilizing BME280, PCA9536 and the WolkAbout IoT Platform.

BME280 data consisting of ambient temperature, humidity and pressure is sent to WolkAbout Platform.
OC01 outputs can be controlled from within the dashboad. 
Upload the `CW02-SW01-OC01-deviceTemplate.json` to WolkAbout IoT Platfrom.



```main.py```

```python
#######################################################
# This example sends BME280 data to the WolkAbout cloud.
# PCA9536 outputs can also be controlled from within the
# WolkAbout dashboard.
#
# Upload the device template to the WolkAbout platform.
########################################################

# imports
import streams
from texas.pca9536 import pca9536 as OC01
from wolkabout.iot import iot
from wireless import wifi
from bosch.bme280 import bme280
from espressif.esp32net import esp32wifi as wifi_driver

# wifi details
wifi_ssid = "WiFi Username"
wifi_pass = "WiFi Password"
wifi_secu = wifi.WIFI_WPA2

# rgb pins
RED = D25
GREEN = D26
BLUE = D27

# enable console
streams.serial()

# wolkabout project details
device_key = "wolkabout_device_key"
device_password = "wolkabout_device_password"
actuator_references = ["0", "1", "2", "3"]

# rgb pins set as output
pinMode(RED, OUTPUT)
pinMode(GREEN, OUTPUT)
pinMode(BLUE, OUTPUT)

# xChip instances
SW01 = bme280.BME280(I2C0, 0x76, 100000)
OC01 = OC01.PCA9536(I2C0)

# initialize sensors
SW01.start()
OC01.init()

# OC01 pins
OUT0 = OC01.OUT0
OUT1 = OC01.OUT1
OUT2 = OC01.OUT2
OUT3 = OC01.OUT3

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


# Provide implementation of a way to read and modify actuator state
class ActuatorStatusProviderImpl(iot.ActuatorStatusProvider):
    def get_actuator_status(reference):
        if reference == actuator_references[0]:
            value = OC01.getStatus() & 0x01
            print(value)
            if value == 0x01:
                return iot.ACTUATOR_STATE_READY, True
            else:
                return iot.ACTUATOR_STATE_READY, False
        if reference == actuator_references[1]:
            value = OC01.getStatus() & 0x02
            print(value)
            if value == 0x02:
                return iot.ACTUATOR_STATE_READY, True
            else:
                return iot.ACTUATOR_STATE_READY, False
        if reference == actuator_references[2]:
            value = OC01.getStatus() & 0x04
            print(value)
            if value == 0x04:
                return iot.ACTUATOR_STATE_READY, True
            else:
                return iot.ACTUATOR_STATE_READY, False
        if reference == actuator_references[3]:
            value = OC01.getStatus() & 0x08
            print(value)
            if value == 0x08:
                return iot.ACTUATOR_STATE_READY, True
            else:
                return iot.ACTUATOR_STATE_READY, False


class ActuationHandlerImpl(iot.ActuationHandler):
    def handle_actuation(reference, value):
        print("Setting actuator " + reference + " to value: " + str(value))
        if reference == actuator_references[0]:
            if value is False:
                OC01.writePin(OUT0, False)
            else:
                if value is True:
                    OC01.writePin(OUT0, True)
        if reference == actuator_references[1]:
            if value is False:
                OC01.writePin(OUT1, False)
            else:
                if value is True:
                    OC01.writePin(OUT1, True)
        if reference == actuator_references[2]:
            if value is False:
                OC01.writePin(OUT2, False)
            else:
                if value is True:
                    OC01.writePin(OUT2, True)
        if reference == actuator_references[3]:
            if value is False:
                OC01.writePin(OUT3, False)
            else:
                if value is True:
                    OC01.writePin(OUT3, True)


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

wolk.publish_actuator_status("0")
wolk.publish_actuator_status("1")
wolk.publish_actuator_status("2")
wolk.publish_actuator_status("3")

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
