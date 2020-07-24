# Examples

The following are a list of examples for lib.worldsemi.ws2812.

## WS2812 RGB LEDs strip Basics and Animations


A simple example that shows how a button is used to change the colour of a WS2812 RGB LEDs strip — or NeoPixel in Adafruit parlance — and how a simple fade-like animation is played on the LEDs.


```main.py```

```python
################################################################################
# WS2812 LED Strips
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

# Be sure to open the serial console, otherwise the program will halt if the console buffer is full. 
import streams
from worldsemi.ws2812 import ledstrips as pixel
streams.serial()

num_leds = 16                     # adjust this to match the number of LEDs on your strip
led_pin = D9                      # this should match the data pin of the LED strip
switch_pin = D2                   # this should match the pin to which the button is connected

leds = pixel.LedStrip(led_pin, num_leds) # create a new WS2812 RGB LED strip composed of <num_leds> LEDs and connected to pin led_pin
leds.set_fading(100, 0, 0)        # create a fade effect that starts from red=100 and goes to RGB=0,0,0 
                                  # along all the available strip LEDs. This is a static setup of the LEDs
pos=0
  
def touch():    
    #function to be called when a button is touched  
    r = random(20, 100)    # choose a random colour for RED
    g = random(20, 100)    # choose a random colour for GREEN
    b = random(20, 100)    # choose a random colour for BLUE
    print(r, g, b)
    leds.set_fading(r, g, b, num_leds-1-pos) 


# attach a button to pin <switch_pin> and set an interrupt to call the touched function. The button should connect the pin to Vcc.
pinMode(switch_pin, INPUT_PULLDOWN)
onPinRise(switch_pin, touch)    
    
while True:
    leds.on()       # refresh the LEDs colour imposed by the animation
    leds.lshift()   # shift the LED colours of one position towards
    pos = (pos+1) % num_leds
    sleep(500)


```
## LED Strips Advanced


An advanced example showing some awesome features of Zerynth and the ledstrip module to drive WS2812 RGB Led strip — or NeoPixel in Adafruit parlance.

A complex animation (a pulsating background and two "snakes" moving in opposing directions) is performed with indipendent layers animated by threads. Before any ledstrip
update (the on() function) the layers are merged together to obtain the correct animation frame.

To avoid conflicts between threads, a lock is needed during layer modification phase.


```main.py```

```python
################################################################################
# WS2812 LED Strips Advanced
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import threading
from worldsemi.ws2812 import ledstrips as pixel

# create all the needed layers
leds = pixel.LedStrip(D6,16)
layer0 = pixel.LedStrip(D6,16)
layer1 = pixel.LedStrip(D6,16)
layer2 = pixel.LedStrip(D6,16)

# fill layers with their initial values
leds.clear()
layer0[0]=(100,0,0)
layer0[1]=(100,0,0)
layer0[2]=(100,0,0)
layer1[0]=(0,100,0)
layer1[1]=(0,100,0)
layer1[2]=(0,100,0)    
layer2.clear()

# let's define some coefficients for smooth animation (half a sinus wave)
animation_coefficients = [
    0,
    0.2588190451,
    0.5,
    0.7071067812,
    0.8660254038,
    0.9659258263,
    1,
    0.9659258263,
    0.8660254038,
    0.7071067812,
    0.5,
    0.2588190451]

# A Lock is needed to prevent conflicts between threads
lock = threading.Lock()

# Create a function to handle background animation
def animate_background(delay):
    step=0
    while True:
        lock.acquire()
        layer2.setall(0,0,int(50*animation_coefficients[step]))
        lock.release()
        step += 1
        if step >= len(animation_coefficients):
            step=0
        sleep(delay)

def animate_foreground(delay):
    while True:
        lock.acquire()
        layer0.lshift()
        layer1.rshift()
        lock.release()
        sleep(delay)

# start the background animation thread
thread(animate_background,500)
# start the foreground animation thread
thread(animate_foreground,50)


while True:
    # clear leds
    leds.clear()
    # now, acquire the lock
    lock.acquire()
    # merge the first and second layer
    leds.merge(layer0)
    leds.merge(layer1)
    # merge the background layer only where leds is transparent (0,0,0) 
    leds.merge(layer2,pixel.first_color)
    # release the lock
    lock.release()
    # and light it up!
    leds.on()
    sleep(10)
    
```
