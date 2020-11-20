# Board Support Package

The connectivity drivers are supported in the BSP package of the board, Connectivity drivers include Ethernet, Wifi, GSM. You can use the bsp package to use the appropriate connectivity driver, without worrying about the driver type. (as long as the board has a conectivity chip on-board) For instance:


```#!py3from bsp.drivers import wifi```

```#!py3wifi.init()```

```#!py3interface = wifi.interface()```

```#!py3interface.link("SSID",interface.WIFI_WPA2 ,"PASSWORD")```


And these lines will automatically run on each board’s hardware, given that it has a wifi driver. For example, a Simple HTTP Time request:


``` python
# import streams
import streams
import json

# import the wifi interface
from bsp.drivers import wifi

# import the http module
import requests


streams.serial()

# init the wifi driver!

wifi.init()
interface = wifi.interface()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    interface.link("SSID",interface.WIFI_WPA2 ,"PASSWORD")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

## let's try to connect to timeapi.org to get the current UTC time
for i in range(3):
    try:
        print("Trying to connect...")
        # go get that time!
        # url resolution and http protocol handling are hidden inside the requests module
        response = requests.get("http://now.zerynth.com/")
        # let's check the http response status: if different than 200, something went wrong
        print("Http Status:",response.status)
        # if we get here, there has been no exception, exit the loop
        break
    except Exception as e:
        print(e)
try:
    # check status and print the result
    #if response.status==200:
    print("Success!!")
    print("-------------")
    print("And the result is:",response.content)
    print("-------------")
    js = json.loads(response.content)
    print("Date:",js["now"]["rfc2822"][:16])
    print("Time:",js["now"]["rfc2822"][17:])
except Exception as e:
    print("ooops, something very wrong! :(",e)
```

GSM and Ethernet could be used in the same way, For instance for the Ethernet:

``` python
from bsp.drivers import eth
eth.init()
interface = eth.interface()
interface.link()
```



GSM and Ethernet could be used in the same way, For instance for the GSM:


``` python
from bsp.drivers import gsm
gsm.init()
```


## List of supported boards

| board                    | Connectivity peripheral supported |
|--------------------------|-----------------------------------|
| Adafruit Feather Huzzah  | Wifi and Ethernet                 |
| Arduino MKR1000          | Wifi                              |
| MXChip IoT DevKit AZ3166 | Wifi                              |
| DOIT Esp32 DevKit v1     | Wifi and Ethernet                 |
| ESP32 Azure IoT Kit      | Wifi and Ethernet                 |
| ESP32 DevkitC            | Wifi and Ethernet                 |
| ESP32 Ethernetkit        | Wifi and Ethernet                 |
| ESP32 Pico V4            | Wifi and Ethernet                 |
| Firebeetle ESP32         | Wifi and Ethernet                 |
| Helios Control Board v1  | Wifi and Ethernet                 |
| Heltec Wi-Fi Kit 32      | Wifi and Ethernet                 |
| AWS Hexagon v1           | Wifi and Ethernet                 |
| NodeMCU ESP-32S          | Wifi and Ethernet                 |
| Oddwires IO              | Wifi and Ethernet                 |
| oddwires Proteus         | Wifi and Ethernet                 |
| Olimex Esp32 EVB         | Wifi and Ethernet                 |
| Olimex Esp32 Gateway     | Wifi and Ethernet                 |
| Polaris 2G               | GSM                               |
| Polaris 3G               | GSM                               |
| Polaris NB-IoT           | GSM                               |
| PSoC6 WiFi-Bt Pioneer    | Wifi                              |
| Pycom FiPy 1.0           | Wifi and Ethernet                 |
| Pycom WiPy 3.0           | Wifi and Ethernet                 |
| Riverdi IoT Display      | Wifi and Ethernet                 |
| Sparkfun ESP32 Thing     | Wifi and Ethernet                 |
| Wemos ESP32 OLED         | Wifi and Ethernet                 |
| XinaBox CW02 (ESP32)     | Wifi and Ethernet                 |
| xmc4700_relaxkit Y       | Ethernet                          |
| Infineon XMC4700 Relax   | Ethernet                          |