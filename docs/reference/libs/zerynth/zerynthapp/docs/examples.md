# Examples

The following are a list of examples for lib.zerynth.zerynthapp

## ZerynthApp Basic


This example is a very minimal ZerynthApp demo.
Bidirectional communication between the script and the mobile app is demostrated: eveytime a button on the mobile app is pressed, a message is received on the board. Everytime the board button is pressed, a message is sent to the mobile app.





```main.py```

```python
from wireless import wifi
# this example is based on Particle Photon
# change the following line to use a different wifi driver
from broadcom.bcm43362 import bcm43362 as wifi_driver
import streams

# Import the Zerynth APP library
from zerynthapp import zerynthapp

streams.serial()

sleep(1000)
print("STARTING...")

# define a RPC function: generate a random number
def do_random(a,b):
    return random(a,b)

# send events on button pressed
def on_btn():
    zapp.event({"my_button":"pressed"})

onPinFall(BTN0,on_btn,debounce=1000)


# Device UID and TOKEN can be created in the ADM panel
zapp = zerynthapp.ZerynthApp("DEVICE UID HERE", "DEVICE TOKEN HERE", log=True)

# link "random" to do_random
zapp.on("random",do_random)

try:
    # connect to the wifi network (Set your SSID and password below)
    wifi_driver.auto_init()
    for i in range(0,5):
        try:
            wifi.link("NETWORK SSID",wifi.WIFI_WPA2,"NETWORK PASSWORD")
            break
        except Exception as e:
            print("Can't link",e)
    else:
        print("Impossible to link!")
        while True:
            sleep(1000)

    # Start the Zerynth app instance!
    # Remember to create a template with the files under the "template" folder you just cloned
    # upload it to the ADM and associate it with the connected device
    zapp.run()
    
    # Do whatever you need here
    while True:
        print(".")
        sleep(5000)
        
except Exception as e:
    print(e)

```
## Zerynth App Oscilloscope


This example demonstrates the advanced gui capabilities of the ZerynthApp.
A graphical oscilloscope is visualized by the mobile app with data coming from the board.





```main.py```

```python
################################################################################
# Zerynth App Oscilloscope
#
# Created by ZERYNTH Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# zapp
# Created at 2017-03-06 11:40:48.064968

from wireless import wifi
# this example is based on Particle Photon
# change the following line to use a different wifi driver
from broadcom.bcm43362 import bcm43362 as wifi_driver
import streams
import adc

# Import the Zerynth APP library
from zerynthapp import zerynthapp

streams.serial()

sleep(1000)
print("STARTING...")

try:
    # Device UID and TOKEN can be created in the ADM panel
    zapp = zerynthapp.ZerynthApp("DEVICE UID", "DEVICE TOKEN", log=True)

    # connect to the wifi network (Set your SSID and password below)
    wifi_driver.auto_init()
    for i in range(0,5):
        try:
            wifi.link("SSID",wifi.WIFI_WPA2,"PASSWORD")
            break
        except Exception as e:
            print("Can't link",e)
    else:
        print("Impossible to link!")
        while True:
            sleep(1000)

    # Start the Zerynth app instance!
    # Remember to create a template with the files under the "template" folder you just cloned
    # upload it to the ADM and associate it with the connected device
    zapp.run()
    
    # Read ADC and send values to the ADM
    while True:
        sleep(1000)
        x = (adc.read(A4)*100)//4096
        zapp.event({"data":x})
        if x>95:
            # send mobile notification
            # (there is a limit of one notification per minute per device on the ADM sandbox)
            zapp.notify("ALARM!","The value is greater than 95!")
        
except Exception as e:
    print(e)
```
