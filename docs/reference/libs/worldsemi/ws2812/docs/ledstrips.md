# WS2812 RGB Led Module

This module implements the Zerynth driver for the Worldsemi WS2812 Intelligent Control RGB Led assembled in any form, ledstrip, or ring.
([datasheet](http://www.world-semi.com/DownLoadFile/108)).


### ws2812.ledstrips.add_color(r1, g1, b1, r2, g2, b2)
Returns a tuple (r,g,b) where r=r1+r2, g=g1+g2, b=b1+b2. In case of overflow, components are capped to 255


### ws2812.ledstrips.first_color(r1, g1, b1, r2, g2, b2)
Always returns (r1,g1,b1) unless all the components are zero. In that case it returns (r2,g2,b2)


### ws2812.ledstrips.second_color(r1, g1, b1, r2, g2, b2)
Always returns (r2,g2,b2) unless all the components are zero. In that case it returns (r1,g1,b1)

## LedStrip class


### class ws2812.ledstrips.LedStrip(pin, nleds)
This class abstracts a ledstrip. It needs to know which ```pin``` the ledstrip is wired to and how many leds it is composed of (```nleds```).
The ```pin``` is automatically set to the correct mode and initially set to zero.


### ws2812.ledstrips.on()
Turns on the ledstrip, colouring each led with the configuration set with methods like `set()`.


### ws2812.ledstrips.set(n, r, g, b)
Sets the ```nth``` led of the strip to the ```r```, ```g```, ```b``` color specified. The led will change color only after the next call to `on()`.

An equivalent and valid syntax is ledstrip[n]=(r,g,b).


### ws2812.ledstrips.setall(r, g, b)
Sets all the leds of the strip to the ```r```, ```g```, ```b``` color specified. The led will change color only after the next call to `on()`.


### ws2812.ledstrips.clear()
Sets all the leds of the strip to off. The leds will turn off after the next call to `on()`.


### ws2812.ledstrips.lshift()
Shifts to the left all the leds by one. The leds will change color only after the next call to `on()`.


### ws2812.ledstrips.rshift()
Shifts to the right all the leds by one. The leds will change color only after the next call to `on()`.


### ws2812.ledstrips.brightness(brt)
Multiplies all the led color by ```brt```, a float between 0 and 1. The leds will change color only after the next call to `on()`.


### ws2812.ledstrips.merge(lstrip, fun=add_color)
Merges ```lstrip``` with the current strip (```self```).
The resulting colors are calculated by applying ```fun``` to every corresponding pair of leds in the ledstrips.

The signature of fun must be *fun(r1,g1,b1,r2,b2,g2)* where r1,g1,b1 are the color components of the first strip
and r2,g2,b2 are the color components of the second strip. The default ```add_color``` sums colors component by component.

Merging strips is very useful for animations. Indeed one can build different layers on different strips, animate them
separately and merge them in one single strip to be showed.
