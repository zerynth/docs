# Examples

The following are a list of examples for lib.microchip.mcp3208

## Thumbstick controller with MCP3204/3208


Read raw data from an MCP3204/3208 to get direction from a 2-axis thumbstick input device.


```main.py```

```python
################################################################################
# Thumbstick Example
#
# Created at 2017-08-25 06:56:04.499323
#
################################################################################

import streams

from microchip.mcp3208 import mcp3208


# x-axis potentiometer connected to MCP3204 channel 1
# y-axos potentiometer connected to MCP3204 channel 0
def get_x():
    return thumbstick.get_raw_data(True,1)
def get_y():
    return thumbstick.get_raw_data(True,0)


# read mid-point x and y values 
def calibrate():
    global mid_x, mid_y
    mid_x = get_x()
    mid_y = get_y()


# read x and y values and return a direction
def get_direction(thr=.2):
    x = get_x()
    y = get_y()
        
    m_x = abs(x-mid_x)/mid_x
    m_y = abs(y-mid_y)/mid_y
    
    if m_x < thr and m_y < thr:
        return 'center'
    
    if m_x > m_y:
        if x > mid_x:
            return 'right'
        else:
            return 'left'
    else:
        if y > mid_y:
            return 'down'
        else:
            return 'up'


streams.serial()

# create an instance of the MCP3208 class
thumbstick = mcp3208.MCP3208(SPI0,D17)

# calibrate the thumbstick 
calibrate()

# get and print thumbstick direction every 200 ms
while True:
    try:
        print(get_direction())
    except Exception as e:
        print(e)

    sleep(200)
```
