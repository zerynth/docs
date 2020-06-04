# Examples

The following are a list of examples for lib.solomon.ssd1351

## Draw a blinking image


Draw an image and set the contrast alternately to max and min values for blinking




```main.py```

```python
################################################################################
# Draw a blinking image Example
#
# Created: 2017-03-10 15:12:44.433654
#
################################################################################

import streams
streams.serial()

print("import")
sleep(1000)

from solomon.ssd1351 import ssd1351

print("start")
sleep(1000)

import zLogo

try:
    # Setup display 
    # This setup is referred to ssd1351 mounted on Hexiwear device 
    ssd = ssd1351.SSD1351(SPI0,D57,D58,D59,D71)
    ssd.init(96,96)
    ssd.on()
    ssd.fill_screen(color=0x4471, encode=False)
    
    #draw zlogo
    ssd.draw_img(zLogo.zz, 8,8,80,80)
except Exception as e:
    print("Error1", e)

while True:
    #blink the screen
    ssd.set_contrast(0)
    sleep(1000)
    ssd.set_contrast(255)
    sleep(1000)
```
## Print on oled Display


Print a string inside a text box on color oled display with different alignments



```main.py```

```python
################################################################################
# Print string on oled display Example
#
# Created: 2017-03-10 16:29:12.145521
#
################################################################################

import streams
streams.serial()

print("import")
sleep(1000)

from solomon.ssd1351 import ssd1351

print("start")
sleep(1000)

try:
    # Setup display 
    # This setup is referred to ssd1351 mounted on Hexiwear device 
    ssd = ssd1351.SSD1351(SPI0,D57,D58,D59,D71)
    ssd.init(96,96)
    ssd.on()
except Exception as e:
    print("Error1", e)

while True:
    ssd.fill_screen(color=0xFFFF00)
    sleep(1000)
    ssd.draw_text("Hello Zerynth",0,0,96,24, color=0xFFFF, align=3, background=0x4471, encode=False)
    sleep(1000)
    ssd.draw_text("Hello Zerynth",0,24,96,24, color=0x4471, align=1, background=0xFFFF, encode=False)
    sleep(1000)
    ssd.draw_text("Hello Zerynth",0,48,96,24, color=0x4471, align=2, background=0x0000, encode=False)
    sleep(1000)
    ssd.draw_text("Hello Zerynth",0,72,96,24, color=0x0000, align=3, background=0x4471, encode=False)
    sleep(1000)
```
