# Examples

The following are a list of examples for lib.solomon.ssd1306.

## Draw a fading image


Draw an image and set the contrast alternately from max to min and from min to max gradually for fading




```main.py```

```python
################################################################################
# Draw a fading image Example
#
# Created: 2017-08-28 11:26:15.598712
#
################################################################################

import streams
streams.serial()

print("import")
sleep(1000)

from solomon.ssd1306 import ssd1306

print("start")
sleep(1000)

import zLogo

try:
    # Setup display
 
    # The ssd1306 can use either the spi or the i2c interface
    # the flag SSD1306SPI enables the spi interface
    # the flag SSD1306I2C enables the i2c interface
    # those two flags can't be set both to true 

    ssd = None

    #-if SSD1306SPI
    # This setup is referred to ssd1306 mounted on slot A of a Flip n Click device
    ssd = ssd1306.SSD1306(SPI0,D17,D16,D6)
    #-else
    ##-if SSD1306I2C
    # This setup is referred to ssd1306 mounted on a XinaBox CW02
    ssd = ssd1306.SSD1306(I2C0)
    ##-endif
    #-endif
    ssd.init()
    ssd.on()
    ssd.clear()
    
    #draw zlogo
    ssd.draw_img(zLogo.zz,32,4,32,32)
except Exception as e:
    print("Error1", e)

while True:
    try:
        #fade the screen
        for i in range(0,256):
            ssd.set_contrast(i)
            sleep(2)
        for i in range(0,256):
            ssd.set_contrast(255-i)
            sleep(2)
    except Exception as e:
        print(e)
```
## Draw text on oled Display


Print a string inside a text box on b/w oled display with different alignments.



```main.py```

```python
################################################################################
# Print string on bw oled display Example
#
# Created: 2017-08-28 12:21:52.459874
#
################################################################################

import streams
streams.serial()

print("import")
sleep(1000)

from solomon.ssd1306 import ssd1306

print("start")
sleep(1000)

try:
    # Setup display 

    # The ssd1306 can use either the spi or the i2c interface
    # the flag SSD1306SPI enables the spi interface
    # the flag SSD1306I2C enables the i2c interface
    # those two flags can't be set both to true 

    ssd = None

    #-if SSD1306SPI
    # This setup is referred to ssd1306 mounted on slot A of a Flip n Click device
    ssd = ssd1306.SSD1306(SPI0,D17,D16,D6)
    #-else
    ##-if SSD1306I2C
    # This setup is referred to ssd1306 mounted on a XinaBox CW02
    ssd = ssd1306.SSD1306(I2C0)
    ##-endif
    #-endif
    
    ssd.init()
    ssd.on()
except Exception as e:
    print("Error1", e)

while True:
    try:
        ssd.clear()
        sleep(1000)
        count = 0
        for i in [3,2,1]:
            ssd.draw_text("Zerynth",0,14*count,96,12, align=i)
            sleep(1000)
            count += 1
        ssd.fill_screen()
        sleep(1000)
        count = 0
        for i in [1,2,3]:
            ssd.draw_text("Hello Zerynth",0,14*count,96,12, align=i, fill=False)
            sleep(1000)
            count += 1
        ssd.invert()
        sleep(1000)
        ssd.normal()
        sleep(1000)
    except Exception as e:
        print(e)
```
