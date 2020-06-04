# Examples

The following are a list of examples for lib.zerynth.smartsensors

## Basic Analog Sensor 


The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

This examples shows the basic use of the analogSensor module of the smartSensors library.
In the example ADC4 is used for instancing an analogSensors running the automatic calculation of min, Max, average, trend and derivative.
Calculated data are printed on the console through a function that is called by the library every-time a new sample is acquired.

The sampling rate and the parameter calculation window size (expressed in samples) are set through the startSampling function integrated n the library that automates the entire acquisition and calculation process.

tags: [Smart Sensors Lib, analogSensors]
groups:[Smart Sensors Library]


```main.py```

```python
################################################################################
# Basic Analog Sensor for SmartSensor Lib
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
# import analogSensors module 
from smartsensors import analogSensors

# define a function that takes a sensor object as parameter and prints
# the last read sample and all the window parameters
def out(obj):
    print("read sample: ",obj.currentSample())
    print("average: ",obj.currentAverage)
    print("min: ",obj.minSample)
    print("max: ",obj.maxSample)
    print("trend: ",obj.currentTrend)
    print("derivative: ",obj.currentDerivative)
    
# define a 'condition' function that takes a sensor object as parameter 
# and returns True if its current moving average is not None and 
# greater than a fixed threshold
def averageGreaterThanTh(obj):
    if not obj.currentAverage:
        return False
    return (obj.currentAverage > 2000)

# define a function that simply prints a message
def gOut(obj):
    print("average over threshold")

streams.serial()
# initialize an AnalogSensor object on pin A4
a = analogSensors.AnalogSensor(A4)
# set out function as a function to be executed every time a new sample
# is acquired by the sensor
# set averageGreaterThanTh function as a condition to be checked and to
# be verified to execute gOut function every time a new sample is
# acquired by the sensor
a.doEverySample(out).addCheck(averageGreaterThanTh,gOut)
# start sampling at 1000 millis with a window of 4 samples to evaluate
# window parameters
a.startSampling(1000,4)

```
## Advanced Analog Sensor


The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

This examples shows an advanced use of the analogSensor module where a sensor is created attaching it to and ADC and another virtual sensor is created attaching in to the "average" output of the first analog sensor. 
In the example ADC4 is used for instancing an analogSensors running the automatic calculation of min, Max, average, trend and derivative.
Calculated data are printed on the console through a function.
Moreover another sensor is created taking as input the "average" calculated by the first "real" sensor. This trick is used to calculate the Derivative of the average monitoring it through another function in order to notify the user is the derivative of the average is passing a threshold.

In the example the sensorPool module is also used. please refer to the sensorPoll example and documentation for more details.

This example can be used as starting point for very complex analogical data analysis routine where the monitoring of multiple variables is required at different sample rates and with different configurations 

tags: [Smart Sensors Lib, analogSensors]
groups:[Smart Sensors Library]





```main.py```

```python
################################################################################
# Advanced Analog Sensor for SmartSensor Lib
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams
# import analogSensors and sensorPool
from smartsensors import analogSensors
from smartsensors import sensorPool

# define a function that takes a sensor object as parameter and prints its last
# read sample and the current moving average
def out(obj):
    print("current sample: ",obj.currentSample())
    print("average: ",obj.currentAverage)
    
# define a 'condition' function that takes a sensor object as parameter 
# and returns True if its current derivative is not None and 
# greater than a fixed threshold
def derivativeOfAverageGreaterThanTh(obj):
    if type(obj.currentDerivative) == PNONE:
        return False
    return (obj.currentDerivative > 10)

# define a function that simply prints a message
def gOut(obj):
    print("derivative of average over threshold!")


streams.serial()
# initialize an AnalogSensor object on pin A4 and set 'out' as the function to be
# applied to every acquired sample
a = analogSensors.AnalogSensor(A4)
a.highPrecision = True
a.doEverySample(out)

# initialize an AnalogSensor object on currentAverage of 'a' sensor
# a_avg sensor allows to easily monitor 'a' currentAverage but also to handle new
# parameters like its min a max value and derivative for example.
# set detrivativeOfAverageGreaterThanTh function as a condition to be checked and to
# be verified to execute gOut function every time a new sample is acquired by the 'sensor
# of the sensor'
a_avg = analogSensors.AnalogSensor((a,"currentAverage"))   #this is a new sensor that takes as input the average of the a sensor
a_avg.addCheck(derivativeOfAverageGreaterThanTh,gOut)

# to start sampling both sensors are put in a pool, see Pool Example for details
pool = sensorPool.SensorPool([a,a_avg])
pool.startSampling([1000,1000],[5,5],["raw","raw"])
```
## Smoothing Analog Data with Moving Average

The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

In this example the average method is used for smoothing analogical data acquired through the ADC running a moving average filter.
Note that at program starts the average results "None" because the filter window is not yet completely filled and the library verify it avoiding to results wrong data calculation. This feature is very useful in programs where the sampling and analysis routine is stopped and restarted periodically avoiding wrong calculation due to inconsistent incoming data.

tags: [Smart Sensors Lib, analogSensors, Zerynth Shield, sensorPool]
groups:[Smart Sensors Library, Zerynth Shield Driver]





```main.py```

```python
###############################################################################
# Smoothing
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams

# import analogSensors module
from smartsensors import analogSensors

# define a function that takes a sensor object as parameter and prints
# its moving average automatically evaluated
def out(obj):
    print(obj.currentAverage)

streams.serial()
# initialize an analogSensor object on pin A4
s = analogSensors.AnalogSensor(A4)
# set highPrecision to True to evaluate the moving average more precisely
s.highPrecision = True
# set out function as a function to be executed every time a new sample
# is acquired by the sensor
s.doEverySample(out)
# start sampling at 1000 millis with a window of 10 samples to evaluate
# window parameters
s.startSampling(1000,10)

```
## Debounce Digital Sensor Input


The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

In this example the digitalSensors module is used to monitor a DIO and trigger a function only when a state change longer than 500 millisec is detected. This example is very useful for the design of user interfaces where button are included. In this case it is very common to have false detections due to noise or movements and also to have undesired double detection due to a longer press of the button that could be detected by the software as double click.

This example is very useful for improving the usability of the Zerynth Shield Touch sensor 

tags: [digitalSensors, Zerynth Shield, Touch, Button ]
groups:[Smart Sensors Library, Zerynth Shield Driver]  





```main.py```

```python
################################################################################
# Debounce Digital Sensor Input
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams 

# import digitalSensors module
from smartsensors import digitalSensors

# set a state variable to 0
state = 0

# define a function that changes the value of state global variable from 0 to 1
# or from 1 to 0 and prints the new state value
def changeState():
    global state
    state = state^1
    print("new state: ",state)

streams.serial()  
# initialize a digitalSensor object on pin D7

d = digitalSensors.DigitalSensor(D7)

# set changeState as the function to be executed when the value of the pin changes
# from 0 to 1 ( onRise ) and again from 1 to 0 ( andFall ) respecting the time
# constraint: the value must stay HIGH at least 500 milliseconds (make sure the
# transition is voluntary) and less than 2000 milliseconds
d.onRiseAndFall(500,2000,changeState)

```
## Smart Sensor Pool

The smartSensors library is a ready to use set of functions that are very useful for managing analog and digital sensors.
Common operations like calculating min, max, average and trends are completely automated by the smartSensors library.
Moreover the smartSensors lib allows user to define calibration functions for analog sensors and to use callback to schedule sampling and acquisition operations.

This examples shows the basic use of the sensorPool, a module of the library used to create set of heterogeneous sensors to be managed in parallel simplifying the acquisition and calculation routines 

tags: [Smart Sensors Lib, analogSensors, digitalSensors, sensorPool]
groups:[Smart Sensors Library]
  


```main.py```

```python
################################################################################
# Smart Sensor Pool
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi,  D. Mazzei
###############################################################################

import streams

# import analogSensors, digitalSensors and sensorPool modules
from smartsensors import analogSensors
from smartsensors import digitalSensors
from smartsensors import sensorPool   

# define two functions that take a sensor object as parameter and print its
# last read value

def outA(obj):
    print("a: ",obj.currentSample())

def outD(obj):
    print("d: ",obj.currentSample())

# define a function that takes a value and a sensor object as parameters and
# returns a 'normalized' version of the value
def normA(val,obj):
    return val//100
    
streams.serial()

# initialize an analog and a digital sensor on pins A4 and D7
a = analogSensors.AnalogSensor(A4)
d = digitalSensors.DigitalSensor(D7)   

# set a normalization function 'normA' to sensor 'a' to normalize every acquired
# sample and 'outA' as the function to be executed every time a new sample is read
a.setNormFunc(normA).doEverySample(outA)

# set 'outD' as the function to be executed every time a new sample is read by
# sensor 'd'
d.doEverySample(outD)

# initialize a sensorPool object that contains 'a' and 'd' sensors
pool = sensorPool.SensorPool([a,d])

# start sampling process for the objects in the pool specifying different
# sampling parameters:
#
#           sampling time | window size | type of acquisition
#  object a     1000      |    None     |       normalized
#  object b     2000      |    None     |          raw
# 
# window size is set to None because window parameters (moving average,trend...)
# are not needed in this example
pool.startSampling([1000,2000],[None,None],["norm","raw"])
```
