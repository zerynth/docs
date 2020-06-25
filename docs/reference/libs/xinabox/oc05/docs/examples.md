# Examples

The following are a list of examples for lib.xinabox.oc05.

## Servo Position


This example positions a servo motor on channel 1 90° to the left and right from a centre reference point according to a user input. The serial console accepts 'l', 'r' and 'c' for left, right and centre respectively.



```main.py```

```python
###############################################
#   This is an example for the OC05 8-channel
#   servo driver.
#
#   A servo on channel 1 is positioned according
#   to a desired degree of rotation.
###############################################

import streams
from xinabox.oc05 import oc05

# create a serial console
s=streams.serial()

# OC05 instance
OC05 = oc05.OC05(I2C0)

# configure OC05 with frequency of 60Hz
OC05.init(60)

while True:
    print('SERVO CONTROL:')
    print('Enter \'l\' for left and press enter')
    print('Enter \'r\' for right and press enter')
    print('Enter \'c\' for centre and press enter')
    print()
    dir=s.readline()
    print(dir)
    if dir == 'l\n':
        OC05.setServoPosition(1, 0)     # position servo to the left 
        print('LEFT')
    elif dir == 'r\n':
        OC05.setServoPosition(1, 180)   # position servo to the right
        print('RIGHT')
    elif dir == 'c\n':
        OC05.setServoPosition(1, 90)    # position servo in the centre
        print('CENTRE')
    else:
        print('Please input a valid direction')

```
