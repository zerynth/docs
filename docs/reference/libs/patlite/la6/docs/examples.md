# Examples

The following are a list of examples for lib.patlite.la6



```main.py```

```python
#--------------------------------#
# Author: Alex Moriconi          |
# Date: 10-06-2019               |
# Example Library Patlite La6    |
# Protocol: HTTP Basic           |
#--------------------------------#
#----- necessary streams import
import streams

# the ethernet module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the ESP32 driver
# from espressif.esp32net import esp32eth as ethernet

# uncomment the following line to use INFINEON xmc4eth driver
# from infineon.xmc4eth import xmc4eth as ethernet

from patlite.la6 import la6
#----- Network initialization
ethernet.init()
ethernet.set_link_info("192.168.10.2","255.255.255.0","0.0.0.0","0.0.0.0")
ethernet.link()
#----- Serial PC initialization
streams.serial()
#----- initialization
try:
    lamp=la6.la6HTTP()
except Exception as e:
    print(e)
while True:
    #----- Animation Example
    lamp.set_LED_colors(["green","green","green","green","green"])
    sleep(2000)
    lamp.set_LED_colors(["white","white","white","white","white"])
    sleep(2000)
    lamp.set_LED_colors(["red","red","red","red","red"])
    sleep(2000)

```


```main.py```

```python
#--------------------------------#
# Author: Alex Moriconi          |
# Date: 10-06-2019               |
# Example Library Patlite La6    |
# Protocol: MODBUS Basic         |
#--------------------------------#
#----- necessary streams import
import streams

# the ethernet module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the ESP32 driver
# from espressif.esp32net import esp32eth as ethernet

# uncomment the following line to use INFINEON xmc4eth driver
# from infineon.xmc4eth import xmc4eth as ethernet

from patlite.la6 import la6
#----- Network initialization
ethernet.init()
ethernet.set_link_info("192.168.10.2","255.255.255.0","0.0.0.0","0.0.0.0")
ethernet.link()
#----- Serial PC initialization
streams.serial()
#----- initialization
try:
    lamp=la6.la6MODBUS()
except Exception as e:
    print(e)
while True:
    #----- Animation Example
    lamp.set_LED_colors(["green","green","green","green","green"])
    sleep(2000)
    lamp.set_LED_colors(["white","white","white","white","white"])
    sleep(2000)
    lamp.set_LED_colors(["red","red","red","red","red"])
    sleep(2000)

```


```main.py```

```python
#--------------------------------#
# Author: Alex Moriconi          |
# Date: 10-06-2019               |
# Esempio Library Patlite La6    |
# Protocol: HTTP                 |
#--------------------------------#
#----- necessary streams import
import streams

# the ethernet module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the ESP32 driver
# from espressif.esp32net import esp32eth as ethernet

# uncomment the following line to use INFINEON xmc4eth driver
# from infineon.xmc4eth import xmc4eth as ethernet

from patlite.la6 import la6
#----- Network initialization
ethernet.init()
ethernet.set_link_info("192.168.10.2","255.255.255.0","0.0.0.0","0.0.0.0")
ethernet.link()
#----- Serial PC initialization
streams.serial()
#----- initialization
try:
    lamp=la6.la6HTTP()
except Exception as e:
    print(e)
print("----- Start Animation")
while True:
    #----- Animation Example
    print("--- Restart Animation")
    lamp.set_LED_colors(["red","off","off","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","red","off","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","red","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","red","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","off","red"])
    sleep(300)
    lamp.set_LED_colors(["red","off","off","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","red","off","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","red","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","red","red"])
    sleep(300)
    lamp.set_LED_colors(["white","off","off","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","white","off","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","white","red","red"])
    sleep(300)
    lamp.set_LED_colors(["green","off","white","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","green","white","red","red"])
    sleep(300)
    lamp.set_LED_colors(["green","green","white","red","red"])

    lamp.set_buzzer("on")#Start Buzzer
    sleep(50)
    lamp.set_buzzer("off")#Stop Buzzer
    sleep(10)
    lamp.set_flash("on") #Start Flash LED
    sleep(5000)
    lamp.clear()
    sleep(10)
    lamp.set_smartmode(2)
    sleep(9000)
    lamp.clear()
    sleep(1000)
    print("--- Finish Animation")



```


```main.py```

```python
#--------------------------------#
# Author: Alex Moriconi          |
# Date: 10-06-2019               |
# Esempio Library Patlite La6    |
# Protocol: MODBUS               |
#--------------------------------#
#----- necessary streams import
import streams

# the ethernet module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the ESP32 driver
# from espressif.esp32net import esp32eth as ethernet

# uncomment the following line to use INFINEON xmc4eth driver
# from infineon.xmc4eth import xmc4eth as ethernet

from patlite.la6 import la6
#----- Network initialization
ethernet.init()
ethernet.set_link_info("192.168.10.2","255.255.255.0","0.0.0.0","0.0.0.0")
ethernet.link()
#----- Serial PC initialization
streams.serial()
#----- initialization
try:
    lamp=la6.la6MODBUS()
except Exception as e:
    print(e)
print("----- Start Animation")
while True:
    #----- Animation Example
    print("--- Restart Animation")
    lamp.set_LED_colors(["red","off","off","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","red","off","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","red","off","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","red","off"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","off","red"])
    sleep(300)
    lamp.set_LED_colors(["red","off","off","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","red","off","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","red","off","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","off","red","red"])
    sleep(300)
    lamp.set_LED_colors(["white","off","off","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","white","off","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","off","white","red","red"])
    sleep(300)
    lamp.set_LED_colors(["green","off","white","red","red"])
    sleep(100)
    lamp.set_LED_colors(["off","green","white","red","red"])
    sleep(300)
    lamp.set_LED_colors(["green","green","white","red","red"])

    lamp.set_buzzer("on")#Start Buzzer
    sleep(50)
    lamp.set_buzzer("off")#Stop Buzzer
    sleep(10)
    lamp.set_flash("on") #Start Flash LED
    sleep(5000)
    lamp.clear()
    sleep(10)
    lamp.set_smartmode(2)
    sleep(9000)
    lamp.clear()
    sleep(1000)
    print("--- Finish Animation")



```
