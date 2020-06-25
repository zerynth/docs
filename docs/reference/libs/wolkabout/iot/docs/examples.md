# Examples

The following are a list of examples for lib.wolkabout.iot.

## Controlled publish period

Connects your device to the WolkAbout IoT Platform and publishes data at a default period. Sends random temperature sensor readings.
Import `Simple-example-deviceTemplate.json` on the platform to be able to quickly create a device with this sensor.


```main.py```

```python
#   Copyright 2018 WolkAbout Technology s.r.o.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

import streams
from wolkabout.iot import iot
from wireless import wifi

# uncomment one of the following lines depending on used board(e.g. Particle Photon, esp8266 or esp32 based board)
# from broadcom.bcm43362 import bcm43362 as wifi_driver
# from espressif.esp32net import esp32wifi as wifi_driver
# from espressif.esp8266wifi import esp8266wifi as wifi_driver
from stm.spwf01sa import spwf01sa as wifi_driver


# Insert your WiFi credentials
network_SSID = "INSERT_YOUR_WIFI_SSID"
network_SECURITY = wifi.WIFI_WPA2  # wifi.WIFI_OPEN , wifi.WIFI_WEP, wifi.WIFI_WPA, wifi.WIFI_WPA2
network_password = "INSERT_YOUR_WIFI_PASSWORD"

# Insert the device credentials received from WolkAbout IoT Platform when creating the device
device_key = "device_key"
device_password = "some_password"

publish_period_milliseconds = 5000
streams.serial()

# Enable debug printing by setting flag to True
iot.debug_mode = False


# Connect to WiFi network
try:
    print("Initializing WiFi driver..")
    # This setup refers to spwf01sa wi-fi chip mounted on flip n click device slot A
    # For other wi-fi chips auto_init method is available, wifi_driver.auto_init()
    wifi_driver.init(SERIAL1, D16)

    print("Establishing connection with WiFi network...")
    wifi.link(network_SSID, network_SECURITY, network_password)
    print("Done")
except Exception as e:
    print("Something went wrong while linking to WiFi network: ", e)

try:
    device = iot.Device(device_key, device_password)
except Exception as e:
    print("Something went wrong while creating the device: ", e)

try:
    wolk = iot.Wolk(device)
except Exception as e:
    print("Something went wrong while creating the Wolk instance: ", e)

try:
    print("Connecting to WolkAbout IoT Platform")
    wolk.connect()
    print("Done")
except Exception as e:
    print("Something went wrong while connecting to the platform: ", e)


try:
    while True:
        temperature = random(15, 40)
        print("Publishing sensor reading T: " + str(temperature) + " C")

        # Adds a sensor reading to the queue
        wolk.add_sensor_reading("T", temperature)

        # Publishes all stored sensor readings from the queue to the WolkAbout IoT Platform
        wolk.publish()
        sleep(publish_period_milliseconds)
except Exception as e:
    print("Something went wrong: ", e)

```
## Full feature set

Connects your device to the WolkAbout IoT Platform and publishes data at a default period. Sends random temperature, pressure, humidity, and accelerometer sensor readings.
If the random humidity value exceeds 60, an alarm will be sent to the platform. Has a switch and slider actuator allowing controlling the state from the platform.
Also includes four configuration options that are meant for managing device behavior. Import `Full-example-deviceTemplate.json` on the platform to be able to quickly create a device.


```main.py```

```python
#   Copyright 2018 WolkAbout Technology s.r.o.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

import streams
from wolkabout.iot import iot
from wireless import wifi

# uncomment one of the following lines depending on used board(e.g. Particle Photon, esp8266 or esp32 based board)
# from broadcom.bcm43362 import bcm43362 as wifi_driver
# from espressif.esp32net import esp32wifi as wifi_driver
# from espressif.esp8266wifi import esp8266wifi as wifi_driver
from stm.spwf01sa import spwf01sa as wifi_driver


# Insert your WiFi credentials
network_SSID = "INSERT_YOUR_WIFI_SSID"
network_SECURITY = wifi.WIFI_WPA2  # wifi.WIFI_OPEN , wifi.WIFI_WEP, wifi.WIFI_WPA, wifi.WIFI_WPA2
network_password = "INSERT_YOUR_WIFI_PASSWORD"

# Insert the device credentials received from WolkAbout IoT Platform when creating the device
device_key = "device_key"
device_password = "some_password"
actuator_references = ["SW", "SL"]

publish_period_milliseconds = 5000
streams.serial()

# Enable debug printing by setting flag to True
iot.debug_mode = False


class ActuatorSimulator:
    def __init__(self, value):
        self.value = value


switch_simulator = ActuatorSimulator(False)
slider_simulator = ActuatorSimulator(0)


class ActuatorStatusProviderImpl(iot.ActuatorStatusProvider):
    def get_actuator_status(self, reference):
        if reference == "SW":
            return iot.ACTUATOR_STATE_READY, switch_simulator.value
        if reference == "SL":
            return iot.ACTUATOR_STATE_READY, slider_simulator.value


class ActuationHandlerImpl(iot.ActuationHandler):
    def handle_actuation(self, reference, value):
        if reference == "SL":
            slider_simulator.value = value
        if reference == "SW":
            switch_simulator.value = value


class ConfigurationSimulator:
    def __init__(self, value):
        self.value = value


config1_simulator = ConfigurationSimulator(0)
config2_simulator = ConfigurationSimulator(False)
config3_simulator = ConfigurationSimulator("")
config4_simulator = ConfigurationSimulator(("", "", ""))


class ConfigurationProviderImpl(iot.ConfigurationProvider):
    def get_configuration(self):
        configurations = dict()
        configurations["config_1"] = config1_simulator.value
        configurations["config_2"] = config2_simulator.value
        configurations["config_3"] = config3_simulator.value
        configurations["config_4"] = config4_simulator.value
        return configurations


class ConfigurationHandlerImpl(iot.ConfigurationHandler):
    def handle_configuration(self, configuration):
        for config_reference, config_value in configuration.items():
            if config_reference == "config_1":
                config1_simulator.value = config_value
            if config_reference == "config_2":
                config2_simulator.value = config_value
            if config_reference == "config_3":
                config3_simulator.value = config_value
            if config_reference == "config_4":
                config4_simulator.value = config_value


# Connect to WiFi network
try:
    print("Initializing WiFi driver..")
    # This setup refers to spwf01sa wi-fi chip mounted on flip n click device slot A
    # For other wi-fi chips auto_init method is available, wifi_driver.auto_init()
    wifi_driver.init(SERIAL1, D16)

    print("Establishing connection with WiFi network...")
    wifi.link(network_SSID, network_SECURITY, network_password)
    print("Done")
except Exception as e:
    print("Something went wrong while linking to WiFi network: ", e)

try:
    device = iot.Device(device_key, device_password, actuator_references)
except Exception as e:
    print("Something went wrong while creating the device: ", e)

try:
    wolk = iot.Wolk(
        device,
        host="api-demo.wolkabout.com",
        port=1883,
        actuation_handler=ActuationHandlerImpl(),
        actuator_status_provider=ActuatorStatusProviderImpl(),
        outbound_message_queue=iot.ZerynthOutboundMessageQueue(200),
        configuration_handler=ConfigurationHandlerImpl(),
        configuration_provider=ConfigurationProviderImpl(),
    )
except Exception as e:
    print("Something went wrong while creating the Wolk instance: ", e)

try:
    print("Connecting to WolkAbout IoT Platform")
    wolk.connect()
    print("Done")
except Exception as e:
    print("Something went wrong while connecting to the platform: ", e)

# Initial state of actuators and configuration must be delivered to the platform
# in order to be able to change their values from the platform
wolk.publish_actuator_status("SW")
wolk.publish_actuator_status("SL")

wolk.publish_configuration()

try:
    while True:
        temperature = random(15, 40)
        pressure = random(980, 1020)
        humidity = random(20, 70)
        acceleration = (random(0, 10), random(0, 10), random(0, 10))

        if humidity >= 60:
            wolk.add_alarm("HH", True)
        else:
            wolk.add_alarm("HH", False)

        print(
            "Publishing readings"
            + " T: "
            + str(temperature)
            + " P: "
            + str(pressure)
            + " H: "
            + str(humidity)
            + " ACL: "
            + str(acceleration)
        )

        # Adds a sensor reading to the queue
        wolk.add_sensor_reading("T", temperature)
        wolk.add_sensor_reading("P", pressure)
        wolk.add_sensor_reading("H", humidity)
        wolk.add_sensor_reading("ACL", acceleration)

        # Publishes all stored sensor readings and alarms
        # from the queue to WolkAbout IoT Platform
        wolk.publish()
        sleep(publish_period_milliseconds)
except Exception as e:
    print("Something went wrong: ", e)

```
