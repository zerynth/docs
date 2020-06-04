# Examples

The following are a list of examples for lib.fortebit.iot

## MQTT


A simple example connecting a device to the OKDO IoT cloud using the MQTT protocol



```main.py```

```python
################################################################################
# MQTT at OKDO Cloud IoT
#
# Created at 2019-05-06 08:40:34.990336
#
################################################################################

import streams
from wireless import wifi
# choose a wifi chip (esp32)
from espressif.esp32net import esp32wifi as wifi_driver

# let's import the OKDO cloud modules; first the IoT module...
from okdo.iot import iot
# ...then the mqtt client
from okdo.iot import mqtt_client

# Let's define a global variable to store the publishing rate (in ms)
rate = 3000

# Customize the following variables
ssid = "SSID"                  # this is the SSID of the WiFi network
wifipwd = ""                   # this is the Password for WiFi
device_id = "device_id"        # this is the device identifier. Can be obtained from the OKDO cloud dashboard
device_token = "device_token"  # this is the device token. Can be obtained from the OKDO cloud dashboard

# Remember to add a device to your okdo cloud and define some assets:
# - a "rate" actuator, with type integer
# - a "random" sensor of type integer


def rate_cb(asset,value, previous_value):
    global rate
    value = int(value)
    if value<1000:
        value=1000
    rate=value
    print("Rate changed to",rate,"ms")



streams.serial()

try:
    # Let's initialize the WiFi
    wifi_driver.auto_init()

    for _ in range(0,5):
        # put your SSID and password here
        try:
            wifi.link(ssid,wifi.WIFI_WPA2,wifipwd)
            break
        except:
            print("Trying to connect...")
            sleep(2000)
    else:
        print("oops, can't attach to wifi!")
        raise IOError

    print("Connecting to OKDO IoT Cloud...")

    # let's create a device passing the id, the token and the type of client
    device = iot.Device(device_id,device_token,mqtt_client.MqttClient)

    device.connect()
    print("Device is connected")

    # define the callbacks to call when an asset command is received
    device.watch_command("rate",rate_cb)

    # start the device
    device.run()
    print("Device is up and running")

    while True:
        # sleep as indicated by rate
        sleep(rate)
        x = random(0,100)
        msg = device.publish_asset("random",x)
        print("Published asset",msg)
        # alternatively, you can publish more than one asset state at a time 
        # by providing them as a dictionary to the following function (uncomment to test)
        # msg = device.publish_state({"random":x})
        # print("Published state",msg)
except Exception as e:
    print(e)



```
## HTTP


A simple example connecting a device to the OKDO IoT cloud using the HTTP protocol




```main.py```

```python
################################################################################
# HTTP at Fortebit Cloud IoT
#
# Created at 2019-05-06 08:40:34.990336
#
################################################################################

from fortebit.polaris import polaris
import mcu
import vm
from wireless import gsm
import ssl

sleep(1000)
print("Test Polaris I/O")
polaris.init()

#print("create IO exp...")
#iox = polaris.IO_EXP()


print("MCU UID:", [hex(b) for b in mcu.uid()])
print("VM info:", vm.info())

# let's import the OKDO cloud modules; first the IoT module...
from fortebit.iot import iot
# ...then the http client
from fortebit.iot import http_client

try:
    modem = polaris.GSM()
    
    minfo = gsm.mobile_info()
    print("Modem:", minfo)
    
    device_token = polaris.getAccessToken(minfo[0], mcu.uid())
    print("Access Token:", device_token)
    
    for _ in range(0,5):
        # put your SSID and password here
        try:
            #gsm.attach("wap.vodafone.co.uk","wap","wap")
            gsm.attach("mobile.vodafone.it")
            #gsm.attach("internet.wind")
            #gsm.attach("tre.it")
            break
        except Exception as e:
            print("Retrying...", e)
        try:
            gsm.detach()
            sleep(2000)
        except:
            pass
    else:
        print("oops, can't attach to wifi!")
        raise IOError

    ninfo = gsm.network_info()
    linfo = gsm.link_info()
    print("Attached to network:", ninfo, linfo)

    # retrieve the CA certificate used to sign the howsmyssl.com certificate
    cacert = __lookup(SSL_CACERT_DST_ROOT_CA_X3)

    # create a SSL context to require server certificate verification
    ctx = ssl.create_ssl_context(cacert=cacert, options=ssl.CERT_NONE)#ssl.CERT_REQUIRED | ssl.SERVER_AUTH)
    # NOTE: if the underlying SSL driver does not support certificate validation
    #       uncomment the following line!
    # ctx = None

    print("Connecting to Fortebit IoT Cloud...")

    # let's create a device passing the id, the token and the type of client
    device = iot.Device(device_token,http_client.HttpClient,ctx)

    device.connect()
    print("Device is connected")

    # start the device
    device.run()
    print("Device is up and running")

    x = 0
    while True:
        # sleep as indicated by rate
        polaris.ledRedOn()
        sleep(3000)
        polaris.ledRedOff()
        x = x+1 #random(0,100)
        msg = device.publish_telemetry({"random":x})
        print("Published telemetry",msg)
        # alternatively, you can publish more than one asset state at a time 
        # by providing them as a dictionary to the following function (uncomment to test)
        # msg = device.publish_state({"random":x})
        # print("Published state",msg)
except Exception as e:
    print(e)




```
