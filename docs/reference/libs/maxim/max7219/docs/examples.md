# Examples

The following are a list of examples for lib.maxim.max7219.

## LED Matrix


Basic Example of MAX7219 usage for drawing maxi numbers on a 8x8 led matrix display



```main.py```

```python
################################################################################
# Led Matrix Display Example
#
# Created: 2017-02-24 12:48:43.342375
#
################################################################################

import streams
# import MAX7219 library to handle 8x8 led matrix
from maxim.max7219 import max7219
# import fonts file where matrix numbers are defined
import fonts
 
# Create a serial console
streams.serial()

# Setup Led Matrix (8x8 Click on slot A of a Flip n Click device)
display = max7219.MAX7219(SPI0, D17)

# counter variable
num = 0
 
display.shutdown(False)
 
intensity = 9
display.set_intensity(intensity)

while True:
    for num in range(10):
        # increment the intensity
        intensity += 1
        if intensity > 15:
            intensity = 0
        display.set_intensity(intensity)
        print("Display Number:", num, " with light intensity:", intensity)
        
        # print the maxi number on led matrix
        for row in range(8):
            for col in range(8):
                if fonts.numbers[num][row][col]:
                    display.set_led(row, col, 1)
                else:
                    display.set_led(row, col, 0)
        sleep(2000)
        
    # Test print row and print column
    display.clear_display()
    print("Reload...")
    display.set_row(1,1)
    sleep(500)
    display.set_column(1,1)
    sleep(500)
    display.set_row(6,1)
    sleep(500)
    display.set_column(6,1)
    sleep(500)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI4ODA5NjExMV19
-->
