# Examples

The following are a list of examples for lib.xinabox.sl06.

## Ambient Light Detection


This example enables SL06 as a light sensor. The ambient light level is measured and printed out on the serial console.



```main.py```

```python
###############################################
#   This is an example for the SL06 ambient
#   light, colour, gesture and proximity
#   sensor.
#
#   SL06 is enabled as a light sensor.
#
#   The ambient light level is measured and
#   displayed on the serial console.
###############################################

import streams
from xinabox.sl06 import sl06

streams.serial()

# SL06 instance
SL06 = sl06.SL06(I2C0)  

# configure SL06
SL06.init()

# enable SL06 for light sensing
SL06.enableLightSensor()

while True:
    light = SL06.getAmbientLight()  # read the the ambient light level
    print('Ambient Light Level: ', light)
    
    sleep(2000)

```
## Colour Detection


This example uses SL06 as a colour sensor. Red, green and blue light levels are detected and printed out on the console.



```main.py```

```python
###############################################
#   This is an example for the SL06 ambient
#   light, colour, gesture and proximity
#   sensor.
#
#   SL06 is enabled as a light sensor.
#
#   Place an object in front of the sensor
#   to determine how much red, green and blue
#   light it possesses.
###############################################

import streams
from xinabox.sl06 import sl06

streams.serial()

# SL06 instance
SL06 = sl06.SL06(I2C0)

# configure SL06
SL06.init()

# enable SL06 for light sensing
SL06.enableLightSensor()

while True:
    red = SL06.getRedLight()        # read red light level
    green = SL06.getGreenLight()    # read green light level
    blue = SL06.getBlueLight()      # read blue light level
    
    print('RED   :', red)
    print('GREEN :', green)
    print('BLUE  :', blue)
    
    sleep(2000)
```
## Gesture Detection


This example enables SL06 as a gesture sensor. A swipe across the sensor will reveal the direction of your swipe on the serial console.



```main.py```

```python
###############################################
#   This is an example for the SL06 ambient
#   light, colour, gesture and proximity
#   sensor.
#
#   SL06 is enabled as a gesture sensor.
#
#   Swipe your hand across the sensor for a
#   reading to be printed on the console.
###############################################

import streams
from xinabox.sl06 import sl06

streams.serial()

# SL06 instance
SL06 = sl06.SL06(I2C0)

# configure SL06
SL06.init()

# enable SL06 for gesture sensing
SL06.enableGestureSensor()

while True:
    if SL06.isGestureAvailable():   # check for gesture
        dir = SL06.getGesture()     # read direction
        print(dir)                  # print direction on console
    
    sleep(100)
```
## Proximity Detection


This example enables SL06 as a proximity sensor. A proximity level between between an object and the sensor is detected and printed out on the console.



```main.py```

```python
###############################################
#   This is an example for the SL06 ambient
#   light, colour, gesture and proximity
#   sensor.
#
#   SL06 is enabled as a proximity sensor.
#
#   Move and object to and away from the sensor
#   within a 10cm range. The proximity level
#   between the object and sensor is detected.
###############################################

import streams
from xinabox.sl06 import sl06

streams.serial()

# SL06 instance
SL06 = sl06.SL06(I2C0)  

# configure SL06
SL06.init()

# enable SL06 for proximity sensing
SL06.enableProximitySensor()

while True:
    prox = SL06.getProximity()  # read the proximity level
    print(prox)
    
    sleep(2000)

```
