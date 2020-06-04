# Examples

The following are a list of examples for core.zerynth.stdlib

## Hello World


The simplest example to be tried for starting with embedded development  

tags: [First Steps, Serial]
groups:[First Steps]


```main.py```

```python
###############################################################################
# Hello Zerynth
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

# import the streams module, it is needed to send data around
import streams

# open the default serial port, the output will be visible in the serial console
streams.serial()  

# loop forever
while True:
    print("Hello Zerynth!")   # print automatically knows where to print!
    sleep(1000)
```
## Basic LED Blink 

The "Hello World" of embedded devices

Just configure a digital pin as output driving it ON and OFF every sec 
to blink the attached LED.

tags: [Digital I/O, First Steps]
groups:[First Steps]  


```main.py```

```python
###############################################################################
# Led Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

# D0 to D127 represent the names of digital pins
# On most Arduino-like boards Pin D13 has an on-board LED connected.
# However Zerynth abstracts the board layout allowing to use LED0, LED1, etc as led names.
# In this example LED0 is used.

pinMode(LED0,OUTPUT)

# loop forever
while True:
    digitalWrite(LED0, HIGH)  # turn the LED ON by setting the voltage HIGH
    sleep(1000)               # wait for a second
    digitalWrite(LED0, LOW)   # turn the LED OFF by setting the voltage LOW
    sleep(1000)               # wait for a second


```
## Digital Read Basics 


The basic definition of digitalRead() in ZERYNTH has the same behaviour of Arduino digitalRead().

In this example simple digitalRead use is reported

tags: [First Steps,Digital Read ADC]
groups:[First Steps]  


```main.py```

```python
################################################################################
# Digital Read Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

# create a serial port stream with default parameters  
streams.serial()

# configure pin D5 in input mode
pinMode(D5, INPUT_PULLUP)

# loop forever, printing the value of D5
while True:
    print(digitalRead(D5))
    sleep(500)  
```
## ADC Analog to Digital Acquisition Basics 


The function for Analog to Digital convertion in ZERYNTH is adc.read()

The complete definition is adc.read(pin, samples=1) 

In this example simple ADC single pin acquisition and advanced multi sample ADC acquisition are reported.

In ZERYNTH ADC is also available as builtin analogRead() with the same signature of adc.read(). analogRead() is available only for compatibility with the Arduino world and will be deprecated in future versions of ZERYNTH.

tags: [First Steps,Analog Read ADC]
groups:[First Steps]


```main.py```

```python
################################################################################
# Analog Read
# 
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams  # import the streams module
import adc      # import the adc driver 

# create a stream linked to the default serial port
streams.serial() 

while True:
    
# Basic usage of ADC for acquiring the analog signal from a pin   
    value = adc.read(A0)
    print("One sample:",value)

# The complete definition of adc.read() is adc.read(pin, samples=1) 
# For an advanced usage of adc.read refer to the official Zerynth documentation

#acquire 10 samples with default sampling period    
    value2 = adc.read(A0,10)
    print("10 samples:\n",value2)
    
#acquire 3 samples from the first 4 analog pins of the board with default sampling period    
    value3= adc.read([A0,A1,A2,A3],3)
    print("3 samples from A0, A1, A2 and A3:\n",value3)

    print()
    sleep(300)
```
## ADC Analog to Digital Acquisition with Voltage Conversion

This basic examples shows how to read an analog voltage from pin 0, converts it to the corresponding voltage, and prints the result to the serial monitor.
To test it user can attach the center pin of a potentiometer to pin A0, and the other pins respectively to to +3.3V and GND.

tags: [Analog Read ADC, Sensors, First Steps]  
groups:[First Steps]


```main.py```

```python
################################################################################
# Analog Read to Voltage
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import adc      # import the adc module  

#create a serial port stream with default parameters
streams.serial()

while True:
       
    #read the input on analog pin 0
    sensor_value = adc.read(A0)
    
    #convert the analog reading (which goes from 0 - 4095.0) to a voltage (0 - 3.3V):
    voltage = sensor_value * (3.3 / 4095.0)
    
    #print out the raw and converted values:
    print("sensor raw value:", sensor_value,"Voltage:",voltage)
    
    sleep(300)



```
## ZERYNTH Oscilloscope

Simple usage of the analog acquisition and of the Python smart print functions.
The example shows how to print to the serial console the values read on an analog pin in a "scope" like graphicspretty way.


tags: [First Steps, Analog Read ADC, Serial]
groups:[First Steps]     


```main.py```

```python
###############################################################################
# Zerynth oscilloscope
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

import streams
import adc
   
streams.serial()

while True:
    value = adc.read(A4)
    conv = value*80//4095
    print("|","#"*conv," "*(80-conv),"|")
    sleep(200)
    
```
## Serial Port Read/Write Basics


Basic examples of read and write data through a serial port.
In this example a serial port instance is created allowing use of various methods.

tags:[Serial, First Steps]
groups:[First Steps]   


```main.py```

```python
################################################################################
# Serial Port Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
# creates a serial port and name it "s"
s=streams.serial()

while True:
    print("Write some chars on the serial port and terminate with \\n (new line)")
    line=s.readline() # read and return any single character available on the serial port until a \n is found
    print("You wrote:", line)
    print()
    sleep (300)
      
    
   
```
## Sensor driven Multi-Blink


This examples shows how to drive various behaviours taking as input an analog signal acquired through ADC fro driving three loop implemented as separated threads.
In particular, the implemented scripts drives three LEDs at three different frequencies calculated on the basis of the acquired analog signal.

The example is implemented using 4 threads that run in parallel. One thread is used for acquiring the analog signal and convert the acquired raw value in blinking frequencies usable by the LED driving threads. The other three threads are used to instantiate a generic blinking function that drive a PIN where a LED is connected.

tags:[Multi-Thread, First Steps, Analog Read ADC]
groups:[First Steps]   


```main.py```

```python
################################################################################
# Sensor Driven Multi-Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# This example requires an analog sensor and three LEDs
import streams
import adc

# create a serial port stream with default parameters
streams.serial()

# set the A1 pin as analog input and D8, D9, D10 as outputs to drive the LEDs. 
pinMode(A1,INPUT_ANALOG)
pinMode(D10,OUTPUT)
pinMode(D9,OUTPUT)
pinMode(D8,OUTPUT)

# creates two arrays for storing global variables to be used in the blinking threads
freq=[1,1,1]        
pin=[D8,D9,D10]    

# define the generic blinking function to be used for driving the LEDs
# this function takes as input the index identifying the LED, then uses the global freq and pin arrays to dynamically drive the LEDs
def blink(Npin):
    while True:
        digitalWrite(pin[Npin],HIGH)
        sleep(freq[Npin])
        digitalWrite(pin[Npin],LOW)
        sleep(freq[Npin])

# define an analog sensor sampling function that acquires the raw data and converts it to the three LED frequencies
def sampling():
    global freq
    while True:
        value = adc.read(A1)
        freq[0] = value//10
        freq[1] = freq[0] * 2
        freq[2] = freq[0] * 4
        sleep(50)

# launch the four threads        
thread(sampling)
thread(blink,0)
thread(blink,1)
thread(blink,2)

# The main loop is used only for printing out at reasonable speed the calculated frequencies in term of waiting times 
while True:
    print("Wait times are", freq)
    sleep(500)

```
## Multi-Thread Basics


This examples shows the basics of ZERYNTH multi-threading
In ZERYNTH a thread require a function to be executed as input for the definition
the same function can be instanced by various thread giving you the possibility to write very concise and readable code.
In this example 4 threads are created as instances of the same function where different parameters are passed to the function when the thread is initialized

Note that the while True main loop typical of imperative programming is not present in this code. ZERYNTH allows pure thread driven implementation!

tags: [First Steps, Multi-Thread]   
groups:[First Steps]


```main.py```

```python
################################################################################
# Multi-Thread Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

# create a serial port with default parameters
streams.serial()

# Define a function to be used in the various threads.
# Parameters are passed to the function when the thread is created and then used in the thread loop.
# To be continuously executed by a thread a function requires an infinite loop,
# otherwise when the function terminates the thread is closed
     
def threadfn(number,delay):    
    
    while True:                    
        print("I am the thread",number)
        print("I run every:",delay,"msec")
        print()                # just add an empty line for console output readability 
        sleep(delay)

# create the various threads using the same function but passing different parameters        
thread(threadfn,1,500)
thread(threadfn,2,1000)
thread(threadfn,3,1300)
thread(threadfn,4,800)
   

```
## Multi LEDs Blink with threads

This examples shows how to use ZERYNTH threads for driving three LEDs with asymmetric and different blinking rates. 

Each Thread in ZERYNTH is a sort of separated and parallel process that runs autonomously on your board. 
With threads you can design your algorithm architecture assuming parallelism that is typical of high level programming languages. 
In this code a function is defined and then instanced by three threads creating a pool of parallel processes where three LEDs are driven 
at different frequencies. 

Moreover, thanks to Python argument passing, default values can be defined for function inputs. 
This way you can launch threads without specifying all the inputs required by the function, default values will fill the holes.
In this case all the parameters following 'blink' are passed to the functions as arguments.
thread(blink,pin,delayON,delayOFF) is equivalent to thread(blink(pin,delayON,delayOFF)).

tags: [Multi-Thread, First Steps, Digital I/O]
groups:[First Steps]  


```main.py```

```python
################################################################################
# Multi-Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# Initialize the digital pins where the LEDs are connected as output
pinMode(D2,OUTPUT)
pinMode(D8,OUTPUT)
pinMode(D5,OUTPUT)

# Define the 'blink' function to be used by the threads
def blink(pin,timeON=100,timeOFF=100): # delayON and delayOFF are optional parameters, used as default 
                                         # if not specified when you call the function
    while True:
        digitalWrite(pin,HIGH)   # turn the LED ON by making the voltage HIGH
        sleep(timeON)            # wait for timeON 
        digitalWrite(pin,LOW)    # turn the LED OFF by making the voltage LOW
        sleep(timeOFF)           # wait for timeOFF 

# Create three threads that execute instances of the 'blink' function.     
thread(blink,D2)             # D2 is ON for 100 ms and OFF for 100 ms, the default values of delayON an delayOFF
thread(blink,D8,200)         # D8 is ON for 200 ms and OFF for 100 ms, the default value of delayOFF
thread(blink,D5,500,200)     # D5 is ON for 500 ms and OFF for 200 ms
```
## Serial Port Advanced


Advanced example of using a serial port for writing and sending data
The examples shows how to read the entire serial port buffer or how to read a defined number of chars from the buffer.
Moreover is also shown how to read a buffer until a \n newline terminator is found.

tags:[Serial, First Steps]
groups:[First Steps]


```main.py```

```python
################################################################################
# Serial Advanced
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

s = streams.serial()

# Testing various serial port reading methods
   
while True:
    print("write some chars and send it to the board")
    char=s.read() # read and return any single character available on the serial port one by one
    print("This is the first char you wrote:",char)
    print() # add a line space for improving the serial console ouput readability
    
    sleep(500) # waiting for the serial buffer to fill
    length=s.available() # check if data are available on the port and count them
    chars=s.read(length) # read all the bytes available in the buffer an return the bytearray 
    print("This are the other", length, "chars you wrote:",chars)
    print() # add a line space for improving the serial console view
    
    print("write a line ending it with return or enter")
    line=s.readline() # read until a line terminator \n is found, then return a bytearray
    print("This is the line you wrote:",line)
```
## Input Capture Unit as PWM Analyzer


This examples shows how to use the Input Capture Unit of the board MCU for analysing a PWM signal 
The PWM is generated on PIN13 in order to have a feedbakc on the board embedded LED
PIN13 is also connected through a wire with PIN2 on which the ICU capture is activated
An interrupt is also attached on a PIN where a button is connected for changing the PWM duty.

Very Important: ICU and PWM are both timer powered embedded feature, it is impossible to run an ICU and a PWM
on two pin controlled by the same timer channel. 
Please refer to the board pinout in order to select the proper pins for your board
e.i: on a ST Nucleo this example use PWM2/1 for PIN13 and PWM1/3 for PIN2 so we are using two diferent embedded timers (first number on the PEM pin descrition)

Board setup:   
  PIN13-----PIN2  (shortcut the pins)
  BTNPin----GND   (connect a button between a pin and GND)  

tags: [First Steps, Input Capture Unit ICU, Interrupts, Analog Write PWM]  
groups:[First Steps]





```main.py```

```python
################################################################################
# Input Capture Unit as PWM Analyzer
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import pwm 
import icu
import streams

# create the serial port using default parameters  
streams.serial()

# define a pin where a button is connected, you can use the Nucleo button pin as input or change it with any other digital pin available

# this is the pin the button is connected to; for the various supported boards, Zerynth automatically translates it 
# to the board button. On Arduino DUE the user button isn't installed, so this line rises a compilation error.
# On Arduino DUE, change it to the pin your button is connected to or comment this line (see below)
buttonPin=BTN0


# define the ICU pin. D5 works with Arduino footprint boards while with Particle boards D0 can be used 
captPin=D5.ICU  # On Arduino like boards
#captPin=D0.ICU  # On Particle boards

# define the PWM pin. D13 works with Arduino footprint boards (and is also connected to a LED) while with Particle boards A4 can be used
pwmPin=D13.PWM # On Arduino like boards 
#pwmPin=A4.PWM # On Particle boards

# set the pin as input with PullUp, the button will be connected to ground
pinMode(buttonPin, INPUT_PULLUP)

# define a function for printing capture results on the serial port
def print_results(y):
    print("Time ON is:", y[0],"micros")
    print("Time OFF is:",y[1],"micros")
    print("Period is:", y[0]+y[1], "micros")
    print()
    
# define a global variable for PWM duty cycle and turn on the PWM

duty=10
pwm.write(pwmPin,100, duty,MICROS) #pwm.write needs (pn, period, duty, time_unit)

# define the function to be called for changing the PWM duty when the button is pressed
def pwm_control():
    global duty
    duty= duty+10
    if duty>=100:
        duty=0
    pwm.write(pwmPin, 100, duty,MICROS)
    print("Duty:", duty, "millis")
    
# Attach an interrupt on the button pin waiting for signal going from high to low when the button is pressed.
# pwm_control will be called when the interrupt is fired.
# If you are on Arduino DUE and you haven't connected any button comment the following line 
# you will not change the PWM duty but you can still test the ICU capture
onPinFall(buttonPin, pwm_control)

while True:
    # start an icu capture to be triggered when the pin rise.
    # this routine acquires 10 steps (HIGH or LOW states) or terminates after 50000 micros
    # this is a blocking function
    x = icu.capture(captPin,LOW_TO_HIGH,10,50000,MICROS)
    print("captured")
    # x is a list of step durations in microseconds, pass it to the printing function and check the serial console
    print_results(x)
    
    sleep(1000)
    

```
## Timers Basics


Basic example of use of the timer module for monitoring the time during the program execution.
Timers can be used as alternative to the Arduino Millis().


tags=[First Steps, Timers]
groups:[First Steps]    


```main.py```

```python
################################################################################
# Timers Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import timers
import streams

# create a serial port with default parameters
streams.serial()

# create a new timer
t=timers.timer()
# start the timer
t.start()

minutes=0
   
while True:
    
    if t.get()>= 60000:        #check if 60 seconds are passed
        t.reset()              #timer can be reset
        minutes +=1
    seconds=t.get()//1000
    print("time is:", minutes,":",seconds) #just print the current value since timer start or last reset
    print("System time is:", timers.now(), "(millis)") #timers.now() gives the system time in milliseconds since program start
    print()
    
    sleep(500)                 #run every 500 millisec
```
## String Formatting


Some example of Python string formatting with the modulo operator.


```main.py```

```python
################################################################################
# strformat
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

streams.serial()

print("Starting!")
sleep(1000)

# a data tuple
tt = ("string",-21,15.23,32)
# a data dictionary
dd = {
      "thing":"string",
      "number":1,
      "float":1.0,
      "hex":32  
}

# let's format :)
while True:
    try:
        # basic formatting
        print("%% this is a %s, this is a %d, this is a %f, this is a %x, this is a %%"%tt)
        # named keys formatting
        print("%% this is a %(thing)s, this is a %(number)d, this is a %(float)f, this is a %(hex)x, this is a %%"%dd)
        # width & precision
        print("%s %8d %f %d"%tt)
        print("%s %08.7d %f %d"%tt)
        # width & precision & left alignment & sign
        print("%s %-010.9d %f %d"%tt)
        print("%s %-010.9d %2.0f %d"%tt)
        print("%s %-010.9d %2.5f %d"%tt)
        print("%s %-010.9d %12.5f %d"%tt)
        print("%s %-010.9d %-12.5f %d"%tt)
        print("%s %-010.9d %012.15f %d"%tt)
        print("%s %+010.9d %012.15f %d"%tt)
        print("%s % 010.9d %012.15f %d"%tt)
        # width & precision for strings
        print("%15.3s % 010.9d %012.15f %d"%tt)
        # variable width & precision
        print("%x %3.*d"%(123456,5,6))
    except Exception as e:
        print(e)
    sleep(5000)

```
## Serial Port Read/Write Basics


Basic examples of read and write data through a serial port.
In this example a serial port instance is created allowing use of various methods.

tags:[Serial, First Steps]
groups:[First Steps]   


```main.py```

```python
################################################################################
# Serial Port Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
# creates a serial port and name it "s"
s=streams.serial()

while True:
    print("Write some chars on the serial port and terminate with \\n (new line)")
    line=s.readline() # read and return any single character available on the serial port until a \n is found
    print("You wrote:", line)
    print()
    sleep (300)
      
    
   
```
## Serial Port Advanced


Advanced example of using a serial port for writing and sending data
The examples shows how to read the entire serial port buffer or how to read a defined number of chars from the buffer.
Moreover is also shown how to read a buffer until a \n newline terminator is found.

tags:[Serial, First Steps]
groups:[First Steps]


```main.py```

```python
################################################################################
# Serial Advanced
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

s = streams.serial()

# Testing various serial port reading methods
   
while True:
    print("write some chars and send it to the board")
    char=s.read() # read and return any single character available on the serial port one by one
    print("This is the first char you wrote:",char)
    print() # add a line space for improving the serial console ouput readability
    
    sleep(500) # waiting for the serial buffer to fill
    length=s.available() # check if data are available on the port and count them
    chars=s.read(length) # read all the bytes available in the buffer an return the bytearray 
    print("This are the other", length, "chars you wrote:",chars)
    print() # add a line space for improving the serial console view
    
    print("write a line ending it with return or enter")
    line=s.readline() # read until a line terminator \n is found, then return a bytearray
    print("This is the line you wrote:",line)
```
## Digital Read Basics 


The basic definition of digitalRead() in ZERYNTH has the same behaviour of Arduino digitalRead().

In this example simple digitalRead use is reported

tags: [First Steps,Digital Read ADC]
groups:[First Steps]  


```main.py```

```python
################################################################################
# Digital Read Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

# create a serial port stream with default parameters  
streams.serial()

# configure pin D5 in input mode
pinMode(D5, INPUT_PULLUP)

# loop forever, printing the value of D5
while True:
    print(digitalRead(D5))
    sleep(500)  
```
## Basic LED Blink 

The "Hello World" of embedded devices

Just configure a digital pin as output driving it ON and OFF every sec 
to blink the attached LED.

tags: [Digital I/O, First Steps]
groups:[First Steps]  


```main.py```

```python
###############################################################################
# Led Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

# D0 to D127 represent the names of digital pins
# On most Arduino-like boards Pin D13 has an on-board LED connected.
# However Zerynth abstracts the board layout allowing to use LED0, LED1, etc as led names.
# In this example LED0 is used.

pinMode(LED0,OUTPUT)

# loop forever
while True:
    digitalWrite(LED0, HIGH)  # turn the LED ON by setting the voltage HIGH
    sleep(1000)               # wait for a second
    digitalWrite(LED0, LOW)   # turn the LED OFF by setting the voltage LOW
    sleep(1000)               # wait for a second


```
## ADC Analog to Digital Acquisition Basics 


The function for Analog to Digital convertion in ZERYNTH is adc.read()

The complete definition is adc.read(pin, samples=1) 

In this example simple ADC single pin acquisition and advanced multi sample ADC acquisition are reported.

In ZERYNTH ADC is also available as builtin analogRead() with the same signature of adc.read(). analogRead() is available only for compatibility with the Arduino world and will be deprecated in future versions of ZERYNTH.

tags: [First Steps,Analog Read ADC]
groups:[First Steps]


```main.py```

```python
################################################################################
# Analog Read
# 
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams  # import the streams module
import adc      # import the adc driver 

# create a stream linked to the default serial port
streams.serial() 

while True:
    
# Basic usage of ADC for acquiring the analog signal from a pin   
    value = adc.read(A0)
    print("One sample:",value)

# The complete definition of adc.read() is adc.read(pin, samples=1) 
# For an advanced usage of adc.read refer to the official Zerynth documentation

#acquire 10 samples with default sampling period    
    value2 = adc.read(A0,10)
    print("10 samples:\n",value2)
    
#acquire 3 samples from the first 4 analog pins of the board with default sampling period    
    value3= adc.read([A0,A1,A2,A3],3)
    print("3 samples from A0, A1, A2 and A3:\n",value3)

    print()
    sleep(300)
```
## ADC Analog to Digital Acquisition with Voltage Conversion

This basic examples shows how to read an analog voltage from pin 0, converts it to the corresponding voltage, and prints the result to the serial monitor.
To test it user can attach the center pin of a potentiometer to pin A0, and the other pins respectively to to +3.3V and GND.

tags: [Analog Read ADC, Sensors, First Steps]  
groups:[First Steps]


```main.py```

```python
################################################################################
# Analog Read to Voltage
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import adc      # import the adc module  

#create a serial port stream with default parameters
streams.serial()

while True:
       
    #read the input on analog pin 0
    sensor_value = adc.read(A0)
    
    #convert the analog reading (which goes from 0 - 4095.0) to a voltage (0 - 3.3V):
    voltage = sensor_value * (3.3 / 4095.0)
    
    #print out the raw and converted values:
    print("sensor raw value:", sensor_value,"Voltage:",voltage)
    
    sleep(300)



```
## ZERYNTH Oscilloscope

Simple usage of the analog acquisition and of the Python smart print functions.
The example shows how to print to the serial console the values read on an analog pin in a "scope" like graphicspretty way.


tags: [First Steps, Analog Read ADC, Serial]
groups:[First Steps]     


```main.py```

```python
###############################################################################
# Zerynth oscilloscope
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

import streams
import adc
   
streams.serial()

while True:
    value = adc.read(A4)
    conv = value*80//4095
    print("|","#"*conv," "*(80-conv),"|")
    sleep(200)
    
```
## Sensor driven Multi-Blink


This examples shows how to drive various behaviours taking as input an analog signal acquired through ADC fro driving three loop implemented as separated threads.
In particular, the implemented scripts drives three LEDs at three different frequencies calculated on the basis of the acquired analog signal.

The example is implemented using 4 threads that run in parallel. One thread is used for acquiring the analog signal and convert the acquired raw value in blinking frequencies usable by the LED driving threads. The other three threads are used to instantiate a generic blinking function that drive a PIN where a LED is connected.

tags:[Multi-Thread, First Steps, Analog Read ADC]
groups:[First Steps]   


```main.py```

```python
################################################################################
# Sensor Driven Multi-Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# This example requires an analog sensor and three LEDs
import streams
import adc

# create a serial port stream with default parameters
streams.serial()

# set the A1 pin as analog input and D8, D9, D10 as outputs to drive the LEDs. 
pinMode(A1,INPUT_ANALOG)
pinMode(D10,OUTPUT)
pinMode(D9,OUTPUT)
pinMode(D8,OUTPUT)

# creates two arrays for storing global variables to be used in the blinking threads
freq=[1,1,1]        
pin=[D8,D9,D10]    

# define the generic blinking function to be used for driving the LEDs
# this function takes as input the index identifying the LED, then uses the global freq and pin arrays to dynamically drive the LEDs
def blink(Npin):
    while True:
        digitalWrite(pin[Npin],HIGH)
        sleep(freq[Npin])
        digitalWrite(pin[Npin],LOW)
        sleep(freq[Npin])

# define an analog sensor sampling function that acquires the raw data and converts it to the three LED frequencies
def sampling():
    global freq
    while True:
        value = adc.read(A1)
        freq[0] = value//10
        freq[1] = freq[0] * 2
        freq[2] = freq[0] * 4
        sleep(50)

# launch the four threads        
thread(sampling)
thread(blink,0)
thread(blink,1)
thread(blink,2)

# The main loop is used only for printing out at reasonable speed the calculated frequencies in term of waiting times 
while True:
    print("Wait times are", freq)
    sleep(500)

```
## CAN Auto-baudrate


This example shows how to use the CAN interface library and how to detect baudrate.



```main.py```

```python
# CAN Auto-baudrate
# Created at 2020-02-10 16:39:24.048614

from fortebit.polaris import polaris
import can

polaris.init()

print("CAN Bus Auto-Baudrate Example")

# Initialize CAN transceiver
pinMode(polaris.internal.PIN_CAN_STANDBY, OUTPUT)
digitalWrite(polaris.internal.PIN_CAN_STANDBY, LOW)
sleep(100)

def can_auto_baudrate():
    print("Start auto baudrate...")
    for bps in (1000000,800000,500000,250000,125000,100000,50000,10000):
        print("Try",bps,"bps")
        try:
            canbus = can.Can(CAN0, bps, options=can.OPTION_LISTEN_ONLY)
        except Exception as e:
            print(e)
            continue
        try:
            canbus.add_filter(0,0)
            canbus.receive(timeout=500)
            print("Found baudrate:",bps)
            canbus.done()
            return bps
        except TimeoutError:
            pass
        except Exception as e:
            print(e)
        print("Errors",canbus.get_errors())
        canbus.done()
    print("Auto baudrate failed!")
    return None

bps = None
while bps is None:
    bps = can_auto_baudrate()
    sleep(1000)

print("Start active listening at",bps,"bps")
canbus = can.Can(CAN0, bps)
canbus.add_filter(0,0)
while True:
    try:
        msg = canbus.receive()
        print("ID",hex(msg[0] & can.FRAME_EXT_MASK),"IDE",(msg[0] & can.FRAME_EXT_FLAG) != 0,"RTR",(msg[0] & can.FRAME_RTR_FLAG) != 0,"DLC",msg[1],"DATA",[hex(b) for b in msg[2]])
    except Exception as e:
        print(e)

```
## Can Bus Example


This example shows how to use the CAN interface library.



```main.py```

```python
# Can Bus Example
# Created at 2019-12-17 16:21:55.938660

from fortebit.polaris import polaris
import can

polaris.init()

print("CAN Bus Auto-Baudrate Example")

# Initialize CAN transceiver
pinMode(polaris.internal.PIN_CAN_STANDBY, OUTPUT)
digitalWrite(polaris.internal.PIN_CAN_STANDBY, LOW)
sleep(100)

canbus = can.Can(CAN0, 500000)

def can_rx(timeout=-1):
    print("rx, listening...")
    msg = canbus.receive(timeout=timeout)
    print("ID",hex(msg[0] & can.FRAME_EXT_MASK),"IDE",(msg[0] & can.FRAME_EXT_FLAG) != 0,"RTR",(msg[0] & can.FRAME_RTR_FLAG) != 0,"DLC",msg[1],"DATA",[hex(b) for b in msg[2]])

def abort_rx():
    sleep(1000)
    print("abort rx")
    canbus.abort_receive()
    sleep(500)
    print("resume rx")
    canbus.resume_receive()
    
def abort_tx():
    sleep(1000)
    print("abort tx")
    canbus.abort_transmit()
    sleep(500)
    print("resume tx")
    canbus.resume_transmit()
    
f0 = canbus.add_filter(0,0)
f1 = canbus.add_filter(0x123|can.FRAME_EXT_FLAG,can.FRAME_EXT_MASK|can.FRAME_EXT_FLAG)
print("Filters",f0,f1)
canbus.del_filter(f0)
f2 = canbus.add_filter(0x456,can.FRAME_STD_MASK)
f3 = canbus.add_filter(0x88|can.FRAME_RTR_FLAG,can.FRAME_STD_MASK|can.FRAME_RTR_FLAG)
print("Filters",f1,f2,f3)

print("tx std data")
canbus.transmit(0x456,8,b'abcdefgh')

print("tx ext remote")
canbus.transmit(0x123|can.FRAME_EXT_FLAG|can.FRAME_RTR_FLAG,8)

print("Errors",canbus.get_errors())

thread(abort_rx)
try:
    can_rx()
except Exception as e:
    print(e)
sleep(1000)
can_rx()
canbus.done()


# test standby/wakeup
digitalWrite(polaris.internal.PIN_CAN_STANDBY, HIGH)
sleep(100)

sleeping = True
def wakeup():
    global sleeping
    if sleeping:
        sleeping = False
        onPinFall(CANRX0, None)
        print("CAN wakeup")

pinMode(CANRX0,INPUT_PULLUP)
onPinFall(CANRX0, wakeup)

print("Going to sleep...")
while sleeping:
    sleep(10)

digitalWrite(polaris.internal.PIN_CAN_STANDBY, LOW)


canbus = can.Can(CAN0, 500000)
f0 = canbus.add_filter(0,0)
print("Timeout rx 3s...")
try:
    can_rx(timeout=3000)
except Exception as e:
    print(e)

thread(abort_tx)
id=0
while id <= can.FRAME_STD_MASK:
    try:
        canbus.transmit((id<<18)|can.FRAME_EXT_FLAG|can.FRAME_RTR_FLAG,id&7)
        canbus.transmit(id+6,(id&7)+1,b'abcdefgh')
    except Exception as e:
        print(e)
        sleep(100)
    #sleep(50)
    id += 15

print("Errors",canbus.get_errors())

while True:
    can_rx()
    print("Errors",canbus.get_errors())

canbus.done()

```
## DAC Basic


A simple example to introduce Dac features.


```main.py```

```python
################################################################################
# Dac Basic
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello
################################################################################

import streams
import adc # for analogRead

import dac


def readInput():
    while True:
        print("reading A1: ",analogRead(A1))
        sleep(500)

streams.serial()
pinMode(A1,INPUT)

# read input in a separate thread
thread(readInput)

my_dac = dac.DAC(D8.DAC)
my_dac.start()

# circular mode: continuously repeat the input buffer
my_dac.write([100,200,900,800],1000,MILLIS,circular=True)

```
## Buzzer Driven through PWM

This example shows how to drive a buzzer using PWM. 
In the example a frequency ramp going from 100 Hz to 5 KHz is generated as drive.
The frequency is converted in period to be used as input of the pwm.rite function that require period and pulse to be expressed in milli or micro seconds (measure unit can be selected as extra parameter of the pwm.write function).
The PWM duty cycle is set to 50% driving the buzzer with a symmetric square wave. 

tags:[First Steps, Input Capture Unit ICU, Sound]  
groups:[First Steps]





```main.py```

```python
################################################################################
# Buzzer with PWM
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import pwm

#create a serial port stream with default parameters  
streams.serial()

# the pin where the buzzer is attached to
buzzerpin = D8.PWM 

pinMode(buzzerpin,OUTPUT) #set buzzerpin to output mode
frequency=100             #define a variable to hold the played tone frequency

while True:
    period=1000000//frequency #we are using MICROS so every sec is 1000000 of micros. // is the int division, pwm.write period doesn't accept floats
    print("frequency is", frequency,"Hz")
    
    #set the period of the buzzer and the duty to 50% of the period
    pwm.write(buzzerpin,period,period//2,MICROS)
        
    # increment the frequency every loop
    frequency = frequency + 20 
        
    # reset period
    if frequency >= 5000:
        frequency=100
        
    sleep(100) 
```
## LED Fade


This example shows hot to use PWM for fading a LED by changing the duty cycle in a for loop.





```main.py```

```python
################################################################################
# LED Fade
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi,  D. Mazzei
###############################################################################

import pwm

duty=0

pinMode(LED0,OUTPUT) # set the LED pin as output:

while True:
    for i in range(-100,100,1):   # create a loop for ranging the duty cycle from 0 to 100 MICROS
        duty=100-abs(i)
        pwm.write(LED0.PWM,100,duty,MICROS)     # set the pwm at the calculated duty with a fixed period of 100 MICROS
        sleep(10) # update the PWM every 10 millis  

```
## Input Capture Unit as PWM Analyzer


This examples shows how to use the Input Capture Unit of the board MCU for analysing a PWM signal 
The PWM is generated on PIN13 in order to have a feedbakc on the board embedded LED
PIN13 is also connected through a wire with PIN2 on which the ICU capture is activated
An interrupt is also attached on a PIN where a button is connected for changing the PWM duty.

Very Important: ICU and PWM are both timer powered embedded feature, it is impossible to run an ICU and a PWM
on two pin controlled by the same timer channel. 
Please refer to the board pinout in order to select the proper pins for your board
e.i: on a ST Nucleo this example use PWM2/1 for PIN13 and PWM1/3 for PIN2 so we are using two diferent embedded timers (first number on the PEM pin descrition)

Board setup:   
  PIN13-----PIN2  (shortcut the pins)
  BTNPin----GND   (connect a button between a pin and GND)  

tags: [First Steps, Input Capture Unit ICU, Interrupts, Analog Write PWM]  
groups:[First Steps]





```main.py```

```python
################################################################################
# Input Capture Unit as PWM Analyzer
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import pwm 
import icu
import streams

# create the serial port using default parameters  
streams.serial()

# define a pin where a button is connected, you can use the Nucleo button pin as input or change it with any other digital pin available

# this is the pin the button is connected to; for the various supported boards, Zerynth automatically translates it 
# to the board button. On Arduino DUE the user button isn't installed, so this line rises a compilation error.
# On Arduino DUE, change it to the pin your button is connected to or comment this line (see below)
buttonPin=BTN0


# define the ICU pin. D5 works with Arduino footprint boards while with Particle boards D0 can be used 
captPin=D5.ICU  # On Arduino like boards
#captPin=D0.ICU  # On Particle boards

# define the PWM pin. D13 works with Arduino footprint boards (and is also connected to a LED) while with Particle boards A4 can be used
pwmPin=D13.PWM # On Arduino like boards 
#pwmPin=A4.PWM # On Particle boards

# set the pin as input with PullUp, the button will be connected to ground
pinMode(buttonPin, INPUT_PULLUP)

# define a function for printing capture results on the serial port
def print_results(y):
    print("Time ON is:", y[0],"micros")
    print("Time OFF is:",y[1],"micros")
    print("Period is:", y[0]+y[1], "micros")
    print()
    
# define a global variable for PWM duty cycle and turn on the PWM

duty=10
pwm.write(pwmPin,100, duty,MICROS) #pwm.write needs (pn, period, duty, time_unit)

# define the function to be called for changing the PWM duty when the button is pressed
def pwm_control():
    global duty
    duty= duty+10
    if duty>=100:
        duty=0
    pwm.write(pwmPin, 100, duty,MICROS)
    print("Duty:", duty, "millis")
    
# Attach an interrupt on the button pin waiting for signal going from high to low when the button is pressed.
# pwm_control will be called when the interrupt is fired.
# If you are on Arduino DUE and you haven't connected any button comment the following line 
# you will not change the PWM duty but you can still test the ICU capture
onPinFall(buttonPin, pwm_control)

while True:
    # start an icu capture to be triggered when the pin rise.
    # this routine acquires 10 steps (HIGH or LOW states) or terminates after 50000 micros
    # this is a blocking function
    x = icu.capture(captPin,LOW_TO_HIGH,10,50000,MICROS)
    print("captured")
    # x is a list of step durations in microseconds, pass it to the printing function and check the serial console
    print_results(x)
    
    sleep(1000)
    

```
## ICU Capture IR Packets

Basic example of use of the ICU feature for capturing IR signals acquired through an IR demodulator.






```main.py```

```python
################################################################################
# ICU Capture IR Packets
#
# Created by Zerynth Team 2015 CC
# Authors: L. Rizzello, G. Baldi, D. Mazzei  
################################################################################

import icu
import streams
import pwm

streams.serial()

# Set the pin the IR receiver is connected to.
# In this example D2 is used: if you happen to have a TOI Shield on an Arduino compatible board
# you are good to go.
ir_pin = D2.ICU # when you want to use a particular pin function, just use the dot notation


def IR_capture():
    while True:
        print("Capturing...")
        # Starts capturing from the icu configured pin.
        # The capture starts from a selected trigger (in this case capture will start when the pin first goes from
        # HIGH to LOW).
        # The max number of samples to be collected and a maximum time window are specified.
        
        # Play with max number and time window to fit your remote protocol.
        # The following values are for the NEC IR (used by LG) protocol
        x = icu.capture(ir_pin,LOW,67,68,pull=HIGH)
        print(x,"\n captured n samples:",len(x))
               
    
# captures in a different thread
thread(IR_capture)

while True:
    print("alive!")
    sleep(1000)
```
## Timers Basics


Basic example of use of the timer module for monitoring the time during the program execution.
Timers can be used as alternative to the Arduino Millis().


tags=[First Steps, Timers]
groups:[First Steps]    


```main.py```

```python
################################################################################
# Timers Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import timers
import streams

# create a serial port with default parameters
streams.serial()

# create a new timer
t=timers.timer()
# start the timer
t.start()

minutes=0
   
while True:
    
    if t.get()>= 60000:        #check if 60 seconds are passed
        t.reset()              #timer can be reset
        minutes +=1
    seconds=t.get()//1000
    print("time is:", minutes,":",seconds) #just print the current value since timer start or last reset
    print("System time is:", timers.now(), "(millis)") #timers.now() gives the system time in milliseconds since program start
    print()
    
    sleep(500)                 #run every 500 millisec
```
## Timers Advanced Use


This example shows how ZERYNTH soft timers can be used to schedule functions execution.
ZERYNTH timers can be used as program time counter through the timer.start attribute or as recursive callers through the timer.interval method that takes as input the elapsing interval and the function to be called.
Moreover, it is also possible to activate a timer in one shot mode. In this case the function si called after the requested interval and then the timer stops

tags: [Timers, First Steps]  
groups:[First Steps]    







```main.py```

```python
################################################################################
# Timers Advanced Use

# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import timers
import streams

# create a serial port with default parameters
streams.serial()

# create new timers
tsec=timers.timer()
tminute=timers.timer()     
tshoot=timers.timer()

seconds=0
minutes=0

# define a function to call when the timer for seconds elapses
def secondpassed():
    global seconds
    seconds +=1
    print(seconds,"  seconds")
    if seconds==60:
        seconds=0

# define a function to call when the timer for minutes elapses
def minutepassed():
    global minutes
    minutes +=1
    print(minutes,"  minutes")
    
# define a function to call when the one shot timer elapses
def shootpassed():
    print("1 second ago was 1:30")
    
# start the timers for minutes and seconds
tsec.interval(1000,secondpassed)
tminute.interval(60000,minutepassed)
tsec.start()
tminute.start()
    
while True:
    
    if seconds==30 and minutes==1:                               # do a check on passed time to trigger a oneshot timer 
        tshoot.one_shot(1000, shootpassed)                       # this is a oneshot timer, it executes only one time
                
    print("timer minutes runs since:", tminute.get(),"timer seconds runs since:",tsec.get(), "millisec")         #just print the current value since start or last reset
    sleep(2500)                 #run every 2500 millisec
```
## Multi-Thread Basics


This examples shows the basics of ZERYNTH multi-threading
In ZERYNTH a thread require a function to be executed as input for the definition
the same function can be instanced by various thread giving you the possibility to write very concise and readable code.
In this example 4 threads are created as instances of the same function where different parameters are passed to the function when the thread is initialized

Note that the while True main loop typical of imperative programming is not present in this code. ZERYNTH allows pure thread driven implementation!

tags: [First Steps, Multi-Thread]   
groups:[First Steps]


```main.py```

```python
################################################################################
# Multi-Thread Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

# create a serial port with default parameters
streams.serial()

# Define a function to be used in the various threads.
# Parameters are passed to the function when the thread is created and then used in the thread loop.
# To be continuously executed by a thread a function requires an infinite loop,
# otherwise when the function terminates the thread is closed
     
def threadfn(number,delay):    
    
    while True:                    
        print("I am the thread",number)
        print("I run every:",delay,"msec")
        print()                # just add an empty line for console output readability 
        sleep(delay)

# create the various threads using the same function but passing different parameters        
thread(threadfn,1,500)
thread(threadfn,2,1000)
thread(threadfn,3,1300)
thread(threadfn,4,800)
   

```
## Multi LEDs Blink with threads

This examples shows how to use ZERYNTH threads for driving three LEDs with asymmetric and different blinking rates. 

Each Thread in ZERYNTH is a sort of separated and parallel process that runs autonomously on your board. 
With threads you can design your algorithm architecture assuming parallelism that is typical of high level programming languages. 
In this code a function is defined and then instanced by three threads creating a pool of parallel processes where three LEDs are driven 
at different frequencies. 

Moreover, thanks to Python argument passing, default values can be defined for function inputs. 
This way you can launch threads without specifying all the inputs required by the function, default values will fill the holes.
In this case all the parameters following 'blink' are passed to the functions as arguments.
thread(blink,pin,delayON,delayOFF) is equivalent to thread(blink(pin,delayON,delayOFF)).

tags: [Multi-Thread, First Steps, Digital I/O]
groups:[First Steps]  


```main.py```

```python
################################################################################
# Multi-Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# Initialize the digital pins where the LEDs are connected as output
pinMode(D2,OUTPUT)
pinMode(D8,OUTPUT)
pinMode(D5,OUTPUT)

# Define the 'blink' function to be used by the threads
def blink(pin,timeON=100,timeOFF=100): # delayON and delayOFF are optional parameters, used as default 
                                         # if not specified when you call the function
    while True:
        digitalWrite(pin,HIGH)   # turn the LED ON by making the voltage HIGH
        sleep(timeON)            # wait for timeON 
        digitalWrite(pin,LOW)    # turn the LED OFF by making the voltage LOW
        sleep(timeOFF)           # wait for timeOFF 

# Create three threads that execute instances of the 'blink' function.     
thread(blink,D2)             # D2 is ON for 100 ms and OFF for 100 ms, the default values of delayON an delayOFF
thread(blink,D8,200)         # D8 is ON for 200 ms and OFF for 100 ms, the default value of delayOFF
thread(blink,D5,500,200)     # D5 is ON for 500 ms and OFF for 200 ms
```
## Sensor driven Multi-Blink


This examples shows how to drive various behaviours taking as input an analog signal acquired through ADC fro driving three loop implemented as separated threads.
In particular, the implemented scripts drives three LEDs at three different frequencies calculated on the basis of the acquired analog signal.

The example is implemented using 4 threads that run in parallel. One thread is used for acquiring the analog signal and convert the acquired raw value in blinking frequencies usable by the LED driving threads. The other three threads are used to instantiate a generic blinking function that drive a PIN where a LED is connected.

tags:[Multi-Thread, First Steps, Analog Read ADC]
groups:[First Steps]   


```main.py```

```python
################################################################################
# Sensor Driven Multi-Blink
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# This example requires an analog sensor and three LEDs
import streams
import adc

# create a serial port stream with default parameters
streams.serial()

# set the A1 pin as analog input and D8, D9, D10 as outputs to drive the LEDs. 
pinMode(A1,INPUT_ANALOG)
pinMode(D10,OUTPUT)
pinMode(D9,OUTPUT)
pinMode(D8,OUTPUT)

# creates two arrays for storing global variables to be used in the blinking threads
freq=[1,1,1]        
pin=[D8,D9,D10]    

# define the generic blinking function to be used for driving the LEDs
# this function takes as input the index identifying the LED, then uses the global freq and pin arrays to dynamically drive the LEDs
def blink(Npin):
    while True:
        digitalWrite(pin[Npin],HIGH)
        sleep(freq[Npin])
        digitalWrite(pin[Npin],LOW)
        sleep(freq[Npin])

# define an analog sensor sampling function that acquires the raw data and converts it to the three LED frequencies
def sampling():
    global freq
    while True:
        value = adc.read(A1)
        freq[0] = value//10
        freq[1] = freq[0] * 2
        freq[2] = freq[0] * 4
        sleep(50)

# launch the four threads        
thread(sampling)
thread(blink,0)
thread(blink,1)
thread(blink,2)

# The main loop is used only for printing out at reasonable speed the calculated frequencies in term of waiting times 
while True:
    print("Wait times are", freq)
    sleep(500)

```
## Queues


Simple producer/consumer example based on thread safe queues.


```main.py```

```python
################################################################################
# Queues
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import threading
import streams
import queue


streams.serial()

# create a bounded queue
q = queue.Queue(maxsize=20)

# keep producing an element every 100 millis
def producer(id):
    while True:
        try:
            x = random(0,100)
            print("producer",id,"->",x)
            q.put(x)
        except Exception as e:
            print(e)
        sleep(100)

# keep consuming an element every 1 second
def consumer(id):
    while True:
        try:
            print("consumer",id,"<-",q.get())
        except Exception as e:
            print(e)
        sleep(1000)

# start everyone
thread(producer,0)
thread(consumer,1)
thread(consumer,2)

while True:
    isfull = q.full()
    print("Queue is full?",isfull)
    if isfull:
        # clear queue if full
        print("Clearing queue")
        q.clear()
    sleep(5000)

```
## Interrupt Basics


This example shows how to use interrupts for monitoring pin state changes.
A button is used to connect a pin to ground when pressed. The pin is set as INPUT_PULLUP putting HIGH voltage on it while activated as digital input.
It is possible to use onboard embedded button like in the case of ST Nucleo.
Otherwise an external button can be connected to any digital pin available on the board and then to GND. In this case the pin number have to be changed with the pin used for connecting the button

Note that the main loop (while True) is not present in this example. With ZERYNTH it is possible to write pure event driven code!

tags: [First Steps, Interrupts, Digital I/O]
groups:[First Steps]  



```main.py```

```python
################################################################################
# Interrupt Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

# create a serial port stream with default parameters
streams.serial()

# define where the button and the LED are connected
# in this case BTN0 will be automatically configured according to the selected board button
# change this definition to connect external buttons on any other digital pin
buttonPin=BTN0 
ledPin=LED0  # LED0 will be configured to the selected board led

# configure the pin behaviour to drive the LED and to read from the button  
pinMode(buttonPin,INPUT_PULLUP)
pinMode(ledPin,OUTPUT)

# define the function to be called when the button is pressed
def pressed():
        print("touched!")
        digitalWrite(ledPin,HIGH) # just blink the LED for 100 millisec when the button is pressed
        sleep(100)
        digitalWrite(ledPin,LOW)

# attach an interrupt on the button pin and call the pressed function when it falls
# being BTN0 configured as pullup, when the button is pressed the signal goes to from HIGH to LOW.
# opposite behaviour can be obtained with the equivalent "rise" interrupt function: onPinRise(pin,fun)
# hint: onPinFall and onPinRise can be used together on the same pin, even with different functions
onPinFall(buttonPin,pressed)




```
## Interrupt Advanced


This example uses pwm to show the advanced feature of interrupt debouncing.
PWM triggers fall and rise events at different speeds, but interrupts are triggered only if the debounce time (i.e. the stable time after and event) is in the correct range.


```main.py```

```python
################################################################################
# Interrupt Debounce
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# import streams
import streams
# import pwm for testing
import pwm


# CONNECT pin D3 to PIN D2 for this example to work!

streams.serial()

def on_touch_up():
    print("touched UP")

def on_touch_dn():
    print("touched DN")
    

    
try:    
    # D2 will call touch_up on rise and touch_dn on fall with different debounce times
    onPinRise(D2,on_touch_up,debounce=500)
    onPinFall(D2,on_touch_dn,debounce=300)
except Exception as e:
    print(e)




while True:
    for x in [100,200,300,400,500,600,700,800,900]:
        print("--->",x, 1000-x)
        # start pwm on D3 with the current period
        pwm.write(D3.PWM,1000,x)
        # now wait and check if debounce is working
        sleep(5000)
```
## Exceptions-Debugger Basic


Basic example of how to use the ZERYNTH Exceptions class to monitor and analyze programs behavior without crashing the execution.
The examples shows how a "division by zero" is identified in the code without causing any crash.
In ZERYNTH exceptions reported on the IDE serial console can be opened and analyzed through the integrated debugger window.

tags:[First Steps, Exceptions]
groups:[First Steps]  


```main.py```

```python
################################################################################
# Exception-Debugger Basics
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi,  D. Mazzei
###############################################################################

import streams

streams.serial()

while True:
    for x in range(-10,10,1):   # create a loop ranging on the integers between -10 and 10
        
        try:                    # open the Exception monitoring scope
            value=100//x        # when x=0 this will results in a DivisionByZero!
            print(value)
        except Exception as e:  # capture any raised exception as e
            print(e)            # print the content of e to monitor where the program is faulting
                                # click on the console X icon to open the Zerynth debugger window 
        sleep(1000)    
      

```
## Math Module


Some fun with math functions



```main.py```

```python
###############################################################################
# Math module
#
# Created by Zerynth Team 2017 CC
# Authors: G. Baldi
###############################################################################
import streams
import math 

streams.serial()


while True:
    # loop over angles in degrees
    print("---> TRIGONOMETRY!")
    for angle in range(0,360*3,10):
        # convert to radians
        r = math.radians(angle)
        # take the sin
        s = math.sin(r)
        # calculate offset...
        sl = int(40*s)
        # ...and print!
        if sl>=0:
            print(" "*40,"#"*sl)
        else:
            print(" "*(40+sl),"#"*(-sl))
        sleep(50)
    sleep(1000)

    # loop from -5 to 0 in 0.05 increments
    print("---> EXPONENTIALS")
    x = -5
    incr = 0.05
    while x<0:
        # take the exp...
        y = math.exp(x)
        # ...and print!
        print("#"*int(y*80))
        # do not forget to increment x
        x = x + incr
        sleep(50)
    sleep(1000)
    
    print("---> ROOTS and POWERS")
    # loop from 1 to 100
    print(" a   |  b   |  c   | math.sqrt(a*a*+b*b)")
    print("----------------------------------------")
    for i in range(0,100):
        # let's generate and test Pythagorean Triples!
        # select n and m
        m = 1
        n = 0
        while m>=n:
            n = random(1,30)
            m = random(1,30)
        
        a = math.pow(n,2)-math.pow(m,2)
        b = 2*m*n 
        c = math.pow(n,2)+math.pow(m,2)
        a2 = math.pow(a,2)
        b2 = math.pow(b,2)
        p = math.sqrt(a2+b2)
        
        print("%4.0f | %4.0f | %4.0f | %4.0f"%(a,b,c,p))
        sleep(100)
    sleep(1000)

```
## Mini Web Server


This example implements a very minimal web server by opening a TCP socket
in listening mode, reading HTTP headers and sending out some HTML.

It prints the IP to connect to in the serial console. Type it in your browser
and test your mini web server!

It uses the CC3000 wireless driver, however any network driver can be used
changing only a few lines of code.





```main.py```

```python
###############################################################################
# Mini Web Server
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################

# import streams & socket
import streams
import socket

# import the wifi interface
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the CC3000 driver (Particle Core or CC3000 Wifi shields)
# from texas.cc3000 import cc3000 as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
# from broadcom.bcm43362 import bcm43362 as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()
# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# Yes! we are connected
print("Linked!")

# Let's print our ip, it will be needed soon
info = wifi.link_info()
print("My IP is:",info[0])

# Now let's create a socket and listen for incoming connections on port 80
sock = socket.socket()
sock.bind(80)
sock.listen()


while True:
    try:
        # Type in your browser the board ip!
        print("Waiting for connection...")
        # here we wait for a connection
        clientsock,addr = sock.accept()
        print("Incoming connection from",addr)
        
        # yes! a connection is ready to use
        # first let's create a SocketStream
        # it's like a serial stream, but with a socket underneath.
        # This way we can read and print to the socket
        client = streams.SocketStream(clientsock)
        
        # let's read all the HTTP headers from the browser
        # stop when a blank line is received
        line = client.readline()
        while line!="\n" and line!="\r\n":
            line = client.readline()
        print("HTTP request received!")
        
        # let's now send our headers (very minimal)
        # hint: \n is added by print
        print("HTTP/1.1 200 OK\r",stream=client)
        print("Content-Type: text/html\r",stream=client)
        print("Connection: close\r\n\r",stream=client)
        # see? as easy as print!
        print("<html><body>Hello Zerynth!",random(0,100),"</body></html>",stream=client)
        # close connection and go waiting for another one
        client.close()
    except Exception as e:
        print("ooops, something wrong:",e)

```
## ZERYNTH UDP pinger


This example demonstrates the use of UDP sockets. A writer thread sends UDP broadcast packets while a reader
threads catches them. Uplink this script on more than one board for some pinger fun!



```main.py```

```python
################################################################################
# Zerynth UDP pinger
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# import streams & socket
import streams
import socket

# import the wifi interface
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the CC3000 driver (Particle Core or CC3000 Wifi shields)
# from texas.cc3000 import cc3000 as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
# from broadcom.bcm43362 import bcm43362 as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
    # get our ip
    myip = wifi.link_info()[0]
    # convert myip to a tuple with the socket.ip_to_tuple function
    # "x.y.z.w" becomes (x,y,z,w)
    ip_tuple = socket.ip_to_tuple(myip)
    # generate a broadcast address to port 9999
    # (it's ok and easier to generate it as a 5 number tuple)
    broadcast = (ip_tuple[0],ip_tuple[1],ip_tuple[2],255,9999)
    print(myip,ip_tuple,broadcast)
    # create an UDP socket and bind it to port 9999
    sock = socket.socket(type=socket.SOCK_DGRAM)
    sock.bind(9999)
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

        
# this function will be used as a thread
# sending every 2 seconds a message to all
# the udp sockets listening on port 9999 
def ping():
    while True:
        print("Sending")
        sock.sendto("Hello Zerynth!",broadcast)
        sleep(2000)
        
# launch it!
thread(ping)

# in the main thread we listen for incoming udp packets
while True:
    print("Receiving pings")
    try:
        # recvfrom returns both the packet data and the address of the sender
        data,address = sock.recvfrom(32)
        # since we bind to 9999 we also receive the packets we sent
        # check for it by comparing just the ip address (without the port)
        if address[0]!=myip:
            print("Received ping from",address,"=>",str(data))
        else:
            print("Received ping from myself!")
    except Exception as e:
        print(e)
# uplink this script to more than one board and check

```
## UDP NTP Time


This example uses UDP socket to make client requests to an NTP server.

The received timestamp is printed on the serial console in a human-readable
form.



```main.py```

```python
# UDP NTP Time
# Created at 2019-02-19 08:07:55.144570

import streams
import socket

# import the wifi interface
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# This example can be used as is with ESP32 based devices
from espressif.esp32net import esp32wifi as wifi_driver


def ntc_ts_to_datetime(t):
    # convert NTP timestamp (seconds since January 1st 1900) to datetime formatted string
    # YYYY-mm-dd HH:MM:SS
    ts = t - 2208988800

    s = ts % 60
    ts //= 60
    m = ts % 60
    ts //= 60
    h = ts % 24
    ts //= 24

    a = (4 * ts + 102032) // 146097 + 15
    b = (ts + 2442113 + a - (a//4))
    c = (20 * b - 2442) // 7305
    d =  b - 365* c - (c // 4)
    e = d * 1000 //30601
    f = d - e*30 - e*601//1000

    if e <= 13:
        c-=4716
        e -= 1
    else:
        c -= 4715
        e -= 13

    Y = c
    M = e
    D = f

    return "%d-%02d-%02d %02d:%02d:%02d"%(Y, M, D, h, m, s)


try:
    streams.serial()

    # init the wifi driver!
    # The driver automatically registers itself to the wifi interface
    # with the correct configuration for the selected board
    wifi_driver.auto_init()

    # use the wifi interface to link to the Access Point
    # change network name, security and password as needed
    print("Establishing WiFi Link...")
    for retry in range(5):
        try:
            # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
            # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
            wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
            print("...done!")
            break
        except Exception as e:
            pass
    else:
        print(":( can't connect to wifi")
        raise IOError

    # create an UDP socket and set a timeout of 1 second
    sock = socket.socket(type=socket.SOCK_DGRAM)
    sock.settimeout(1000)

    # create an NTP request packet
    pkt = bytearray([0]*48)
    pkt[0] = 0x1B

    while True:
        try:
            # resolve the NTP server hostname to get its IP address
            ip_string = wifi.gethostbyname("0.pool.ntp.org")
            ip = socket.ip_to_tuple(ip_string)

            # create a tuple containing NTP server ip address and port
            addr = (ip[0], ip[1], ip[2], ip[3], 123)

            print("Sending NTP request to %s:%d" %(ip_string, 123))
            # send the NTP request packet to the NTP server
            sock.sendto(pkt, addr)

            # read the response from the server
            res = sock.recv(48)

            # extract the "transmit timestamp" field from the received packet
            ts =  (res[40]<<24) | (res[41]<<16) | (res[42]<<8) | res[43]

            # convert NTP timestamp to human readable datetime
            print(" >", ntc_ts_to_datetime(ts))
            print(" ")
        except Exception as e:
            print(" >", e)
        sleep(10000)

except Exception as e:
    print(e)

```
## ZERYNTH wifi scan


This example explains how to scan for wifi networks.



```main.py```

```python
################################################################################
# Zerynth wifi scan
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# import streams & socket
import streams
import socket

# import the wifi interface
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# FOR THIS EXAMPLE TO WORK, A NETWORK DRIVER MUST BE SELECTED BELOW

# uncomment the following line to use the CC3000 driver (Particle Core or CC3000 Wifi shields)
# from texas.cc3000 import cc3000 as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
# from broadcom.bcm43362 import bcm43362 as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()

# a list of security strings
wifi_sec=["Open","WEP","WPA","WPA2"]
try:
    print("Scanning for 15 seconds...")
    # start scanning for 15000 milliseconds
    res = wifi.scan(15000)
    
    # if everything goes well, res is a sequence of tuples
    # each tuple contains:
    # -ssid: the name of the network
    # -sec: the security type of the network, from 0 to 3
    # -rssi: the strength of the signal, from 0 to 127
    # -bssid: the mac address of the access point
    for ssid,sec,rssi,bssid in res:
        print(ssid,"::",wifi_sec[sec],":: strength ",rssi*100/127)
except Exception as e:
    print(e)
```
## ZERYNTH Time API


This example connects via HTTP to timeapi.org to get the current UTC time 





```main.py```

```python
################################################################################
# Zerynth Time API
#
# Created: 2015-08-17 16:44:58.640097
#
################################################################################

# import streams
import streams
import json

# import the wifi interface
from wireless import wifi

# import the http module
import requests

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# THIS EXAMPLE IS SET TO WORK WITH BCM43362 WIFI DRIVER

# uncomment the following line to use the espressif esp8266 wifi driver (NodeMcu v2, Adafruit Feather Huzzah, Wemos d1 Mini, ...)
# from espressif.esp8266wifi import esp8266wifi as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
from broadcom.bcm43362 import bcm43362 as wifi_driver

# uncomment the following line to use the ESP32 driver (Sparkfun Esp32 Thing, Olimex Esp32, ...)
# from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
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
## ZERYNTH Weather


This example connects to openweathermap.org, queries for weather conditions and prints the result.



```main.py```

```python
################################################################################
# Zerynth Weather
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################



# import streams & socket
import streams
import socket

# import json parser, will be needed later
import json

# import the wifi interface
from wireless import wifi

# import the http module
import requests

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# THIS EXAMPLE IS SET TO WORK WITH ESP8266 WIFI DRIVER

# uncomment the following line to use the espressif esp8266 wifi driver (NodeMcu v2, Adafruit Feather Huzzah, Wemos d1 Mini, ...)
from espressif.esp8266wifi import esp8266wifi as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
# from broadcom.bcm43362 import bcm43362 as wifi_driver

# uncomment the following line to use the ESP32 driver (Sparkfun Esp32 Thing, Olimex Esp32, ...)
# from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()


# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# let's try to connect to openweathermap.org to get some weather info
# for this example to work you need a openweathermap API key
# if you don't have one, you can get one for free here: http://openweathermap.org/price

# type here your API key!
# or you can use ours...however, if our calls quota is exceded 
# the example won't work :(
api_key = "bd4ba90e2b397e24a925e436a9d8fed9"
        
for i in range(3):
    try:
        print("Trying to connect...")
        # to get weather info you need to specify a correct api url
        # there are a lot of different urls with different functions
        # they are all documented here http://openweathermap.org/api
        
        # let's put the http query parameters in a dict
        params = {
            "APPID":api_key,
            "q":"Pisa"   # <----- here it goes your city
        }
        
        # the following url gets weather information in json based on the name of the city
        url="http://api.openweathermap.org/data/2.5/weather"
        # url resolution and http protocol handling are hidden inside the requests module
        response = requests.get(url,params=params)
        # if we get here, there has been no exception, exit the loop
        break
    except Exception as e:
        print(e)


try:
    # check status and print the result
    if response.status==200:
        print("Success!!")
        print("-------------")
        # it's time to parse the json response
        js = json.loads(response.content)
        # super easy!
        print("Weather:",js["weather"][0]["description"],js["main"]["temp"]-273,"degrees")
        print("-------------")
except Exception as e:
    print("ooops, something very wrong! :(",e)




```
## HTTP Methods


This example connects via HTTP to httpbin.org and tests each Zerynth supported HTTP method





```main.py```

```python
################################################################################
# Zerynth HTTP Methods
#
# Created: 2017-09-19 12:35:25.155721
# Authors: M. Cipriani
################################################################################

# import streams
import streams
import json

# import the wifi interface
from wireless import wifi

# import the http module
import requests

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# THIS EXAMPLE IS SET TO WORK WITH ESP32 WIFI DRIVER

# uncomment the following line to use the espressif esp8266 wifi driver (NodeMcu v2, Adafruit Feather Huzzah, Wemos d1 Mini, ...)
# from espressif.esp8266wifi import esp8266wifi as wifi_driver

# uncomment the following line to use the BCM43362 driver (Particle Photon)
# from broadcom.bcm43362 import bcm43362 as wifi_driver

# uncomment the following line to use the ESP32 driver (Sparkfun Esp32 Thing, Olimex Esp32, ...)
from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Zerynth",wifi.WIFI_WPA2,"zerynthwifi")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

url = "http://httpbin.org/"

tests = [
    {
        "title": "Testing GET Method...",
        "method": requests.get,
        "url": url+"get",
        "params": {"test": "query_string"}
    },
    {
        "title": "Testing POST Method...",
        "method": requests.post,
        "url": url+"post",
        "json": {"test": "json_data"}
    },
    {
        "title": "Testing PUT Method...",
        "method": requests.put,
        "url": url+"put",
        "data": {"test": "urlencoded_data"}
    },
    {
        "title": "Testing PATCH Method...",
        "method": requests.patch,
        "url": url+"patch",
        "data": {"test": "urlencoded_data"}
    },
    {
        "title": "Testing DELETE Method...",
        "method": requests.delete,
        "url": url+"delete",
    },
    {
        "title": "Testing HEAD Method...",
        "method": requests.head,
        "url": url+"get",
    },
    {
        "title": "Testing OPTIONS Method...",
        "method": requests.options,
        "url": url+"get",
    }
]

print("---------------------------------")
for test in tests:
    try:
        print(test["title"])
        if "params" in test:
            response = test["method"](test["url"], params=test["params"])
        elif "json" in test:
            response = test["method"](test["url"], json=test["json"])
        elif "data" in test:
            response = test["method"](test["url"], data=test["data"])
        else:
            response = test["method"](test["url"])
        print("Http Status:",response.status)
        print("Http Headers:",response.headers)
        print("Http Content:",response.content)
        print("---------------------------------")
        response = None
    except Exception as e:
        print(e)
    sleep(2000)
```
## Secure HTTP


This example connects to https://howsmyssl.com/a/check and displays info about the SSL/TLS connection



```main.py```

```python
################################################################################
# Zerynth Secure Sockets
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import json
# import the wifi interface
from wireless import wifi
# import the http module
import requests
import ssl

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# This example can be used as is with ESP32 based devices
from espressif.esp32net import esp32wifi as wifi_driver


streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()


# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# let's try to connect to https://www.howsmyssl.com/a/check to get some info
# on the SSL/TLS connection

# retrieve the CA certificate used to sign the howsmyssl.com certificate
cacert = __lookup(SSL_CACERT_DST_ROOT_CA_X3)

# create a SSL context to require server certificate verification
ctx = ssl.create_ssl_context(cacert=cacert,options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH)
# NOTE: if the underlying SSL driver does not support certificate validation
#       uncomment the following line!
# ctx = None


for i in range(3):
    try:
        print("Trying to connect...")
        url="https://www.howsmyssl.com/a/check"
        # url resolution and http protocol handling are hidden inside the requests module
        user_agent = {"User-Agent": "curl/7.53.1", "Accept": "*/*" }
        # pass the ssl context together with the request
        response = requests.get(url,headers=user_agent,ctx=ctx)
        # if we get here, there has been no exception, exit the loop
        break
    except Exception as e:
        print(e)


try:
    # check status and print the result
    if response.status==200:
        print("Success!!")
        print("-------------")
        # it's time to parse the json response
        js = json.loads(response.content)
        # super easy!
        for k,v in js.items():
            if k=="given_cipher_suites":
                print("Supported Ciphers")
                for cipher in v:
                    print(cipher)
                print("-----")
            else:
                print(k,"::",v)
        print("-------------")
except Exception as e:
    print("ooops, something very wrong! :(",e)

```
## NTPClient


A simple example showing how to obtain a timestamp from an NTP server and how to convert it to UTC datetime.



```main.py```

```python
################################################################################
# NTPClient using UDP
#
# Created: 2019-06-16
# Author: L. Marsicano
################################################################################

import streams
import ntpclient 

streams.serial()

# import the wifi interface
from wireless import wifi

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# This example can be used as is with ESP32 based devices
from espressif.esp32net import esp32wifi as wifi_driver
def ntc_ts_to_datetime(t):
   ts = t - 2208988800
    
   s = ts % 60
   ts //= 60
   m = ts % 60
   ts //= 60
   h = ts % 24
   ts //= 24

   a = (4 * ts + 102032) // 146097 + 15
   b = (ts + 2442113 + a - (a//4))
   c = (20 * b - 2442) // 7305
   d =  b - 365* c - (c // 4)
   e = d * 1000 //30601
   f = d - e*30 - e*601//1000

   if e <= 13:
       c-=4716
       e -= 1
   else:
       c -= 4715
       e -= 13

   Y = c
   M = e
   D = f

   return "%d-%02d-%02d %02d:%02d:%02d"%(Y, M, D, h, m, s)

try:
    wifi_driver.auto_init()
    for i in range(0, 5):
        try:
            # Change this line to match your network configuration
            wifi.link("SSID",wifi.WIFI_WPA2,"PASSWORD")
            break
        except Exception as e:
            print(e)
            sleep(500)
    else:
        print("Could not link :(")
        raise IOError

    client = ntpclient.NTPClient(wifi_driver)
    t = client.get_time()
    print("Time is", t)
    print("Converted time is:", ntc_ts_to_datetime(t))
except Exception as e:
    print(e)


```
## Secure HTTP


This example connects to https://howsmyssl.com/a/check and displays info about the SSL/TLS connection



```main.py```

```python
################################################################################
# Zerynth Secure Sockets
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import json
# import the wifi interface
from wireless import wifi
# import the http module
import requests
import ssl

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
# This example can be used as is with ESP32 based devices
from espressif.esp32net import esp32wifi as wifi_driver


streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()


# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# let's try to connect to https://www.howsmyssl.com/a/check to get some info
# on the SSL/TLS connection

# retrieve the CA certificate used to sign the howsmyssl.com certificate
cacert = __lookup(SSL_CACERT_DST_ROOT_CA_X3)

# create a SSL context to require server certificate verification
ctx = ssl.create_ssl_context(cacert=cacert,options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH)
# NOTE: if the underlying SSL driver does not support certificate validation
#       uncomment the following line!
# ctx = None


for i in range(3):
    try:
        print("Trying to connect...")
        url="https://www.howsmyssl.com/a/check"
        # url resolution and http protocol handling are hidden inside the requests module
        user_agent = {"User-Agent": "curl/7.53.1", "Accept": "*/*" }
        # pass the ssl context together with the request
        response = requests.get(url,headers=user_agent,ctx=ctx)
        # if we get here, there has been no exception, exit the loop
        break
    except Exception as e:
        print(e)


try:
    # check status and print the result
    if response.status==200:
        print("Success!!")
        print("-------------")
        # it's time to parse the json response
        js = json.loads(response.content)
        # super easy!
        for k,v in js.items():
            if k=="given_cipher_suites":
                print("Supported Ciphers")
                for cipher in v:
                    print(cipher)
                print("-----")
            else:
                print(k,"::",v)
        print("-------------")
except Exception as e:
    print("ooops, something very wrong! :(",e)

```
## RTC Keep Time


This example downloads a time reference for the Real-Time Clock from the Internet and retrieves updated time from the RTC itself for subsequent use.




```main.py```

```python
################################################################################
# RTC Keep Time
#
# Created by Zerynth Team 2018 CC
# Authors: G. Baldi, L. Rizzello
################################################################################

import streams
import json
import requests

from wireless import wifi
# import a wifi driver to connect and retrieve base timestamp
from espressif.esp32net import esp32wifi as wifi_driver

# import Real-Time Clock module
import rtc

def get_epoch():
    user_agent = {"user-agent": "curl/7.56.0"}
    return int(json.loads(requests.get("http://now.zerynth.com/", headers=user_agent).content)['now']['epoch'])

streams.serial()
wifi_driver.auto_init()

print('connecting to wifi...')
try:
    wifi.link("SSID",wifi.WIFI_WPA2,"PSW")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

timestamp = get_epoch()
rtc.set_utc(timestamp)
while True:
    tm = rtc.get_utc()
    print(tm.tv_seconds)
    print(tm.tm_year,'/',tm.tm_month,'/',tm.tm_mday,sep='')
    print(tm.tm_hour,':',tm.tm_min,':',tm.tm_sec,sep='')
    sleep(1000)


```
## ZERYNTH Resources


This example explains the use of flash resources.




```main.py```

```python
################################################################################
# Zerynth Resources
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams

streams.serial()

# new_resource is a builtin that includes the file specified
# in the generated bytecode
# remember: the file used as a resource must be added to the project!
new_resource("mytxt.txt")

# to open resources saved by new_resource
# a specific url must be passed to open
# once opened, methods like read, readline and seek can be used!
ff = open("resource://mytxt.txt")

print("Opening resource...")
while True:
    
    # let's read line by line and print
    line = ff.readline()
    
    # if line is empty, we are at the end of file
    if not line:
        break
        
    print("Line:",line)

# easy!
print("Done!")
    
```
## Struct Example


Test pack and unpack methods with different formats


```main.py```

```python
################################################################################
# struct
#
# Created by Zerynth Team 2017 CC
# Authors: G. Baldi, M. Cipriani
################################################################################

import streams
import struct

streams.serial()

def print_res(b):
    print("Pack -->\n ",end="")
    for x in b:
        print(hex(x,prefix=""),end="")
    print("")

try:
    print("Create pack for 0x01020304 in >xl format")
    b = struct.pack(">xl",0x01020304)
    u = struct.unpack(">xl",b)
    print_res(b)
    print("Unpack -->\n", hex(u[0]))
    print("-------------------------------------------------")
    print("Create pack for a in 10s format")
    b = struct.pack("10s","a")
    u = struct.unpack("10s",b)
    print_res(b)
    print("Unpack -->\n", u[0])
    print("-------------------------------------------------")
    print("Create pack for a in 10p format")
    b = struct.pack("10p","a")
    u = struct.unpack("10p",b)
    print_res(b)
    print("Unpack -->\n", u[0])
    print("-------------------------------------------------")
    print("Create pack for (1,2,3.0) in blf format")
    b = struct.pack("blf",1,2,3.0)
    u = struct.unpack("blf",b)
    print_res(b)
    print("Unpack -->\n", u)
    print("-------------------------------------------------")
    print("Create pack for (-1,9,1.2) in =hlf format")
    b = struct.pack("=hlf",-1,9,1.2)
    u = struct.unpack("=hlf",b)
    print_res(b)
    print("Unpack -->\n", u)
    print("-------------------------------------------------")
    print("Create pack for (127,10,5.5) in =blf format")
    b = struct.pack("=blf",127,10,5.5)
    u = struct.unpack("=blf",b)
    print_res(b)
    print("Unpack -->\n", u)
except Exception as e:
    print(e)

while True:
    print(".")
    sleep(1000)
```
## Flash Internal


Writing and reading internal flash files.


```main.py```

```python
################################################################################
# iflash
#
# Created: 2016-03-22 15:54:21.232663
#
################################################################################

import streams
import json
import flash

## Warning! This example works on the Particle Photon only!
# You need to change the flash address to use another board
#  --> For Sam3X based boards you can safely use 0xe0000

streams.serial()


print("create flash file")

# open a 512 bytes FlashFileStream at address 0x80E0000
ff = flash.FlashFileStream(0x80E0000,512)

print("reading flash file")

for i in range(30):
    print(i,"->",str(ff[i]))

print("writing flash file")

sleep(1000)

hh = {
    "type":"thing",
    "data":23.5
}

ds = json.dumps(hh)

# save length and json to flash
ff.write(len(ds))
ff.write(ds)

ff.flush()

ff.seek(0,streams.SEEK_SET)

print("reading flash file")

n = ff.read_int()

for i in range(n+4):
    print(i,"->",str(ff[i]))

```
## Spi Flash


An example of how to use the spiflash library to read Spi Flash chips.


```main.py```

```python
################################################################################
# SpiFlash Example
#
# Created: 2016-04-21 19:16:44.440555
#
################################################################################

import spiflash
import streams

streams.serial()


my_flash = spiflash.SpiFlash(SPI0, D25)

my_flash.erase_sector(0x30122)

to_w = [235,166,128,124,65,66]
# write data through bracket notation
my_flash[0x30122] = to_w

print("---")

# read 8 bytes starting from 0x30122 address
for x in my_flash.read_data(0x30122,8):
    print(x)

print("---")

# read the same 8 bytes through bracket notation
for x in my_flash[0x30123:0x30123+8]:
    print(x)

print("---")

```
## QSpi Flash


An example of how to use the qspiflash library to read QSpi Flash chips.



```main.py```

```python
################################################################################
# QSpiFlash Example
#
################################################################################

import qspiflash
import streams

streams.serial()

my_flash = qspiflash.QSpiFlash()

my_flash.erase_block(0)

to_w = b'\x77\x76\x75\x74\x73\x72'
# write data through bracket notation
my_flash[0] = to_w

print("---")

# read 8 bytes starting from 0 address
for x in my_flash.read_data(0, 8):
    print('%02x' % x)

print("---")

# read the same 8 bytes through bracket notation
for x in my_flash[1:1+8]:
    print('%02x' % x)

print("---")


```
## Spi SD


An example of how to use spisd libray to read SD cards block by block.


```main.py```

```python
################################################################################
# SpiSD Example
#
# Created: 2016-04-29 12:37:53.316436
#
################################################################################

import spisd
import streams

streams.serial()


my_sd = spisd.SpiSD(SPI0, D25)
data = bytearray(512*2)
for i in range(512*2):
    data[i] = 166

# write 512 bytes of data starting from 3rd block
my_sd.write_data(3,data)

# read 512*3 bytes of data starting from 3rd block
for i, x in enumerate(my_sd.read_data(3,3)):
    print(hex(0x200*3+i),": ",x)

```
## Filesystem


A simple example to show the filesystem support in Zerynth (FATFS on SD with SPI)


```main.py```

```python
import streams

import fatfs # import driver module
import os    # import file/directory management module

streams.serial()


# mount my SD card as volume 0 through SPI protocol
fatfs.mount('0:', {"drv": SPI0, "cs": D25, "clock": 1000000} )

# mount my SD card as volume 0 trough SD mode
# (be careful in choosing frequency (kHz) and bits supported by your board)
# fatfs.mount('0:', {"drv": SD1, "freq_khz": 20000, "bits": 1})

# create "zerynth.txt" file and open it for read/write operations
ww = os.open('0:zerynth.txt', 'w+')

# write a string on it, flushing data immediately (not waiting for file to be closed)
ww.write("Zerynth allows me to easily manage files, cool.", sync = True)


# ops, I forgot what I wrote...
# not a real problem problem using Zerynth

# back to the start
ww.seek(0)
print("I wrote: ", ww.read())

ww.close()

# files and directories in root folder?
print(os.listdir('.'))


# a folder for zerynth stuff is needed
if not os.exists("0:zerynth_stuff"):
    os.mkdir("0:zerynth_stuff")
    
# copy my cool file    
os.copyfile("zerynth.txt","zerynth_stuff/zerynth_cool.txt")
os.chdir("0:zerynth_stuff")

# check if anything went wrong
print("in ", os.getcwd())
print(os.listdir('.'))

print("SUCCESS!")

```
## MCU Reset


A simple example showing how to soft reset the microcontroller from Python.



```main.py```

```python
###############################################################################
# MCU Reset
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
###############################################################################


# import the mcu module
import mcu
import streams

# open the default serial port, the output will be visible in the serial console
streams.serial()  

resetting = False
# define a simple function to be called on interrupt
def reset():
    global resetting
    resetting=True

# on button pressed, call reset
# >>>> if the board hasn't a button, change BTN0 to a digital pin
#      and use a jumper wire to simulate a falling edge <<<<
onPinFall(BTN0,reset)

# loop forever
while True:
    print("Hello Zerynth!")
    sleep(1000)
    # check for the need to reset
    if resetting:
        print("Resetting in 3 seconds!!")
        sleep(3000)
        mcu.reset()
        # bye!
```
## C Interface


This advanced example shows how to call C functions from Python.




```main.py```

```python
################################################################################
# C Interface
#
# Created: 2016-01-17 10:06:10.333915
#
################################################################################

import streams

streams.serial()

# define a Python function decorated with c_native.
# This function has no body and will instead call
# the C function specified in the decorator.
# The source file(s) where to find the C function must be given (cdiv.c)
@c_native("_my_c_function",["cdiv.c"],[])
def c_division(a,b):
    pass


while True:
    a = random(0,100)
    b = random(0,10)
    try:
        # call the c_division function with random values
        c = c_division(a,b)
        print(a,"/",b,"=",c)
    except Exception as e:
        print(e)
    sleep(1000)
```
## Secure Hash Functions


A simple example to introduce Secure Hashes of the crypto module



```main.py```

```python
################################################################################
# Secure Hash
#
# Created by Zerynth Team 2017 CC
# Authors: G.Baldi
################################################################################

import streams

# import all supported hash functions
from crypto.hash import md5 as md5
from crypto.hash import sha1 as sha1
from crypto.hash import sha2 as sha2
from crypto.hash import sha3 as sha3
from crypto.hash import keccak as keccak
# also import HMAC
from crypto.hash import hmac as hmac

# open stdout
streams.serial()

message = "Zerynth"

while True:
    try:
        ss = md5.MD5()
        ss.update(message)
        print("MD5: ",ss.hexdigest())

        ss = sha1.SHA1()
        ss.update(message)
        print("SHA1:",ss.hexdigest())
        
        ss = sha2.SHA2(sha2.SHA512)
        ss.update(message)
        print("SHA2:",ss.hexdigest())
        
        ss = sha3.SHA3()
        ss.update(message)
        print("SHA3:",ss.hexdigest())

        ss = keccak.Keccak()
        ss.update(message)
        print("KECCAK:",ss.hexdigest())

        # generate a hmac with key="Python" and sha1 hash
        hh = hmac.HMAC("Python",sha1.SHA1())
        hh.update(message)
        print("HMAC:",hh.hexdigest())
    except Exception as e:
        print(e)
    sleep(2000)

```
## Elliptic Curve Cryptography


A simple example to introduce ECDSA primitives.



```main.py```

```python
################################################################################
# Elliptic Curve Cryptography
#
# Created by Zerynth Team 2017 CC
# Authors: G. Baldi
################################################################################

import streams

# import ecc and sha1 modules
from crypto.ecc import ecc as ec
from crypto.hash import sha1 as sha1

streams.serial()

message = "Zerynth"

# import a Public Key for SECP256R1
pb = ec.hex_to_bin("7A181C7D3AD54EC3817CBAF86EA4E003AD492D8569102392A6EFE0C27E471A65553918EA1BAC86A68C78A30E9FE725EA499E14BEA96C3FE85E2267B74385E56B")
# import a Private Key for SECP256R1
pv = ec.hex_to_bin("6D5BE10E67D479FF99421A8DE030E2B4C5323EE477DA4C17420936CAC49C261E")

while True:
    # calculate hash of message
    ss = sha1.SHA1()
    ss.update(message)
    digest = ss.digest()

    # Calculate non deterministic signature of digest
    # for SECP256R1 and pv
    signature = ec.sign(ec.SECP256R1,digest,pv)
    
    # Calculate the deterministic signature of digest using SHA1
    deterministic_signature = ec.sign(ec.SECP256R1,digest,pv,deterministic=sha1.SHA1())

    print("PVKEY:",ec.bin_to_hex(pv))
    print("PBKEY:",ec.bin_to_hex(pb))
    # this changes each loop because of random number generator
    print("SIGNED:",ec.bin_to_hex(signature))
    # this is always the same
    print("SIGNED (det)",ec.bin_to_hex(deterministic_signature))

    print("VERIFY SIGNATURE:", ec.verify(ec.SECP256R1,digest,signature,pb))
    print("VERIFY SIGNATURE (det):", ec.verify(ec.SECP256R1,digest,deterministic_signature,pb))
    # tampered digests are detected
    print("VERIFY TAMPERED:", ec.verify(ec.SECP256R1,digest+b'\x00',signature,pb))
    print("-"*20)
    sleep(2000)

```
## Powersaving


This example shows the most important features of Powersaving enabled VMs:

* The ability to choose which low power mode to enter and how to exit
* The ability to save status on a special purpose memory guaranteed to be preserved after exiting the low power mode



```main.py```

```python
################################################################################
# Powersaving
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

##
## This example only works on a Powersaving enabled Virtual Machine!
##

import streams
# import the Power Management module
# Check documentation here: https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_pwr.html
import pwr

streams.serial()

# wake up reasons dictionary
reasons = {
    pwr.PWR_RESET:"System Reset",
    pwr.PWR_INTERRUPT: "Event on WAKEUP pin",
    pwr.PWR_TIMEOUT: "Timeout"
}

# modes and descriptions
modes = [
    (pwr.PWR_SLEEP, "Sleep mode"),
    (pwr.PWR_STOP, "Stop mode"),
    (pwr.PWR_STANDBY, "Standby mode")
]

# some status variables
slept = 0
wokeup = 0
sleep_counter = 0

# callback for Wake Up events on pins
def wakeup():
    print("Hello!")

# function to prepare for and enter low power mode
def sleepfn(delay,mode):
    global slept,wokeup
    print("Going to sleep for",delay,"milliseconds in",modes[mode][1])
    sleep(100)
    # call go_to_sleep and get the amount of time spent sleeping
    # !! the VM is suspended here !!
    slept = pwr.go_to_sleep(delay,modes[mode][0])
    # if we reach this point, something caused a Wake Up from a low power mode
    # if we don't reach here, the device exited from a standby mode with a system reset

    # retrieve the Wake Up reason
    wokeup = pwr.wakeup_reason()
    print("SLEPT FOR",slept)
    print("My wake up reason:",reasons.get(wokeup,"Unknown"))


try:

    # retrieve the Wake Up reason
    wokeup = pwr.wakeup_reason()
    
    # retrieve sleep_counter from special purpose memory if supported
    try:
        sleep_counter = pwr.get_status_byte(0)
        print("Special purpose memory supported!")
    except Exception as e:
        print("Special purpose memory not supported :(")
    
    # print status at VM startup
    print("Wake up reason at startup:",reasons.get(wokeup,"Unknown"))
    print("Tried to sleep",sleep_counter,"times")

    
    # configure button to do something
    # depending on the platform this is enough to configure a Wake Up event
    # on some platforms only specific pins have the Wake Up property
    # (If the device has no button, configure another pin! [Try D6 on MKR1000 and D8 on Hexiwear])
    pinMode(BTN0,INPUT_PULLUP)
    onPinFall(BTN0, wakeup, debounce=1000)
    
    cnt = 5
    mode = 0
    print("Countdown!")
    while True:
        # print the countdown
        print(cnt)
        sleep(1000)
        
        cnt-=1
        if cnt==0:
            cnt=5
            try:
                # save number of sleeps in special purpose memory
                sleep_counter=(sleep_counter+1)%256
                try:
                    pwr.set_status_byte(0,sleep_counter)
                except:
                    # ignore if special purpose memory not supported
                    pass
                # enter a low power mode for 5 seconds or less
                # (press the button while sleeping to check if Wake Up is available in this mode)
                sleepfn(5000,mode)
            except Exception as e:
                print(modes[mode][1],"not supported!")
                print(e)
            mode=(mode+1)%len(modes)
            print("Countdown!")
except Exception as e:
    print(e)
    
    
# Expected results by architecture and mode for Wake Up on pin event
#
#      MODE  |      SLEEP        STOP                 STANDBY
# MCU        |
# -------------------------------------------------------------------
#            |
# STM32F     |       OK           OK                Only on pin PA0
#            |
# -------------------------------------------------------------------
#            |
# SAMD21     |       OK           No               Mode not supported
#            |
# --------------------------------------------------------------------
#            |
# NXP K64    |       OK           OK               Only on WakeUp pins 
#            |
# --------------------------------------------------------------------
#            |
# ESP8266    |    Unsupported   Unsupported    Only works for Gpio 16
#            |
# --------------------------------------------------------------------



```
## Watchdogs


A basic example showing the watchdog functionalities in a Secure Fimrware enabled VM.


```main.py```

```python
################################################################################
# Watchdogs
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

##
## This example only works on a Secure Firmware enabled Virtual Machine!
##

import streams
# import the Secure Firmware module
# Check documentation here: https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_sfw.html
import sfw

streams.serial()

sleep(2000)

# Check for reset reason
try:
    print("Watchdog triggered:",sfw.watchdog_triggered())
except Exception as e:
    print("Watchdog not suppported by this Virtual Machine!")
    while True:
        sleep(1000)

# Do something without fearing a reset
for x in range(10):
    sleep(1000)
    print("Printing something for a while, no watchdog can reset me! 8‑D")



# Configure watchdog in normal mode with a 5 seconds timeout
print("Configuring watchdog to a 5 seconds timeout...")
sfw.watchdog(0,5000)
sleep(100)

# Kick the watchdog every second
for x in range(10):
    sleep(1000)
    sfw.kick()
    print("Kick!")
    
# Stop kicking and wait for reset
while True:
    print("Printing something for a while waiting for the watchdog! D-8")
    sleep(1000)
    
```
## VM Exceptions


This example explains how to set VM Options to handle uncaught exceptions



```main.py```

```python
################################################################################
# Zerynth VM Options
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import vm

streams.serial()

#let's set some VM options: uncomment the test you want to try, comment the others

#test 1: reset on uncaught exception and print trace (Default)
vm.set_option(vm.VM_OPT_RESET_ON_EXCEPTION,1)
vm.set_option(vm.VM_OPT_TRACE_ON_EXCEPTION,1)

#test 2: don't reset on uncaught exception but print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_EXCEPTION,0)
# vm.set_option(vm.VM_OPT_TRACE_ON_EXCEPTION,1)

#test 3: don't reset on uncaught exception and don't print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_EXCEPTION,0)
# vm.set_option(vm.VM_OPT_TRACE_ON_EXCEPTION,0)

#test 3: reset on uncaught exception but don't print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_EXCEPTION,1)
# vm.set_option(vm.VM_OPT_TRACE_ON_EXCEPTION,0)


def thread_fn_exc():
    for i in range(5):
        print("TH working",i)
        sleep(1000)
    x=1/0

# launch thread
thread(thread_fn_exc)

while True:
    sleep(2000)
    #let's print some VM info
    nfo = vm.info()
    print("--------------")
    print("VM uid ",nfo[0])
    print("Target ",nfo[1])
    print("Version",nfo[2])
    print("--------------")


```
## VM Hard Fault


This example explains how to set VM Options to manage Hard Faults



```main.py```

```python
################################################################################
# Zerynth VM Options
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################
import streams
import vm

streams.serial()

#let's set some VM options: uncomment the test you want to try, comment the others

#test 1: reset on hard fault and print trace (Default)
vm.set_option(vm.VM_OPT_RESET_ON_HARDFAULT,1)
vm.set_option(vm.VM_OPT_TRACE_ON_HARDFAULT,1)

#test 2: don't reset on hard fault but print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_HARDFAULT,0)
# vm.set_option(vm.VM_OPT_TRACE_ON_HARDFAULT,1)

#test 3: don't reset on hard fault and don't print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_HARDFAULT,0)
# vm.set_option(vm.VM_OPT_TRACE_ON_HARDFAULT,0)

#test 3: reset on hard faultbut don't print trace (Default)
# vm.set_option(vm.VM_OPT_RESET_ON_HARDFAULT,1)
# vm.set_option(vm.VM_OPT_TRACE_ON_HARDFAULT,0)


# here is a function that causes a hard fault by writing to NULL (in c)
@c_native("_hf_function",["hf.c"],[])
def armageddon():
    pass


while True:
    print("Releasing the Armageddon in 2 sec...:-@")
    sleep(2000)
    armageddon()

```

