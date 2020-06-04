# Examples

The following are a list of examples for lib.zerynth.zerynthshield

## Zerynth Shield Basics


Zerynth Shield defines pin names in a board indipendent manner. This way you can upload the same script on different boards
without changing anything. In this example raw values from sensors are read and printed to console.


```main.py```

```python

################################################################################
# Zerynth Shield basic
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
import adc
from zerynthshield import zerynthshield

streams.serial()

# zerynthshield defines pin names in a device indipendent manner
# let's use them to read raw sensors values

while True:
    print(" Microphone:",adc.read(zerynthshield.microphone_pin))
    print("      Light:",adc.read(zerynthshield.light_pin))
    print("Temperature:",adc.read(zerynthshield.temperature_pin))
    print("      Touch:",digitalRead(zerynthshield.touch_pin))
    # aux pins are also accessible!
    print("       AUX1:",adc.read(zerynthshield.aux1.ADC))
    print("-"*40)
    sleep(500)
    
# this scripts runs on every supported device, without a single change...cool isn't it? :)
```
## Electrect Microphone Peak Detector 


The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

In this example the analogSensors module is used to acquire data from the Electrect Microphone embedded in the Zerynth Shield but an be also used with any other analog sensor connected to an analog pin.
The analogSensors integrated routines are used to calculate the min-Max difference and then trigger a function if a threshold is passed.
Use this sensor to start to develop your knock triggered smart device.  

tags: [Smart Sensors Lib, analogSensors, Zerynth Shield, Electrect Microphone, Sound]
groups:[Smart Sensors Library, Zerynth Shield Driver]






```main.py```

```python

################################################################################
# Electrect Microphone Peak Detector
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
# import zerynthshield module
from zerynthshield import zerynthshield
        
# define a function that takes a sensor object as parameter and checks the
# maximum peak to peak extension of the signal in a preset window
# if the extension is over the threshold prints a message   
def detectSound(obj):
    if (obj.resetMinMaxCounter == obj._observationWindowN):
        extension = obj.staticMax - obj.staticMin
        if (extension > 1000):
            print("!!!")
        obj.staticMax, obj.staticMin = -4096, 4096
        obj.resetMinMaxCounter = 0
    else:
        c = obj.currentSample()
        if (c > obj.staticMax):
            obj.staticMax = c
        elif (c < obj.staticMin):
            obj.staticMin = c
        obj.resetMinMaxCounter += 1


streams.serial()

# set three new attributes to the zerynthshield.microphone object
zerynthshield.microphone.staticMin = 4096
zerynthshield.microphone.staticMax = -4096
zerynthshield.microphone.resetMinMaxCounter = 0

# set 'detectSound' as the function to be applied to the object at every sampling
# step
zerynthshield.microphone.doEverySample(detectSound)
# start sampling at 22 microseconds ( ~45 kHZ ) with a window length of 500 that 
# sets the lowest detectable frequency at ~90 Hz 
zerynthshield.microphone.startSampling(22,500,"raw",MICROS)


while True:
    print(zerynthshield.microphone.currentSample())
    sleep(200)
```
## Temperature Sampling


This examples use the Analog Sensors features of the Smart Sensors library for implementing a temperature logger using the Zerynth Shield integrated temperature sensor

tags: [Zerynth Shield, Touch, Button, Digital Sensor]
groups:[Zerynth Shield Driver]  


```main.py```

```python
################################################################################
# Temperature Sampling
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

# This example is based on the Basic Analog Sensor example of the Smart Sensor Library

import streams
from zerynthshield import zerynthshield

def out(obj):
    print("----------------")
    print("last 10 minutes:")
    print("max temperature: ",obj.maxSample)
    print("min temperature: ",obj.minSample)
    print("average temperature: ",obj.currentAverage)   

streams.serial()

zerynthshield.temperature.doEverySample(out)
zerynthshield.temperature.setNormFunc(zerynthshield.toCelsius)
zerynthshield.temperature.startSampling(30000,20,"norm")

```
## Light Controlled PWM

this examples shows how to use the Zerynth Shield Light sensors to drive a LED through a PWM implementing a light with luminosity feedback.

  

tags: [Smart Sensors Lib, analogSensors, Zerynth Shield, sensorPool]
groups:[Smart Sensors Library, Zerynth Shield Driver]


```main.py```

```python
################################################################################
# Light Controlled PWM
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
import pwm
from zerynthshield import zerynthshield

streams.serial()

# define a function that takes a sensor object as parameter and changes the 
# modulation of the led depending on the last value read by the sensor:
# as currentSample() gets higher, PWM duty cycle gets lower
def changeLEDIntensity(obj):
    global led_pin
    percentage = 1 - obj.currentSample()
    print(int(2040 * percentage))
    #~ 490 Hz
    pwm.write(led_pin,2040,int(2040*percentage),MICROS)

led_pin = LED0.PWM
pinMode(led_pin,OUTPUT)
# set zerynthshield.toFloat as the normalization function for the light sensor
# to get its samples as values between 0 and 1
zerynthshield.light.setNormFunc(zerynthshield.toFloat)
# set changeLEDIntensity as the function to be executed every time a new sample
# is read
zerynthshield.light.doEverySample(changeLEDIntensity)
# start sampling normalized samples
zerynthshield.light.startSampling(200,None,"norm")

```
## Shield Pool

The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

In this example a sensor pool of analog sensors is created to acquire data from the Light and Temperature sensors of the Zerynth Shield. The examples shows how to set a calibration function for the temperature sensor while leaving raw the data coming from the light sensor.
Both normalized ans raw sensors are included in a sensorPool and the acquisition triggered simultaneously.

tags: [Smart Sensors Lib, analogSensors, Zerynth Shield, sensorPool]
groups:[Smart Sensors Library, Zerynth Shield Driver]    


```main.py```

```python
################################################################################
# Zerynth Shield Sensor Pool
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
from zerynthshield import zerynthshield
from smartsensors import sensorPool

# see Pool Example for sensorPool details

def out_l(obj):
    print("light: ",obj.currentSample())

def out_t(obj):
    print("temperature: ",obj.currentSample())
    
streams.serial()
zerynthshield.light.doEverySample(out_l)  

# to be noticed the use of a preset normalization function 'zerynthshield.toCelsius'
# included in the zerynthshield module
zerynthshield.temperature.setNormFunc(zerynthshield.toCelsius).doEverySample(out_t)
pool = sensorPool.SensorPool([zerynthshield.light,zerynthshield.temperature])
pool.startSampling([1000,1000],[None,None],["raw","norm"])
```
## Touch Smart Detector  

The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

The Zerynth Shield Library onDoubleTouch method allows to monitor a digital input to be considered as button or touch sensor. 
The methods allow the definition of a set of functions to be called when a single, a double or a long touch is detected.
The functions also allow to adjust the detecting parameter s in term of time ranges and constrains.

tags: [Zerynth Shield, Touch, Button, Digital Sensor]
groups:[Zerynth Shield Driver]    


```main.py```

```python
################################################################################
# Touch Smart Detector
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams

# import zerynthshield module
from zerynthshield  import zerynthshield

# define three functions that print three different messages

def single():
    print("touch")
    
def double():
    print("double")
    
def loong():
    print("loong")
        
streams.serial()

# set 'single' as the function to be executed after the first touch of the Zerynth Shield
# touch sensor and 'double' after the second. To really execute these functions touch
# has to respect some time constraints: first touch must be of at least 50 milliseconds
# to be considered voluntary and must not be longer than 1500 milliseconds, furthermore
# not more than 1000 milliseconds shall pass between the first and second touch to consider
# two single touches a real double touch.
# The 'loong' function is executed if the 1500 milliseconds constraint is not respected.
zerynthshield.touch.onDoubleTouch(50,1500,1000,single,double,loong)

```
## ToiShield IR Basic






```main.py```

```python
################################################################################
# Zerynth Shield IR Basic
#
# Created: 2015-07-26 18:36:22.346367
#
################################################################################

import streams
from zerynthshield import zerynthshield

streams.serial()
while True:
    print("Capturing...")
    # starts capturing from the zerynthshield IR receiver setting max_samples
    # number of samples (a sample represents the interval in microseconds
    # passed between a change from a LOW to a HIGH value on the pin or
    # viceversa) to be acquired and a maximum time window of time_window ms.
    # Values chosen for this example come from NEC IR ( used by LG )
    # specification.
    max_samples, time_window = 67,68
    x = zerynthshield.irreceiver.capture(max_samples,time_window)
    print("Captured:",len(x),"samples\n", x)
```
